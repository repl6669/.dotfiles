#!/bin/bash
# Claude Code status line - repl69 grayscale family (mirrors ~/.config/starship.toml)
# Shows: directory | git branch + compact status + line diff | model name

input=$(cat)

cwd=$(printf '%s' "$input" | jq -r '.cwd')
model=$(printf '%s' "$input" | jq -r '.model.display_name')

# repl69 palette. $'...' so these hold real ESC bytes rather than the
# two-character sequence \033 — the colours end up inside printf ARGUMENTS
# (%s), where a literal \033 would never be interpreted and would print as
# visible garbage.
C_DIR=$'\033[38;2;194;194;194m'     # three  #c2c2c2 - directory
C_GIT=$'\033[38;2;153;153;153m'     # six    #999999 - branch / status
C_GREEN=$'\033[38;2;9;170;111m'     #        #09aa6f - added lines
C_ORANGE=$'\033[38;2;192;65;0m'     #        #c04100 - deleted lines
C_MODEL=$'\033[38;2;112;112;112m'   # four   #707070 - model name
RESET=$'\033[0m'

# ---- directory: mirrors [directory] (truncation_length=4, "…/" symbol, icon substitutions) ----
# The ~ MUST be escaped. Unquoted, bash tilde-expands the replacement back
# to $HOME, so the substitution silently becomes a no-op and the path shows
# as "Users/theimer/..." instead of "~/...".
dir="${cwd/#$HOME/\~}"
IFS='/' read -ra parts <<< "$dir"
clean=()
for p in "${parts[@]}"; do
  [ -n "$p" ] && clean+=("$p")
done
prefix=""
if [ "${#clean[@]}" -gt 4 ]; then
  clean=("${clean[@]: -4}")
  prefix="…/"
fi
out=""
for p in "${clean[@]}"; do
  case "$p" in
    Documents) p="󰈙" ;;
    Downloads) p="" ;;
    Music) p="󰝚" ;;
    Pictures) p="" ;;
    Developer) p="󰲋" ;;
  esac
  out="$out/$p"
done
dir_display="${prefix}${out#/}"
# "/" splits into no segments at all, which would render a blank status
# line. Starship shows the root as "/", so match it.
[ -z "$dir_display" ] && dir_display="/"

# ---- git branch + compact status (single --no-optional-locks call, no dependency on starship) ----
git_segment=""
if status_out=$(git -C "$cwd" --no-optional-locks status --porcelain=v2 --branch 2>/dev/null) && [ -n "$status_out" ]; then
  branch="?"
  ahead=0; behind=0; staged=0; modified=0; untracked=0; deleted=0; renamed=0; conflicted=0
  while IFS= read -r line; do
    case "$line" in
      "# branch.head "*)
        branch="${line#\# branch.head }"
        ;;
      "# branch.ab "*)
        rest="${line#\# branch.ab +}"
        ahead="${rest%% -*}"
        behind="${rest##* -}"
        ;;
      "1 "*)
        xy="${line:2:2}"; x="${xy:0:1}"; y="${xy:1:1}"
        if [ "$x" = "D" ] || [ "$y" = "D" ]; then
          deleted=$((deleted + 1))
        else
          [ "$x" != "." ] && staged=$((staged + 1))
          [ "$y" != "." ] && modified=$((modified + 1))
        fi
        ;;
      "2 "*)
        xy="${line:2:2}"; x="${xy:0:1}"; y="${xy:1:1}"
        renamed=$((renamed + 1))
        [ "$x" != "." ] && staged=$((staged + 1))
        [ "$y" != "." ] && modified=$((modified + 1))
        ;;
      "u "*) conflicted=$((conflicted + 1)) ;;
      "? "*) untracked=$((untracked + 1)) ;;
    esac
  done <<< "$status_out"

  status_str=""
  [ "$modified" -gt 0 ] && status_str="${status_str}!${modified}"
  [ "$staged" -gt 0 ] && status_str="${status_str}+${staged}"
  [ "$untracked" -gt 0 ] && status_str="${status_str}?${untracked}"
  [ "$deleted" -gt 0 ] && status_str="${status_str}✘${deleted}"
  [ "$renamed" -gt 0 ] && status_str="${status_str}»${renamed}"
  [ "$conflicted" -gt 0 ] && status_str="${status_str}≠${conflicted}"
  [ "$ahead" -gt 0 ] && status_str="${status_str}⇡${ahead}"
  [ "$behind" -gt 0 ] && status_str="${status_str}⇣${behind}"
  [ -z "$status_str" ] && status_str="✓"

  # added/deleted line counts, mirrors [git_metrics] - the only accent colors
  metrics=""
  if diffstat=$(git -C "$cwd" --no-optional-locks diff --shortstat HEAD 2>/dev/null) && [ -n "$diffstat" ]; then
    added=$(printf '%s' "$diffstat" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    deld=$(printf '%s' "$diffstat" | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+')
    # only_nonzero_diffs = true in the starship config. A binary-only change
    # reports "1 file changed, 0 insertions(+), 0 deletions(-)", so a
    # non-empty check alone would render a pointless "+0 -0".
    [ "${added:-0}" -gt 0 ] 2>/dev/null && metrics="${C_GREEN}+${added}${RESET}"
    if [ "${deld:-0}" -gt 0 ] 2>/dev/null; then
      [ -n "$metrics" ] && metrics="${metrics} "
      metrics="${metrics}${C_ORANGE}-${deld}${RESET}"
    fi
  fi

  git_segment="${C_GIT} ${branch} ${status_str}${RESET}"
  [ -n "$metrics" ] && git_segment="${git_segment} ${metrics}"
fi

line="${C_DIR} ${dir_display} ${RESET}"
[ -n "$git_segment" ] && line="${line}${git_segment} "
line="${line}${C_MODEL}${model}${RESET}"

# %s, not a variable-built format string: a directory or branch name
# containing a % would otherwise be read as a printf conversion.
printf '%s\n' "$line"
