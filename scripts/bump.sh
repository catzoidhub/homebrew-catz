#!/usr/bin/env bash
# Point a cask or formula at a release: scripts/bump.sh <app> <version>   e.g. scripts/bump.sh dbcatz 0.2.0
#   Casks/<app>.rb   (the apps) — reads the Apple silicon and Intel DMGs of v<version> from
#                    github.com/catzoidhub/<App>/releases (they must exist and be public), writes the version and both
#                    SHA-256 sums;
#   Formula/<app>.rb (mcatzp)   — reads the npm tarball of <version>, writes its URL and SHA-256.
# Prints the diff. Commit and push after.
set -euo pipefail

app="${1:?usage: scripts/bump.sh <app> <version>}"
version="${2:?usage: scripts/bump.sh <app> <version>}"
version="${version#v}"
cd "$(dirname "$0")/.."
cask="Casks/${app}.rb"

# a formula (MCatzP, published on npm): the tarball's URL and SHA-256
if [ -f "Formula/${app}.rb" ]; then
  formula="Formula/${app}.rb"
  tgz="https://registry.npmjs.org/${app}/-/${app}-${version}.tgz"
  tmp=$(mktemp)
  curl -fsSL -o "$tmp" "$tgz" || { echo "not on npm: $tgz" >&2; rm -f "$tmp"; exit 1; }
  sha=$(shasum -a 256 "$tmp" | cut -d' ' -f1); rm -f "$tmp"
  /usr/bin/sed -i '' -e "s#^  url \".*\"#  url \"${tgz}\"#" -e "s/^  sha256 \".*\"/  sha256 \"${sha}\"/" "$formula"
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
