#!/usr/bin/env bash
set -euo pipefail
: "${COST_APPROVED:?Set COST_APPROVED=yes}"
test "$COST_APPROVED" = yes
: "${CLUSTER_NAME:=complete-java-cluster}"
: "${AWS_REGION:=ap-south-1}"
: "${ALB_IAM_POLICY_ARN:?Provide policy ARN created from official AWS Load Balancer Controller iam_policy.json}"
eksctl utils associate-iam-oidc-provider --cluster "$CLUSTER_NAME" --region "$AWS_REGION" --approve
eksctl create iamserviceaccount --cluster "$CLUSTER_NAME" --region "$AWS_REGION" --namespace kube-system --name aws-load-balancer-controller --role-name complete-java-alb-controller --attach-policy-arn "$ALB_IAM_POLICY_ARN" --approve --override-existing-serviceaccounts
echo 'Retrieve role ARN using aws iam get-role --role-name complete-java-alb-controller'
