#!/bin/bash

set -ouex pipefail

chmod +x _scripts/*.sh

./_scripts/setup.sh

./_scripts/build.sh

./_scripts/serve.sh
