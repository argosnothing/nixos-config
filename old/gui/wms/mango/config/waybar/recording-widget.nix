{pkgs}:
pkgs.writeShellScriptBin "rec-widget" ''
  #!/usr/bin/env bash
  set -euo pipefail
  pidfile="''${XDG_CACHE_HOME:-$HOME/.cache}/wf-recorder.pid"
  start_cmd="''${START_CMD:-record-region-start}"
  stop_cmd="''${STOP_CMD:-record-region-stop}"
  play=$'\uf04b'
  pause=$'\uf04c'

  have_pid() { [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; }
  scan_pid() {
    pgrep -u "''${USER}" -x wf-recorder | tail -n1
  }
  sync_pid() {
    if have_pid; then return 0; fi
    p="$(scan_pid || true)"
    if [ -n "''${p:-}" ]; then printf '%s' "$p" > "$pidfile"; return 0; fi
    return 1
  }

  is_on() { have_pid || sync_pid; }

  wait_on() {
    for _ in $(seq 1 80); do
      if is_on; then return 0; fi
      sleep 0.05
    done
    return 1
  }

  wait_off() {
    for _ in $(seq 1 80); do
      if ! is_on; then return 0; fi
      sleep 0.05
    done
    return 1
  }

  status() {
    if is_on; then printf '%s\n' "$pause"; else printf '%s\n' "$play"; fi
  }

  toggle() {
    if is_on; then
      "''${stop_cmd}" >/dev/null 2>&1 || true
      wait_off || true
    else
      "''${start_cmd}" >/dev/null 2>&1 || true
      wait_on || true
    fi
    pkill -RTMIN+8 waybar 2>/dev/null || true
  }

  case "''${1:-status}" in
    toggle) toggle ;;
    status) status ;;
    *) status ;;
  esac
''
