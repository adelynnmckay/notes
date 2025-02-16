#!/bin/bash

set -oue pipefail

SUBMODULE=${1:?}

git rm ${SUBMODULE} || echo

rm -rf .git/modules/${SUBMODULE}

git config --remove-section submodule.${SUBMODULE}