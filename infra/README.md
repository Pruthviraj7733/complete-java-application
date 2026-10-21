# Shared EKS infrastructure
Review costs before applying. Create ECR repository, EKS cluster, IAM roles/IRSA, install AWS Load Balancer Controller, metrics-server, Argo CD, kube-prometheus-stack. Replace VPC, account and DNS placeholders. These manifests do not provision controllers automatically. Production should use private nodes, TLS, isolated IAM and ideally a separate cluster/account.
