variable "region" {
  description = "AWS region. Must match the bootstrap stack."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for resource names and tags."
  type        = string
  default     = "eks-canary-rollback"
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "eks-canary-rollback"
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version in standard support. Set in terraform.tfvars."
  type        = string
}

variable "github_owner" {
  description = "GitHub user or org that owns the app repo. Trust policy for the CI role is limited to this owner. Set in terraform.tfvars."
  type        = string
}

variable "github_app_repo" {
  description = "Name of the app repo whose main branch may assume the CI role."
  type        = string
  default     = "eks-canary-rollback-app"
}
