#!/usr/bin/env bash
set -euo pipefail

git rev-parse --git-dir >/dev/null 2>&1 || exit 2

for remote in $(git remote); do
  for mode in fetch push; do
    if [[ "$mode" == push ]]; then
      old=$(git remote get-url --push "$remote" 2>/dev/null || true)
    else
      old=$(git remote get-url "$remote" 2>/dev/null || true)
    fi

    [[ -z "$old" ]] && continue

    new="$old"

    # HTTPS GitHub → SSH
    if [[ "$old" =~ ^https://([^@]+@)?github\.com/([^/]+/[^/]+)(\.git)?$ ]]; then
      new="git@github.com:${BASH_REMATCH[2]}.git"
    fi

    # Normalize SSH GitHub (.git.git → .git)
    if [[ "$new" =~ ^git@github\.com:([^/]+/[^/]+)\.git\.git$ ]]; then
      new="git@github.com:${BASH_REMATCH[1]}.git"
    fi

    if [[ "$new" != "$old" ]]; then
      echo "fixing $remote ($mode):"
      echo "  $old"
      echo "  → $new"
      if [[ "$mode" == push ]]; then
        git remote set-url --push "$remote" "$new"
      else
        git remote set-url "$remote" "$new"
      fi
    fi
  done
done
