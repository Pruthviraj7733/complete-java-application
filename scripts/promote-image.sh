#!/usr/bin/env bash
set -euo pipefail
image="${1:?Pass approved ECR image URI with @sha256 digest}"
branch="${2:?Target: uat or main}"
case "$image" in *@sha256:*) ;; *) echo 'Only immutable digests are accepted' >&2; exit 1;; esac
case "$branch" in uat|main) ;; *) echo 'Target must be uat or main' >&2; exit 1;; esac
[ "$(git branch --show-current)" = "$branch" ] || { echo "Checkout $branch before modifying"; exit 1; }
sed -i -E "s#image: .*#image: $image#" k8s/deployment.yaml
git diff -- k8s/deployment.yaml
echo 'Create a reviewed PR for this environment. Never push directly to a protected branch.'
