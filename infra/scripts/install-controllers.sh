#!/usr/bin/env bash
set -euo pipefail
: "${CLUSTER_NAME:=complete-java-cluster}"
: "${AWS_REGION:=ap-south-1}"
: "${VPC_ID:?Set VPC_ID}"
: "${ALB_CONTROLLER_ROLE_ARN:?Set ALB_CONTROLLER_ROLE_ARN}"
: "${COST_APPROVED:?Set COST_APPROVED=yes after reviewing AWS costs}"
test "$COST_APPROVED" = yes
kubectl cluster-info >/dev/null
helm repo add eks https://aws.github.io/eks-charts
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace kube-system --dry-run=client -o yaml | kubectl apply -f -
kubectl -n kube-system create serviceaccount aws-load-balancer-controller --dry-run=client -o yaml | kubectl apply -f -
kubectl -n kube-system annotate serviceaccount aws-load-balancer-controller "eks.amazonaws.com/role-arn=$ALB_CONTROLLER_ROLE_ARN" --overwrite
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName="$CLUSTER_NAME" --set region="$AWS_REGION" --set vpcId="$VPC_ID" --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
helm upgrade --install metrics-server metrics-server/metrics-server -n kube-system
helm upgrade --install argocd argo/argo-cd -n argocd --create-namespace
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace -f infra/monitoring/kube-prometheus-stack-values.yaml
kubectl apply -f infra/argocd/applications.yaml
kubectl apply -f infra/monitoring/java-alert-rules.yaml
