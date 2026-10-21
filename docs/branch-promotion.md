# Environment release workflow
Feature/bugfix -> dev PR + CI checks.
Jenkins DEV branch builds, scans, quality gates, pushes one immutable ECR tag, records sha256 digest. Set dev Deployment image to repository@sha256:<digest> through GitOps PR, then Argo CD auto-syncs dev.
After DEV smoke testing, use scripts/promote-image.sh on a checkout of uat to update only k8s/deployment.yaml to exactly the approved digest. Open PR targeting uat; require QA sign-off. Argo CD UAT sync is deliberately manual.
After UAT sign-off, repeat on main through reviewed PR; production Argo CD sync is manual. DO NOT merge whole environment branch or overwrite UAT/PROD namespace/Ingress/Argo CD files.
Hotfix from main -> reviewed PR -> main, then back-port to dev and uat; maintain approved configuration in each branch.
