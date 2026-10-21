#!/usr/bin/env bash
set -euo pipefail
: "${AWS_REGION:=ap-south-1}"
echo 'Prerequisites: running EKS, IAM OIDC provider, IRSA roles, VPC ID, kubectl, Helm, and verified cost approval.'
echo 'Install AWS Load Balancer Controller using the official EKS Helm instructions and infra/alb/values.yaml after configuring IAM.'
echo 'Install Argo CD, metrics-server and kube-prometheus-stack from official charts pinned to reviewed versions.'
exit 1
