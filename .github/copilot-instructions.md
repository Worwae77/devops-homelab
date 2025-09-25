# AI agent instructions for this repository

Snapshot note
- As of 2025-09-25 this repo contains only `README.md`, which declares the intended folder layout. Create missing folders/files as needed while following the boundaries below.

Repository scope and boundaries (from README)
- `docs/` — project documentation and guides.
- `terraform/` — Infrastructure as Code to provision cloud/local resources. Prefer reusable modules; surface needed outputs (e.g., kubeconfig path, IPs) for downstream steps.
- `ansible/` — Post-provision configuration and app bootstrapping. Keep inventories, roles, and playbooks here.
- `kubernetes/` — Cluster manifests (Deployments, Services, etc.) grouped logically (by app or namespace).
- `ci-cd/` — Pipeline definitions (e.g., GitHub Actions, Jenkins) that orchestrate plan/apply, configuration runs, and Kubernetes deploys.
- `monitoring/` — Observability stack configuration (e.g., Prometheus/Grafana manifests and dashboards).
- `security/` — Security tooling configs/policies (e.g., scanners, IaC/K8s policy rules).
- `automation-scripts/` — Helper scripts invoked locally or by pipelines.
- `examples/` — Reference setups and sample configurations.

Working conventions for agents
- Keep concerns separated by folder; do not mix IaC, config management, and workload manifests.
- When introducing a new capability, add it under the relevant top-level folder declared above and wire it from `ci-cd/` if automation is needed.
- Make changes idempotent (Terraform plans clean; Ansible safe to re-run; Kubernetes declarative manifests).
- Produce generated artifacts into a dedicated output/temp path and ensure VCS ignores them (add or extend a `.gitignore` near new outputs).
- Do not commit secrets. Reference them via your chosen secret store; commit example placeholders only.

Typical cross-component flow (implied by structure)
- Provision with `terraform/` → configure with `ansible/` → deploy workloads from `kubernetes/` → observe via `monitoring/`. Pipelines in `ci-cd/` orchestrate these steps.

Task routing examples
- Infra change (networks, clusters, VMs): implement in `terraform/`; expose outputs needed by Ansible/Kubernetes.
- Host/service configuration: implement roles/playbooks in `ansible/`.
- Cluster workload: add/update manifests in `kubernetes/` (Deployments/Services/etc.).
- Pipeline automation: create/update jobs/workflows in `ci-cd/` that call the appropriate folders or `automation-scripts/`.
- Observability/security baselines: place Grafana dashboards/Prometheus rules in `monitoring/`; policy/scanner configs in `security/`.
- Glue or one-off tooling: put scripts in `automation-scripts/` and call them from pipelines.

Current gaps to confirm with maintainers
- Target cloud/virtualization platform(s) and Terraform providers
- CI system of record (GitHub Actions vs Jenkins vs other)
- Kubernetes distribution and ingress choice
- Secret management approach/tooling
- Any naming/versioning conventions for modules, roles, and manifests

If any of the above are clarified, update this file with the concrete commands, file paths, and examples that match this repository.