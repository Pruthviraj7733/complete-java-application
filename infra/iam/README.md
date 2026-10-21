# IAM
Use official version-matched AWS Load Balancer Controller IAM JSON. Create the controller IAM role using IRSA, and supply ALB_CONTROLLER_ROLE_ARN. Attach least-privileged Jenkins ECR policy after replacing ACCOUNT_ID. Do not commit access keys or secrets. Permissions must be tested on a real EKS cluster.
