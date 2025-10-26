#!/usr/bin/env bash
set -euo pipefail

u="$1"
if [[ "$u" == https://github.com/*/blob/* ]]; then
  raw="$(printf %s "$u" | sed -E 's#https://github.com/#https://raw.githubusercontent.com/#; s#/blob/#/#')"
else
  raw="$u"
fi

if [ $# -ge 2 ]; then 
  out="$2"
else 
  out="$(basename "$u")"
fi

curl -L "$raw" -o "$out"
