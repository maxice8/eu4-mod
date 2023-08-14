#!/bin/sh
set -eu

: "${ZIP_NAME:=$MOD_NAME}"
: "${PREFIX_NAME:=$MOD_NAME}"

ZIP_PATH="$GITHUB_WORKSPACE/$ZIP_NAME.zip"

git archive -o "$ZIP_PATH" --prefix="$PREFIX_NAME"/ HEAD

# Create descriptor
cat descriptor.mod > "$GITHUB_WORKSPACE"/"$MOD_NAME".mod
# Add PATH to descriptor
printf '\npath="mod/%s"\n' "$PREFIX_NAME" >> "$GITHUB_WORKSPACE"/"$MOD_NAME".mod

# Add it to the zip, use -j to strip the paths so it only adds the file to the
# root of the zip
zip -u -m "$ZIP_PATH" -j "$GITHUB_WORKSPACE"/"$MOD_NAME".mod 

echo "zip-path=$ZIP_PATH" >> "$GITHUB_OUTPUT"