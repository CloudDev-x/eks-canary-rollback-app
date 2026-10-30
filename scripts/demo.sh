#!/usr/bin/env bash
set -euo pipefail

GITOPS_DIR="${GITOPS_DIR:-$HOME/eks-canary-rollback/eks-canary-rollback-gitops}"
ROLLOUT="$GITOPS_DIR/apps/api/rollout.yaml"

set_fail_rate() {
  local rate="$1"
  git -C "$GITOPS_DIR" pull --rebase --quiet
  sed -i "/name: FAIL_RATE/{n;s|value: .*|value: \"${rate}\"|}" "$ROLLOUT"
  git -C "$GITOPS_DIR" add "$ROLLOUT"
  git -C "$GITOPS_DIR" commit -m "demo: set API FAIL_RATE to ${rate}"
  git -C "$GITOPS_DIR" push origin main
}

case "${1:-}" in
  break) set_fail_rate 1 ;;
  fix) set_fail_rate 0 ;;
  *) echo "usage: $0 break|fix" >&2; exit 1 ;;
esac
