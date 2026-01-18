#!/usr/bin/env bash
set -euo pipefail
git rev-parse --git-dir >/dev/null 2>&1 || exit 2
for remote in $(git remote); do
  if old=$(git remote get-url "$remote" 2>/dev/null); then
    if [[ "$old" =~ ^https://([^@]+@)?github\.com/([^/]+/[^/]+)(\.git)?$ ]]; then
      new="git@github.com:${BASH_REMATCH[2]}.git"
      if [ "$new" != "$old" ]; then
        git remote set-url "$remote" "$new"
      fi
    fi
  fi
  if old=$(git remote get-url --push "$remote" 2>/dev/null); then
    if [[ "$old" =~ ^https://([^@]+@)?github\.com/([^/]+/[^/]+)(\.git)?$ ]]; then
      new="git@github.com:${BASH_REMATCH[2]}.git"
      if [ "$new" != "$old" ]; then
        git remote set-url --push "$remote" "$new"
      fi
    fi
  fi
done
