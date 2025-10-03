#!/usr/bin/env bash
set -euo pipefail

# Check arguments
if [ $# -ne 3 ]; then
    echo "Usage: ggrab <url> <branch> <dir>"
    echo "Example: ggrab https://github.com/user/repo.git main src/"
    exit 1
fi

url="$1"
branch="$2"
dir="$3"

# Initialize git repository
git init

# Add remote origin
git remote add -f origin "$url"

# Enable sparse checkout
git config core.sparsecheckout true

# Add the specified directory to sparse checkout
echo "$dir" >> .git/info/sparse-checkout

# Pull from the specified branch
git pull origin "$branch"

# Clean up - remove .git directory for atomic operation
rm -rf .git

echo "Successfully grabbed '$dir' from '$url' (branch: $branch)"
