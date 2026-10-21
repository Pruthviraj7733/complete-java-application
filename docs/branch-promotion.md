# Image promotion
Build and scan once on dev; push immutable image to ECR and record sha256 digest. UAT and PROD must reference exactly that digest, not a mutable tag. Update environment-specific deployment.yaml via reviewed PR. Do not merge DEV namespace/Ingress/Argo CD values into UAT/PROD. Require UAT sign-off before PROD; revert digest via PR for rollback.
