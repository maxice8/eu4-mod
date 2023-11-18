#!/bin/sh
set -eu

MOD_NAME="${MOD_NAME:-}"

# We were given a mod name.
if [ -n "$MOD_NAME" ]; then
	# replace the name in the descriptor mod	
	sed "/^name=\"/s/.*/name=\"$MOD_NAME\"/" -i descriptor.mod
	git add descriptor.mod
	git -c user.name='who' -c user.email='cares@lmao.org' \
		commit -m ok
fi

if [ -z "$MOD_NAME" ]; then
	# Generate the MOD_NAME from reading the descriptor
	mod_name="$(\
		sed -n 's|^name="\(.*\)".*|\1|p' descriptor.mod \
		| tr '[:upper:]' '[:lower:]' | tr ' ' - \
	)"
	MOD_NAME="$mod_name"
	export MOD_NAME
fi

: "${ZIP_NAME:=$MOD_NAME}"
: "${PREFIX_NAME:=$MOD_NAME}"
: "${DESCRIPTOR_NAME:=$MOD_NAME}"

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
