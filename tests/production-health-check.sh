#!/usr/bin/env bash
set -euo pipefail
bash tests/smoke-test.sh "${1:?URL required}"
