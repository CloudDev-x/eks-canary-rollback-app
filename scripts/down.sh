#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if kubectl get svc -A -o jsonpath='{range .items[*]}{.spec.type}{"\n"}{end}' | grep -q LoadBalancer; then
  echo "A LoadBalancer service exists. Remove it before running teardown." >&2
  exit 1
fi

kubectl -n argocd delete application root --wait --timeout=10m
terraform -chdir="$ROOT/infra/platform" destroy
terraform -chdir="$ROOT/infra/cluster" destroy
terraform -chdir="$ROOT/infra/bootstrap" destroy
