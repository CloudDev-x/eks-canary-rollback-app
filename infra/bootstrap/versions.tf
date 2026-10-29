terraform {
  # 1.11+ is required for S3 native state locking (use_lockfile).
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = "eks-canary-rollback"
      Stack     = "bootstrap"
      ManagedBy = "terraform"
    }
  }
}
