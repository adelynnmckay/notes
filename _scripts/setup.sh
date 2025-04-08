#!/bin/bash

set -ouex pipefail

source _scripts/env.sh

bundle config set --local path 'vendor/bundle'
(bundle update || echo)
bundle install

mkdir -p _site
