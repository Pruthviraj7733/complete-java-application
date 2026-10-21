# Deployment runbook
1. Run local validations. Review costs; do not provision AWS without approval.
2. Build/check Java WAR image and push to ECR by Jenkins on dev.
3. Set the real ECR URI pinned to sha256 digest in dev k8s/deployment.yaml.
4. Deploy EKS and dependencies by following infra/README.md; apply infra/argocd/applications.yaml.
5. Check dev application healthy and run smoke tests.
6. Change UAT image digest in a reviewed pull request, merging only approved artifact changes; keep java-uat configs.
7. Obtain UAT sign-off then similarly update main (java-prod) digest through approved PR.
8. Verify pods, Ingress, host routing, metrics, rollback and alarms.
The example.com hosts and image placeholders are NOT real endpoints. Never apply untouched manifests to production.
