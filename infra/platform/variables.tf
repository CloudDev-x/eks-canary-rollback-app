variable "region" {
  description = "AWS region. Must match the bootstrap and cluster stacks."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster to install the platform components into."
  type        = string
  default     = "eks-canary-rollback"
}
