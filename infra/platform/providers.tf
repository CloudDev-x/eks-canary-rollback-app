provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = "eks-canary-rollback"
      Stack     = "platform"
      ManagedBy = "terraform"
    }
  }
}

data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}
