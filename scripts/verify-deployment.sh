#!/usr/bin/env bash
set -euo pipefail
kubectl -n "${1:?namespace required}" rollout status deployment/java-application --timeout=180s
