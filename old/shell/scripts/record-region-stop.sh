#!/usr/bin/env sh
set -eu

STATE_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/wfrec"
PID_FILE="$STATE_DIR/pid"
OUT_FILE="$STATE_DIR/file"

[ -f "$PID_FILE" ] || exit 0
PID="$(cat "$PID_FILE" || true)"
[ -n "${PID:-}" ] || exit 0

kill -INT "$PID" 2>/dev/null || true

i=0
while kill -0 "$PID" 2>/dev/null; do
  i=$((i+1))
  [ $i -gt 100 ] && break
  sleep 0.1
done

FILE="$(cat "$OUT_FILE" 2>/dev/null || true)"
rm -f "$PID_FILE" "$OUT_FILE"

if [ -n "${FILE:-}" ] && [ -f "$FILE" ]; then
  URI="file://$(realpath -s "$FILE")"
  printf '%s\n' "$URI" | wl-copy --type text/uri-list
fi

