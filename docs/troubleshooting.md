# Troubleshooting
kubectl -n java-dev get pods -o wide
kubectl -n java-dev describe deployment java-application
kubectl -n java-dev describe pod POD_NAME
kubectl -n java-dev logs deployment/java-application --tail=100
kubectl -n argocd get applications
kubectl -n kube-system logs deployment/aws-load-balancer-controller --tail=100
kubectl -n java-dev get ingress
kubectl -n java-dev get events --sort-by=.lastTimestamp
Check readiness path /java-application/, ECR image digest, AWS IAM/ECR access, CNI, ALB target groups and security groups. Revert digest via GitOps PR to roll back.
