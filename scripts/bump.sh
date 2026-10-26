#!/usr/bin/env bash
# Point a cask at a release: scripts/bump.sh <app> <version>   e.g. scripts/bump.sh dbcatz 0.2.0
# Reads the Apple silicon and Intel DMGs of v<version> from github.com/catzoidhub/<App>/releases (they must exist and
# be public), writes the version and both SHA-256 sums into Casks/<app>.rb and prints the diff. Commit and push after.
set -euo pipefail

app="${1:?usage: scripts/bump.sh <app> <version>}"
version="${2:?usage: scripts/bump.sh <app> <version>}"
version="${version#v}"
cd "$(dirname "$0")/.."
cask="Casks/${app}.rb"
[ -f "$cask" ] || { echo "no $cask" >&2; exit 1; }

# the product name as the cask spells it in its url (DevCatz, DBCatz, DialCatz …)
name=$(sed -n 's/^  name "\(.*\)"$/\1/p' "$cask")
base="https://github.com/catzoidhub/${name}/releases/download/v${version}"

sum() {
  local file="${name}-${version}-$1.dmg"
  local tmp; tmp=$(mktemp)
  if ! curl -fsSL -o "$tmp" "${base}/${file}"; then
    echo "missing on the release: ${base}/${file}" >&2
    rm -f "$tmp"; exit 1
  fi
  shasum -a 256 "$tmp" | cut -d' ' -f1
  rm -f "$tmp"
}

arm=$(sum arm64)
intel=$(sum x64)

/usr/bin/sed -i '' \
  -e "s/^  version \".*\"/  version \"${version}\"/" \
  -e "s/^  sha256 arm:   \".*\",/  sha256 arm:   \"${arm}\",/" \
  -e "s/^         intel: \".*\"/         intel: \"${intel}\"/" \
  "$cask"

git --no-pager diff -- "$cask"
echo "Checked: brew audit --cask --online catzoidhub/catz/${app} (after brew tap catzoidhub/catz)"
