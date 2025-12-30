#!/usr/bin/env bash
set -euo pipefail

# Open Codex CLI in a tmux popup (fallback to new window if popup unsupported)

pane_path=$(tmux display-message -p '#{pane_current_path}')
repo_root=$(git -C "$pane_path" rev-parse --show-toplevel 2>/dev/null || true)
workdir="${repo_root:-$pane_path}"

# Build command
cmd="cd \"$workdir\" && codex"

if tmux display-message -p '#{version}' >/dev/null 2>&1; then
  # Check popup support (tmux 3.2+)
  if tmux display-popup -E "true" >/dev/null 2>&1; then
    tmux display-popup -E -d "$workdir" -w 90% -h 80% -T "Codex" "bash -lc '$cmd'"
    exit 0
  fi
fi

# Fallback: open in new window
 tmux new-window -n "codex" -c "$workdir" "bash -lc '$cmd'"
