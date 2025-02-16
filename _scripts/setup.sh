#!/bin/bash

set -ouex pipefail

export JEKYLL_ENV=debug

bundle config set --local path 'vendor/bundle'
(bundle update || echo)
bundle install

mkdir -p _site
