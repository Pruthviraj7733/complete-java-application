#!/usr/bin/env bash
set -euo pipefail
image="${1:?Provide ECR image URI with sha256 digest}"
target="${2:?Target branch uat or main}"
case "$image" in *@sha256:*) ;; *) echo 'Require immutable @sha256 digest' >&2; exit 1;; esac
case "$target" in uat|main) ;; *) echo 'Target must be uat or main' >&2; exit 1;; esac
actual="$(git branch --show-current)"
[ "$actual" = "$target" ] || { echo "Checkout branch $target first (current: $actual)" >&2; exit 1; }
sed -i -E "s#image: .*#image: $image#" k8s/deployment.yaml
echo 'Updated GitOps desired image. Commit, open PR, obtain approvals; do not deploy directly.'
git diff -- k8s/deployment.yaml
