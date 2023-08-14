<h1 align="center">
    Zip Europa Universalis IV mod
</h1>

<p align="center">
    A GitHub action to create a extract-and-play zip of an Europa Univeraslis IV mod
</p>

## Usage

call it via `uses: maxice8/eu4-mod-zip@v1`, use `.with` syntax to provide `mod-name`.

Snippet example from one of Ante Bellum's internal mods:

```yaml
name: submod-release

on:
  push:
    branches: "master"

env:
  mod: ante-bellum-185

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - id: zip
        uses: maxice8/eu4-mod-zip@v0.0.1
        with:
          # mod-name is always required
          mod-name: ${{ env.mod }}

      - name: Upload
        uses: actions/upload-artifact@v3
        with:
          name: ${{ env.mod }}
          path: ${{ steps.zip.outputs.zip-path }}
...
```

### Customization

The following additional keys are accepted with the `.with` syntax:

#### zip-name

Decides the final name of the zip-file, if not set defaults to inputs.mod-name which is always required.

#### prefix

Decides the prefix, or folder where the mod resides, inside the zip, if not set defaults to
inputs.mod-name which is always required.