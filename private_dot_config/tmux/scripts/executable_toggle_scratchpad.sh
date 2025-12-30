#!/usr/bin/env bash
set -euo pipefail

scratch_name="scratchpad"

current_pane=$(tmux display-message -p '#{pane_id}')
current_window=$(tmux display-message -p '#{window_id}')

# If scratchpad window exists, get its id
scratch_id=$(tmux list-windows -F '#{window_id} #{window_name}' | awk -v name="$scratch_name" '$2==name{print $1; exit}')

if [[ -n "$scratch_id" ]]; then
  if [[ "$current_window" == "$scratch_id" ]]; then
    # We're on scratchpad; jump back to last pane if stored
    last_pane=$(tmux show -gqv '@scratchpad_last_pane')
    if [[ -n "$last_pane" ]]; then
      tmux switch-client -t "$last_pane" || true
    else
      tmux last-window || true
    fi
    exit 0
  fi

  # store current pane and jump to scratchpad
  tmux set -g @scratchpad_last_pane "$current_pane"
  tmux switch-client -t "$scratch_id"
  exit 0
fi

# No scratchpad yet: create one
# Store current pane so we can return
[[ -n "$current_pane" ]] && tmux set -g @scratchpad_last_pane "$current_pane"

# Create window named scratchpad in current session
new_id=$(tmux new-window -P -F '#{window_id}' -n "$scratch_name")

# If creation failed, do nothing
[[ -z "$new_id" ]] && exit 0

# Switch to the new scratchpad window
 tmux switch-client -t "$new_id"
