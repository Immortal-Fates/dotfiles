#!/usr/bin/env bash
set -euo pipefail

# hide entire right status if terminal width is below threshold
min_width=${TMUX_RIGHT_MIN_WIDTH:-90}
width=$(tmux display-message -p '#{client_width}' 2>/dev/null || true)
if [[ -z "${width:-}" || "$width" == "0" ]]; then
  width=$(tmux display-message -p '#{window_width}' 2>/dev/null || true)
fi
if [[ -z "${width:-}" || "$width" == "0" ]]; then
  width=${COLUMNS:-}
fi
if [[ -n "${width:-}" && "$width" =~ ^[0-9]+$ ]]; then
  if (( width < min_width )); then
    exit 0
  fi
fi

status_bg=$(tmux show -gqv status-bg)
if [[ -z "$status_bg" || "$status_bg" == "default" ]]; then
  status_bg="#1a1b26"
fi

segment_bg="#24283b"
segment_fg="#a9b1d6"
separator=""
right_cap="█"
host_bg="#6f8fc7"
host_fg="#1a1b26"
hostname=$(hostname -s 2>/dev/null || hostname 2>/dev/null || printf 'host')

# --- NET only ---
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-right"
mkdir -p "$cache_dir"

net_file="$cache_dir/net"

default_iface() {
  local iface
  iface=$(ip route show default 2>/dev/null | awk '/default/ {print $5; exit}')
  if [[ -z "$iface" ]]; then
    iface=$(awk -F: '$1 !~ /lo/ {gsub(/^[ \t]+/, "", $1); print $1; exit}' /proc/net/dev 2>/dev/null)
  fi
  printf '%s' "$iface"
}

format_rate() {
  local bytes="$1"
  if (( bytes < 1024 )); then
    printf '%dB/s' "$bytes"
  elif (( bytes < 1048576 )); then
    printf '%.1fK/s' "$(awk "BEGIN {print $bytes/1024}")"
  elif (( bytes < 1073741824 )); then
    printf '%.1fM/s' "$(awk "BEGIN {print $bytes/1048576}")"
  else
    printf '%.1fG/s' "$(awk "BEGIN {print $bytes/1073741824}")"
  fi
}

net_rate() {
  local iface rx tx now prev_ts prev_rx prev_tx dt rx_rate tx_rate
  iface=$(default_iface)
  [[ -z "$iface" ]] && { printf '0B/s 0B/s'; return; }
  read -r rx tx < <(awk -v dev="$iface" -F: '$1 ~ dev {gsub(/^[ \t]+/, "", $2); split($2,a," "); print a[1], a[9]}' /proc/net/dev 2>/dev/null)
  rx=${rx:-0}
  tx=${tx:-0}
  now=$(date +%s)
  if [[ -f "$net_file" ]]; then
    read -r prev_ts prev_rx prev_tx <"$net_file" || true
    dt=$((now - prev_ts))
    if (( dt > 0 )); then
      rx_rate=$(( (rx - prev_rx) / dt ))
      tx_rate=$(( (tx - prev_tx) / dt ))
    else
      rx_rate=0
      tx_rate=0
    fi
  else
    rx_rate=0
    tx_rate=0
  fi
  printf '%s %s\n' "$now" "$rx" "$tx" >"$net_file"
  printf 'Rx %s  Tx %s' "$(format_rate "${rx_rate:-0}")" "$(format_rate "${tx_rate:-0}")"
}

net=$(net_rate)
net_text="NET ${net}"
net_segment=$(printf '#[fg=%s,bg=%s]%s#[fg=%s,bg=%s] %s ' \
  "$segment_bg" "$status_bg" "$separator" \
  "$segment_fg" "$segment_bg" "$net_text")

host_segment=$(printf '#[fg=%s,bg=%s]%s#[fg=%s,bg=%s] %s ' \
  "$host_bg" "$segment_bg" "$separator" \
  "$host_fg" "$host_bg" "$hostname")

printf '%s%s#[fg=%s,bg=%s]%s' \
  "$net_segment" \
  "$host_segment" \
  "$host_bg" "$status_bg" "$right_cap"
