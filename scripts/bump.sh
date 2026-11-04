#!/usr/bin/env bash
# Point a cask or formula at a release: scripts/bump.sh <app> <version>   e.g. scripts/bump.sh dbcatz 0.2.0
#   Casks/<app>.rb   (the apps) — reads the Apple silicon and Intel DMGs of v<version> from
#                    github.com/catzoidhub/<App>/releases (they must exist and be public), writes the version and both
#                    SHA-256 sums;
#   Formula/<app>.rb (mcatzp)   — reads the Mac zips of v<version> from github.com/catzoidhub/MCatzP/releases,
#                    writes the version and both SHA-256 sums.
# Prints the diff. Commit and push after.
set -euo pipefail

app="${1:?usage: scripts/bump.sh <app> <version>}"
version="${2:?usage: scripts/bump.sh <app> <version>}"
version="${version#v}"
cd "$(dirname "$0")/.."
cask="Casks/${app}.rb"

# a formula (MCatzP): the version and the sums of its two Mac zips on the GitHub release
if [ -f "Formula/${app}.rb" ]; then
  formula="Formula/${app}.rb"
  base="https://github.com/catzoidhub/MCatzP/releases/download/v${version}"
  zipsum() {
    local file="${app}-${version}-$1.zip"
    local tmp; tmp=$(mktemp)
    if ! curl -fsSL -o "$tmp" "${base}/${file}"; then
      echo "missing on the release: ${base}/${file}" >&2
      rm -f "$tmp"; exit 1
    fi
    shasum -a 256 "$tmp" | cut -d' ' -f1
    rm -f "$tmp"
  }
  arm=$(zipsum mac-arm64)
  intel=$(zipsum mac-x64)
  /usr/bin/sed -i '' \
    -e "s/^  version \".*\"/  version \"${version}\"/" \
    -e "/on_arm do/,/end/ s/sha256 \".*\"/sha256 \"${arm}\"/" \
    -e "/on_intel do/,/end/ s/sha256 \".*\"/sha256 \"${intel}\"/" \
    "$formula"
  git --no-pager diff -- "$formula"
  echo "Checked: brew audit --formula --online catzoidhub/catz/${app}"
  exit 0
fi

[ -f "$cask" ] || { echo "no $cask or Formula/${app}.rb" >&2; exit 1; }

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
