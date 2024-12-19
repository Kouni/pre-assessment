variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # Virginia region
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "poc-asiayo-eks-cluster"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "poc"
    Project     = "asiayo"
  }
}
