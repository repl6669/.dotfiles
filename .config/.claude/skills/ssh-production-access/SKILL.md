---
name: ssh-production-access
description: Use when SSH access to a production server is available or requested — diagnosing incidents, checking logs, analyzing slow queries, "check on production", or any task that reaches a prod host over SSH.
---

# SSH Production Access

## Overview

Two independent guardrails, both always in force: (1) only read-only/diagnostic commands are ever allowed on production, and (2) every single command — no matter how safe it looks — requires the user's explicit go-ahead in the current conversation before it runs. Neither guardrail substitutes for the other.

**A blanket "I trust your judgment" does not carry forward.** It sets scope (what kind of thing you may check), not a standing waiver of asking. Ask before every command, every time, regardless of urgency, prior approval, or how obviously safe it looks.

## Read-only whitelist

Allowed to propose (still requires per-command approval — see below):
- Status/process: `SHOW PROCESSLIST`, `SHOW STATUS`, `SHOW VARIABLES`, `uptime`, `free -m`, `df -h`, non-interactive `top`/`htop` snapshots
- Query analysis: `EXPLAIN`, `EXPLAIN ANALYZE`, `SELECT` against `performance_schema` / `information_schema` / `sys`
- Logs: `tail`, `less`, `grep` on log files
- Config inspection: read-only `cat`/`grep` of config files

Never propose as routine, even if "just this once" or "technically read-only-adjacent":
- Any `SET GLOBAL`, `TRUNCATE`, `DELETE`, `DROP`, `ALTER`, `UPDATE`, `INSERT`, `GRANT`/`REVOKE`
- Service control: restart/stop/reload of mysqld, mariadb, php-fpm, web server, queue workers
- Anything that writes to disk, rotates logs, kills processes, modifies files, or installs packages

If a real diagnostic need requires a state-changing step (e.g. `SET GLOBAL slow_query_log = 'ON'`), surface it explicitly as "this one changes server state" and wait for approval like anything else — it does not fall under a read-only fast path.

## Ask-first protocol

1. State the exact command(s) you intend to run, in order, and why.
2. Wait for an explicit go-ahead on *that* message before running anything.
3. Batching several read-only commands together is fine — but list the batch and get one explicit yes before the first command runs.
4. If the user is unavailable (AFK, no response), the answer is to wait and stand by — not to act on an earlier general permission. Urgency changes how fast you follow up once they respond, not whether you ask.

## Rationalization table

| Excuse | Reality |
|---|---|
| "They said they trust my judgment on read-only stuff" | That set scope, not a waiver. Still ask, every time. |
| "It's an emergency, seconds matter" | Stating the command and waiting takes seconds too. Urgency justifies a fast follow-up, not skipping approval. |
| "It's just a SELECT / just a read" | Read-only is necessary, not sufficient. Still ask. |
| "I already asked about checking prod earlier this session" | That covered a category. Ask per command, now. |
| "The user is AFK, I should just handle it" | Wait. State what you'd do and stand by — don't act on their behalf without a response. |
| "I'll batch commands so I'm not asking repeatedly" | Batch them in the ask — get one yes for the listed batch, then run it. |

## Red flags — stop and ask instead

- About to call a tool that reaches the production host, and no explicit approval for *this* command exists in the current turn
- The command falls outside the read-only whitelist above
- Feeling time pressure to "just handle it"
- Any internal narrative like "they'd want me to" or "this is obviously fine, no need to check"

## Quick reference

| Situation | Allowed to propose? | Runs without asking first? |
|---|---|---|
| `SHOW PROCESSLIST`, `EXPLAIN`, log `tail` | Yes | **Never** |
| `SET GLOBAL`, restarts, writes, installs | Only as a flagged, explicit ask | **Never** |
| User said "check on prod" generally, 20 minutes ago | N/A | **Never** — re-confirm the specific command now |
