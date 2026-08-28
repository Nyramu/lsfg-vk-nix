#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

repo_url="https://git.lsfg-vk.dev/lsfg-vk.git"
branch="master"
source_file="source.json"

latest_rev=$(git ls-remote "$repo_url" "$branch" | cut -f1)
current_rev=$(jq -r .rev "$source_file")

if [[ "$latest_rev" == "$current_rev" ]]; then
  echo "lsfg-vk-git already up to date (${current_rev})"
  exit 0
fi

echo "Updating lsfg-vk-git: ${current_rev} -> ${latest_rev}"

raw_hash=$(nix run nixpkgs#nix-prefetch-git -- \
  --fetch-submodules --quiet \
  --url "$repo_url" \
  --rev "$latest_rev" | jq -r .sha256)

sri_hash=$(nix hash convert --hash-algo sha256 --to sri "$raw_hash")

jq -n --arg rev "$latest_rev" --arg hash "$sri_hash" '{rev: $rev, hash: $hash}' > "$source_file"

echo "Wrote ${source_file}:"
cat "$source_file"
