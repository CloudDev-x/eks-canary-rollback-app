# Canary Rollout Strategy

## How It Works
1. A new image tag is pushed to the GitOps repo by CI
2. Argo CD detects the manifest change and syncs
3. Argo Rollouts creates 1 canary pod (20% weight)
4. After 30s pause, an AnalysisTemplate queries Prometheus
5. If 5xx rate < 5% over 4 checks (30s each), traffic shifts to 50%
6. After another 30s pause, full promotion to 100%

## On Failure
- If 5xx rate ≥ 5%, analysis fails after exceeding failureLimit (1)
- Rollout is aborted automatically
- Canary pods scale to 0
- All traffic returns to the stable ReplicaSet

## Key Config
- **AnalysisTemplate**: `api-5xx-rate` in namespace `apps`
- **Prometheus query**: ratio of 5xx to total requests, filtered by `pod_template_hash`
- **PodMonitor**: relabels `rollouts_pod_template_hash` → `pod_template_hash`
- **Services**: `api-stable` (stable traffic), `api-canary` (canary traffic)
