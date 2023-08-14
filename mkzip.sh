#!/bin/sh
# Create directory for the mod
mkdir -p "$ZIP_TMPDIR"/mod

# Create zip archive
git archive -o "$ZIP_TMPDIR"/mod/"$ZIP_NAME".zip --prefix="$PREFIX_NAME"/ HEAD

# Create descriptor
cat descriptor.mod > "$ZIP_TMPDIR"/mod/"$MOD_NAME".mod
# Add PATH to descriptor
printf '\npath="%s"\n' "$PREFIX_NAME" >> "$ZIP_TMPDIR"/mod/"$MOD_NAME".mod

# Add it to the zip, use -j to strip the paths so it only adds the file to the
# root of the zip
zip -u ZIP_TMPDIR/mod/"$ZIP_NAME".zip -j "$ZIP_TMPDIR"/mod/"$MOD_NAME".mod

echo "zip-path=$ZIP_TMPDIR/mod/$ZIP_NAME" >> "$GITHUB_OUTPUT"