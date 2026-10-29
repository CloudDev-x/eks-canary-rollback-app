variable "region" {
  description = "AWS region for the state bucket and budget. Must match the cluster stack region."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short name used as a prefix for resource names and tags."
  type        = string
  default     = "eks-canary-rollback"
}

variable "budget_alert_email" {
  description = "Email address that receives AWS Budgets alerts. Set in terraform.tfvars, which is gitignored."
  type        = string
}

variable "monthly_budget_usd" {
  description = "Monthly cost ceiling in USD. AWS Budgets alerts at 80% and 100%. This is a guardrail, not a hard cap."
  type        = number
  default     = 10
}
