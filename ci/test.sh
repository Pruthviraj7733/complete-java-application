#!/usr/bin/env bash
set -euo pipefail
test -s app/index.jsp && test -s Dockerfile
