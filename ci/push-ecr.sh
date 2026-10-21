#!/usr/bin/env bash
set -euo pipefail
: "${AWS_ACCOUNT_ID:?AWS_ACCOUNT_ID required}"
: "${BUILD_NUMBER:?BUILD_NUMBER required}"
region="${AWS_REGION:-ap-south-1}"
registry="$AWS_ACCOUNT_ID.dkr.ecr.$region.amazonaws.com"
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$registry"
docker tag "$1" "$registry/complete-java-application:$BUILD_NUMBER"
docker push "$registry/complete-java-application:$BUILD_NUMBER"
