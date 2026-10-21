#!/usr/bin/env bash
set -euo pipefail
curl -fsS "${1:?URL required}" | grep -q 'Complete Java Application'
