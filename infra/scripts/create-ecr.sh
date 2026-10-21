#!/usr/bin/env bash
set -euo pipefail
region="${AWS_REGION:-ap-south-1}"
aws ecr describe-repositories --repository-names complete-java-application --region "$region" >/dev/null 2>&1 || aws ecr create-repository --repository-name complete-java-application --image-tag-mutability IMMUTABLE --image-scanning-configuration scanOnPush=true --region "$region"
aws ecr put-lifecycle-policy --repository-name complete-java-application --lifecycle-policy-text file://infra/ecr/lifecycle-policy.json --region "$region"
