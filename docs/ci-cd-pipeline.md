# CI/CD Pipeline

## Overview
Two-repo GitOps model:
- **eks-canary-rollback-app**: source code, Terraform infrastructure, CI workflows
- **eks-canary-rollback-gitops**: Kubernetes manifests, Argo CD applications

## CI Flow (GitHub Actions)
1. Push to `main` on app repo triggers `.github/workflows/ci.yml`
2. Authenticates to AWS via GitHub OIDC (no stored credentials)
3. Builds Docker image, tags with commit SHA
4. Pushes to Amazon ECR
5. Updates image tag in gitops repo via GitHub App (`eks-canary-rollback-gitops-bot`)

## CD Flow (Argo CD)
1. Argo CD watches the gitops repo
2. Detects tag change in `apps/api/rollout.yaml`
3. Syncs using app-of-apps pattern:
   - Root Application → `argo-rollouts`, `kube-prometheus-stack`, `workloads`
4. Argo Rollouts manages canary deployment with automated analysis

## Authentication
- **GitHub → AWS**: OIDC federation, no long-lived keys
- **CI → GitOps repo**: GitHub App (App ID 5528947) with repo contents write permission
