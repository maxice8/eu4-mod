#!/bin/sh
set -eu

: "${ZIP_NAME:=$MOD_NAME}"
: "${PREFIX_NAME:=$MOD_NAME}"

ZIP_PATH="$GITHUB_WORKSPACE/$ZIP_NAME.zip"

# Create directory for the mod
mkdir -p "$ZIP_TMPDIR"/

# Create descriptor
cat descriptor.mod > "$ZIP_TMPDIR"/"$MOD_NAME".mod
# Add PATH to descriptor
printf '\npath="%s"\n' "$PREFIX_NAME" >> "$ZIP_TMPDIR"/"$MOD_NAME".mod

git archive \
    -o "$ZIP_PATH" \
    --prefix="$PREFIX_NAME"/ \
    --add-file="$ZIP_TMPDIR/$MOD_NAME.mod" \
    HEAD

echo "zip-path=$ZIP_PATH" >> "$GITHUB_OUTPUT"