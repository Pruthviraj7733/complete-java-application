#!/usr/bin/env bash
set -euo pipefail
trivy fs --scanners vuln,secret,misconfig --severity HIGH,CRITICAL --exit-code 1 .
