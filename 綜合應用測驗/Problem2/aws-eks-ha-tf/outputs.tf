output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "eks_node_group_role_arn" {
  description = "EKS Node Group Role ARN"
  value       = module.eks.eks_managed_node_groups["bottlerocket_arm"].iam_role_arn
}
