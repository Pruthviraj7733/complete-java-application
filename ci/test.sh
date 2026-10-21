#!/usr/bin/env bash
set -euo pipefail
test -s app/index.jsp
test -s Dockerfile
test -s k8s/kustomization.yaml
echo 'Repository smoke checks passed; integration tests still require a running application.'
