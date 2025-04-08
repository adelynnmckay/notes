#!/bin/bash

set -ouex pipefail

source _scripts/env.sh

chmod +x _scripts/*.sh

./_scripts/setup.sh

./_scripts/serve.sh
