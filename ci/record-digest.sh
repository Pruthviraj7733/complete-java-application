#!/usr/bin/env bash
set -euo pipefail
: "${AWS_ACCOUNT_ID:?AWS_ACCOUNT_ID required}"
: "${BUILD_NUMBER:?BUILD_NUMBER required}"
region="${AWS_REGION:-ap-south-1}"
digest="$(aws ecr describe-images --region "$region" --repository-name complete-java-application --image-ids "imageTag=$BUILD_NUMBER" --query 'imageDetails[0].imageDigest' --output text)"
case "$digest" in sha256:*) ;; *) echo 'No ECR digest found' >&2; exit 1;; esac
printf '%s.dkr.ecr.%s.amazonaws.com/complete-java-application@%s\n' "$AWS_ACCOUNT_ID" "$region" "$digest" > image-digest.txt
cat image-digest.txt
