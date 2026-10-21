#!/usr/bin/env bash
set -euo pipefail
trivy image --severity HIGH,CRITICAL --exit-code 1 "${1:?image required}"
