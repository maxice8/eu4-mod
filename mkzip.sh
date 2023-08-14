#!/bin/sh
set -eu

: "${ZIP_NAME:=$MOD_NAME}"
: "${PREFIX_NAME:=$MOD_NAME}"

ZIP_PATH="$ZIP_TMPDIR/mod/$ZIP_NAME.zip"
ZIP_FINAL_PATH="$GITHUB_WORKSPACE/$ZIP_NAME.zip"

# Create directory for the mod
mkdir -p "$ZIP_TMPDIR"/mod

git archive -o "$ZIP_PATH" --prefix="$PREFIX_NAME"/ HEAD

# Create descriptor
cat descriptor.mod > "$ZIP_TMPDIR"/mod/"$MOD_NAME".mod
# Add PATH to descriptor
printf '\npath="%s"\n' "$PREFIX_NAME" >> "$ZIP_TMPDIR"/mod/"$MOD_NAME".mod

# Add it to the zip, use -j to strip the paths so it only adds the file to the
# root of the zip
zip -u "$ZIP_PATH" -j "$ZIP_TMPDIR"/mod/"$MOD_NAME".mod

#mv "$ZIP_TMPDIR/mod/$ZIP_NAME.zip" "$ZIP_FINAL_PATH"

echo "zip-path=$ZIP_PATH" >> "$GITHUB_OUTPUT"