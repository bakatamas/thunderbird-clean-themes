#!/bin/sh
# Builds the six theme files (.xpi), the all-in-one zip and the microsite's
# updates.json into dist/.
#
# Each theme is themes/<name>/manifest.json plus a stylesheet assembled here:
# src/theme.css, with src/mono.css appended for the Mono themes. The theme
# name and version in the stylesheet header come from the manifest.
#
# Needs: sh, sed, zip. Run from anywhere: ./build.sh
set -eu
cd "$(dirname "$0")"

# Reads a top-level string field from a manifest. Tolerates any indentation
# and Windows line endings.
field() { sed -n "s/^ *\"$1\": *\"\([^\"]*\)\".*/\1/p" "$2" | head -n 1; }

version=$(field version themes/clean-light/manifest.json)
[ -n "$version" ] || { echo "No version in themes/clean-light/manifest.json" >&2; exit 1; }

rm -rf dist
mkdir -p dist/work

for dir in themes/*/; do
  key=$(basename "$dir")
  manifest="$dir/manifest.json"
  name=$(field name "$manifest")
  v=$(field version "$manifest")
  if [ "$v" != "$version" ]; then
    echo "$key is version $v, but clean-light is $version. Update all manifests together." >&2
    exit 1
  fi

  work="dist/work/$key"
  mkdir -p "$work"
  cp "$manifest" "$work/manifest.json"
  sed "s/@NAME@/$name/; s/@VERSION@/$version/" src/theme.css > "$work/theme.css"
  case "$key" in
    *mono*) cat src/mono.css >> "$work/theme.css" ;;
  esac

  (cd "$work" && zip -qX "../../$key-$version.xpi" manifest.json theme.css)
  echo "built dist/$key-$version.xpi"
done

cp conversations/conversations-clean.css dist/
cp conversations/README.md dist/conversations-clean-README.md

bundle="clean-themes-$version"
mkdir -p "dist/work/$bundle"
cp dist/*.xpi dist/conversations-clean.css dist/conversations-clean-README.md "dist/work/$bundle/"
(cd dist/work && zip -qrX "../$bundle.zip" "$bundle")
echo "built dist/$bundle.zip"

# Update manifest for the microsite. Each theme's update_url points at it, and
# Thunderbird installs the version it lists from the matching download folder.
base="https://celest-watches.com/clean-themes/downloads/$version"
{
  echo '{'
  echo '  "addons": {'
  sep=''
  for dir in themes/*/; do
    key=$(basename "$dir")
    id=$(field id "$dir/manifest.json")
    printf '%s    "%s": {\n' "$sep" "$id"
    printf '      "updates": [\n'
    printf '        { "version": "%s", "update_link": "%s/%s-%s.xpi" }\n' "$version" "$base" "$key" "$version"
    printf '      ]\n'
    printf '    }'
    sep=",
"
  done
  echo
  echo '  }'
  echo '}'
} > dist/updates.json
echo "built dist/updates.json"

rm -rf dist/work
