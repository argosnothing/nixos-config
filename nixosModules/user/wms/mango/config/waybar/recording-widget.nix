{pkgs}:
pkgs.writeShellScriptBin "rec-widget" ''
  #!/usr/bin/env bash
  set -euo pipefail
  pidfile="''${XDG_CACHE_HOME:-$HOME/.cache}/wf-recorder.pid"
  start_cmd="''${START_CMD:-record-region-start}"
  stop_cmd="''${STOP_CMD:-record-region-stop}"
  play=$'\uf04b'
  pause=$'\uf04c'

  status() {
    if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
      printf '{"text":"%s","class":"recording","tooltip":"Recording"}\n' "$pause"
    else
      printf '{"text":"%s","class":"idle","tooltip":"Idle"}\n' "$play"
    fi
  }

  toggle() {
    if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
      "''${stop_cmd}" >/dev/null 2>&1 || true
    else
      "''${start_cmd}" >/dev/null
    fi
    pkill -RTMIN+8 waybar || true
  }

  case "''${1:-status}" in
    toggle) toggle ;;
    status) status ;;
    *) status ;;
  esac
''
