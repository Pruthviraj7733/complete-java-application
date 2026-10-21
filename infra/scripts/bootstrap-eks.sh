#!/usr/bin/env bash
set -euo pipefail
: "${COST_APPROVED:?Set COST_APPROVED=yes after reviewing costs}"
test "$COST_APPROVED" = yes
eksctl create cluster -f infra/eks/eks-cluster.yaml
aws eks update-kubeconfig --name complete-java-cluster --region ap-south-1
kubectl get nodes
