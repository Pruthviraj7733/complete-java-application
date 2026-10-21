#!/usr/bin/env bash
set -euo pipefail
for branch in dev uat main; do
  kubectl apply --dry-run=client -f "https://raw.githubusercontent.com/Pruthviraj7733/complete-java-application/$branch/argocd/application.yaml" >/dev/null
done
kubectl apply -f infra/argocd/applications.yaml
kubectl get applications -n argocd
