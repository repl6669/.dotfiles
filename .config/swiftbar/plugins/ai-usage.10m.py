#!/usr/bin/python3
# <swiftbar.title>AI usage</swiftbar.title>
# <swiftbar.desc>Claude Code usage limits, from ../bin/ai-usage</swiftbar.desc>
# <swiftbar.version>1.0</swiftbar.version>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>true</swiftbar.hideSwiftBar>
"""SwiftBar menu bar item for Claude Code usage limits.

Adapted from github.com/crossatko/dotfiles (config/swiftbar). Runs the helper (../bin/ai-usage, JSON on
stdout) and renders it; the meter bars are Menlo text, coloured macOS system orange. Chip value = the 5h window of
the most recently used account whose values are fresh (else the most recent one, dimmed); at 100 % the reset
countdown instead. SwiftBar's PATH is minimal, so interpreters are given by absolute path.
"""
import json
import os
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.realpath(__file__))
HELPER = os.path.join(HERE, "..", "bin", "ai-usage")
PY = next((p for p in ("/opt/homebrew/bin/python3", "/usr/local/bin/python3", "/usr/bin/python3") if os.path.exists(p)), sys.executable)
NOW = time.time()

# ---- colours: macOS system colours, (light, dark) pairs for SwiftBar's color=light,dark ----------------------
C_FG = "#1d1d1f,#f5f5f7"          # labelColor
C_DIM = "#6e6e73,#98989d"         # secondaryLabelColor
C_MUTED = "#8e8e93,#636366"       # tertiaryLabelColor
C_ORANGE = "#ff9500,#ff9f0a"      # systemOrange
C_RED = "#ff3b30,#ff453a"         # systemRed
C_ACCENT = C_ORANGE
# ---- formatting -------------------------------------------------------------------------------------------------
def until(t):
    s = max(0, t - NOW)
    if s < 60:
        return "now"
    d, h, m = int(s // 86400), int(s % 86400 // 3600), int(s % 3600 // 60)
    return "%dd %dh" % (d, h) if d else "%dh %dm" % (h, m) if h else "%dm" % m


def ago(t):
    s = max(0, NOW - t)
    return "just now" if s < 90 else "%d min ago" % round(s / 60) if s < 5400 else "%d h ago" % round(s / 3600) if s < 172800 else "%d d ago" % round(s / 86400)


def compact(n):
    return "%.1fB" % (n / 1e9) if n >= 1e9 else "%.1fM" % (n / 1e6) if n >= 1e6 else "%dk" % round(n / 1e3) if n >= 1e4 else "%.1fk" % (n / 1e3) if n >= 1e3 else str(n)


def stats_line(s):
    if not s:
        return ""
    return "%d %s · %s tokens" % (s["messages"], "msg" if s["messages"] == 1 else "msgs", compact(s["input"] + s["output"])) \
        + (" · %s cached" % compact(s["cacheRead"]) if s.get("cacheRead", 0) > 0 else "")


def minutes(w):
    key, title = str(w.get("key") or ""), str(w.get("title") or "").lower()
    detail = str(w.get("detail") or "").lower()
    if key == "five_hour" or detail.startswith(("5-hour", "5h")):
        return 300
    if key.startswith("seven_day") or detail.startswith("7d"):
        return 10080
    return {"session": 300, "daily": 1440, "weekly": 10080, "monthly": 43200}.get(title, 0)


def pct(w):
    return isinstance(w.get("percent"), (int, float))


def clip(s, n):
    return s if len(s) <= n else s[:n - 1] + "…"


def line(text, **kw):
    text = str(text).replace("|", "¦").replace("\n", " ")
    print(text + (" | " + " ".join("%s=%s" % kv for kv in kw.items()) if kw else ""))


MENLO = {"font": "Menlo", "size": 11, "trim": "false"}


def limit(w, stale, reset=None, title=None, detail=None):
    """AiLimit: 'Session  5-hour window  resets in 2h 14m  62%' over a meter."""
    t = title if title is not None else w.get("title", "")
    dt = detail if detail is not None else w.get("detail", "")
    rs = reset if reset is not None else ("resets in " + until(w["resetsAt"]) if w.get("resetsAt") else "")
    txt = "%-7s %-14s %-16s %4s" % (clip(t, 7), clip(dt, 14), rs, "%d%%" % round(w["percent"]))
    line(txt, **dict(MENLO, color=C_DIM if stale else C_FG))
    cells = len(txt)
    n = max(0, min(100, w["percent"])) / 100.0 * cells
    fill = min(cells, max(1 if w["percent"] > 0 else 0, int(n + 0.5)))
    line("█" * fill + "░" * (cells - fill), **dict(MENLO, color=C_MUTED if stale else C_RED if w["percent"] >= 100 else C_ACCENT))


STATUS_ICON = {"expired": "exclamationmark.triangle", "paused": "exclamationmark.triangle", "forbidden": "exclamationmark.triangle",
               "error": "exclamationmark.octagon", "nologin": "person.crop.circle.badge.exclamationmark",
               "offline": "wifi.slash", "ratelimited": "clock.badge.exclamationmark", "apikey": "key"}


def status_color(s):
    return C_ORANGE if s in ("expired", "paused", "forbidden") else C_RED if s == "error" else C_DIM


def main():
    try:
        r = subprocess.run([PY, "-I", HELPER] + (["--force"] if os.environ.get("SWIFTBAR_PLUGIN_REFRESH_REASON") == "MenuAction" else []),
                           capture_output=True, text=True, timeout=60)
        d = json.loads(r.stdout)
    except (OSError, subprocess.SubprocessError, ValueError):
        line("AI ?", sfimage="sparkles", color=C_DIM)
        print("---")
        line("ai-usage helper failed", sfimage="exclamationmark.octagon", color=C_RED)
        line("Refresh", refresh="true", sfimage="arrow.clockwise")
        return
    profiles = d.get("profiles") or []

    # ---- menu bar title: 5h window of the most recently used fresh account ----
    cand = [p for p in profiles if any(pct(w) for w in p.get("windows") or [])]
    cand.sort(key=lambda p: -(p.get("lastUsed") or 0))
    cur = next((p for p in cand if not p.get("stale")), cand[0] if cand else None)
    if cur:
        ws = sorted((w for w in cur["windows"] if pct(w)), key=lambda w: (minutes(w) or 1e9, w.get("resetsAt") or 1e12))
        blocked = max([w["resetsAt"] for w in cur["windows"] if pct(w) and w["percent"] >= 100 and (w.get("resetsAt") or 0) > NOW] or [0])
        text = until(blocked) if blocked else "%d%%" % round(ws[0]["percent"])
        if cur.get("stale") is True:
            line(text, sfimage="sparkles", color=C_DIM)
        else:
            line(text, sfimage="sparkles")
    else:
        line("AI", sfimage="sparkles", color=C_DIM)

    # ---- dropdown ----
    print("---")
    line("AI usage", size=13, font="Helvetica-Bold", color=C_FG)
    if not profiles:
        line("No Claude profiles found", sfimage="person.crop.circle.badge.questionmark", font="Helvetica-Bold", color=C_FG)
        line("Looked for ~/.claude* directories (one per CLAUDE_CONFIG_DIR).", color=C_DIM, size=11)
        line("Run claude and log in, then refresh.", color=C_DIM, size=11)
    else:
        print("---")
        line("Claude Code   %d %s" % (len(profiles), "profile" if len(profiles) == 1 else "profiles"), color=C_MUTED, size=11)
    for p in profiles:
        stale = p.get("stale") is True
        print("---")
        line(p.get("label") or p["dir"], font="Helvetica-Bold", size=13, color=C_FG)
        if p.get("plan"):
            line(p["plan"], color=C_ACCENT, font="Helvetica-Bold", size=11, sfimage="checkmark.seal")
        sub = "  ·  ".join(x for x in ("~/" + p["dir"] if p.get("label") != p["dir"] else "", p.get("org") or "") if x)
        if sub:
            line(sub, color=C_MUTED, size=11)
        if p.get("message"):
            st = p.get("status")
            line(p["message"], color=status_color(st), size=12, sfimage=STATUS_ICON.get(st, "info.circle"))
        for w in p.get("windows") or []:
            if pct(w):
                limit(w, stale)
        ex = p.get("extra")
        if isinstance(ex, dict) and isinstance(ex.get("percent"), (int, float)):
            det = "%.2f / %.2f %s" % (ex["used"], ex["limit"], ex.get("currency") or "") if ex.get("used") is not None and ex.get("limit") is not None else ""
            limit({"percent": ex["percent"]}, stale, reset="monthly", title="Extra", detail=det)
        loc = p.get("local")
        if loc and not p.get("windows"):
            line("Local estimate · session logs" + (" (still counting)" if loc.get("partial") else ""), color=C_DIM, size=11)
            line("%-8s%s" % ("Today", stats_line(loc.get("today"))), **dict(MENLO, color=C_FG))
            line("%-8s%s" % ("7 days", stats_line(loc.get("week"))), **dict(MENLO, color=C_FG))
        if p.get("fetchedAt") and p.get("windows"):
            line("updated " + ago(p["fetchedAt"]), color=C_MUTED, size=10)
    print("---")
    line("Updated %s" % time.strftime("%H:%M", time.localtime(d.get("generatedAt") or NOW)), color=C_MUTED, size=11)
    line("Refresh", refresh="true", sfimage="arrow.clockwise")


main()
