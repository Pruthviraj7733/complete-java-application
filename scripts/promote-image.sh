#!/usr/bin/env bash
set -euo pipefail
: "${1:?Provide ECR image URI with @sha256 digest}"
case "$1" in *@sha256:*) ;; *) echo 'Immutable digest required' >&2; exit 1;; esac
: "${2:?Provide target environment branch checkout}"
case "$2" in uat|main) ;; *) echo 'Only uat or main promotion supported' >&2; exit 1;; esac
sed -i -E "s#image: .*#image: $1#" k8s/deployment.yaml
echo 'Review git diff, open PR, and obtain approval before merging. No deployment performed.'
