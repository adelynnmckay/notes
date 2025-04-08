#!/bin/bash

set -ouex pipefail

source _scripts/env.sh

bundle exec jekyll serve --watch
