#!/usr/bin/env sh
set -eu

STATE_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/wfrec"
PID_FILE="$STATE_DIR/pid"
OUT_FILE="$STATE_DIR/file"

mkdir -p "$STATE_DIR"

if [ -e "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  exit 0
fi

FILE="$(mktemp --tmpdir --suffix=.mp4)"

if SRC="$(pactl get-default-sink 2>/dev/null)"; then
  SRC="$SRC.monitor"
elif SRC="$(pactl get-default-source 2>/dev/null)"; then
  : 
else
  echo "warn: no PulseAudio/PipeWire default source found; recording without audio" >&2
  SRC=""
fi

GEOM="$(slurp || true)"
if [ -z "${GEOM:-}" ]; then
  rm -f "$FILE"
  exit 1
fi

if [ -n "$SRC" ]; then
  wf-recorder -g "$GEOM" --audio="$SRC" --audio-backend=pipewire -C aac -f "$FILE" -y >/dev/null 2>&1 &
else
  wf-recorder -g "$GEOM" -f "$FILE" -y >/dev/null 2>&1 &
fi

echo $! >"$PID_FILE"
printf '%s' "$FILE" >"$OUT_FILE"

