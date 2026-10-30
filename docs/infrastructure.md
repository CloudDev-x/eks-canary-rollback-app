# Infrastructure (Terraform)

## Stacks (applied in order)
| Stack | Purpose | Key Resources |
|-------|---------|---------------|
| `infra/bootstrap` | Remote state backend | S3 bucket (native locking, no DynamoDB) |
| `infra/cluster` | EKS and networking | VPC, EKS 1.37, managed node group, OIDC provider |
| `infra/platform` | Platform services | ECR repo, GitHub OIDC role, IAM policies |

## State Management
- S3 backend with `use_lockfile = true` (Terraform 1.11+)
- No DynamoDB lock table needed

## Region
- `us-east-1`

## Teardown
Run `bash scripts/down.sh` which:
1. Deletes the Argo CD root application (cascading delete of all children)
2. Destroys `infra/platform`
3. Destroys `infra/cluster`
4. Destroys `infra/bootstrap`
