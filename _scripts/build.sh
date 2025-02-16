#!/bin/bash

set -ouex pipefail

which npm || brew install npm

which jq || brew install jq

npm install --save-dev nx

npm install

npm run build

for package in $(find _pages -name package.json); do
    if jq -e 'has("bin")' "$package" >/dev/null; then
        directory=$(dirname "$package")
        (cd "directory" && npm link)
    fi
done

export PATH="$PATH:${PWD}/node_modules/.bin"

chmod +x "${PWD}/node_modules/.bin/*"

metadata-rm --recursive --debug '.'