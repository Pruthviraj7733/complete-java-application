# AWS cost review
EKS control plane, two EC2 worker nodes, EBS, ALB, public IPv4, NAT (if used), ECR storage, data transfer and CloudWatch incur charges. Check the current AWS Pricing Calculator for ap-south-1 before any provisioning. Delete the ALB, EKS cluster, EBS, ECR images and other resources after the lab.
