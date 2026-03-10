# The Book of Formation — AETHERIUM · GENESIS

Canonical knowledge repository for formation semantics used by AETHERIUM · GENESIS.

## 1) Repository Purpose

This repository is the **single source of truth** for:
- Formation definitions (`formations/`)
- Machine + human annotations (`annotations/`)
- Validation schemas (`schemas/`)
- Governance policies (`policy/`)
- Interface contracts (`specs/`)
- Planning control-plane artifacts (`platform/`)

> Runtime rendering services are out of scope. This repo stores standards, contracts, and planning data only.

---

## 2) System Architecture Diagram

```mermaid
flowchart TD
    A[Intent + Internal State] --> B[Retrieval Engine\n(specs/retrieval-contract.md)]
    B --> C[Formation ID\n(manifest/formations.index.yaml)]
    C --> D[Formation Payload\n(formations/*.yaml)]
    D --> E[Compiler\n(specs/compiler-contract.md)]
    E --> F[Runtime Preset / Shader Bias]

    D --> G[Policy Validation\n(policy/formation-policy-matrix.yaml)]
    G --> E

    H[Annotation Layer\nannotations/human + annotations/machine] --> D
    I[Planning Control Plane\nplatform/db/*.sql] --> J[Delivery Governance\nworkstreams, gates, risks, rollout]
```

---

## 3) Repository Structure

```text
The-Book-of-Formation-AETHERIUM-GENESIS/
├─ annotations/        # Human narratives + machine-level annotation payloads
├─ evaluation/         # Scenario set + metrics specification
├─ examples/           # Reference examples for valid payload shape
├─ formation/          # Legacy drafts retained for reference/migration
├─ formations/         # Canonical formation records (active source)
├─ manifest/           # Global formation index + lineage index
├─ platform/
│  ├─ create_platform_work.md
│  └─ db/
│     ├─ platform_work_schema.sql
│     └─ seed_aetherium_genesis.sql
├─ policy/             # Governance matrix + review checklist + allowed enums
├─ runtime/            # Runtime integration specifications (non-executable)
├─ schemas/            # Validation schemas
├─ specs/              # Contracts: retrieval/compiler/adapter/evaluation/preview
└─ studio/             # Studio specification drafts
```

---

## 4) Consistency Rules

- Use `formations/` as the canonical active dataset.
- Keep machine-facing keys in **English**.
- Keep narrative-facing prose in **Thai and/or English**, without duplicating equivalent sections unnecessarily.
- Keep operational controls in `platform/` and domain semantics in `formations/`, `annotations/`, `policy/`, `specs/`.

---

## 5) Platform Work Planning (Operational)

- Workstream model: Architecture / Protocol / Reliability / Benchmark / Ops / Migration
- Backlog hierarchy: Epic → Story → Task
- Production controls: SLO gates, benchmark gates, risks, rollout phases

Files:
- `platform/create_platform_work.md`
- `platform/db/platform_work_schema.sql`
- `platform/db/seed_aetherium_genesis.sql`

---

## 6) Future Roadmap (Not Yet Implemented)

| Theme | Planned capability | Success metric |
|---|---|---|
| Scenario presets | Preconfigured rollout scenarios (strict / balanced / fast-track) | 100% initiatives select a named preset before execution |
| Gate automation | CI-generated gate status snapshots per release candidate | 0 manual gate aggregation steps |
| Lineage explainability | Auto-generated lineage impact report for each formation change | < 5 minutes per impact report generation |

This section is intentionally separated from active operations to avoid mixing implemented and proposed capabilities.

---

## 7) Quick Validation Commands

```bash
# Schema + seed SQL syntax check (PostgreSQL parser)
psql -v ON_ERROR_STOP=1 -f platform/db/platform_work_schema.sql
psql -v ON_ERROR_STOP=1 -f platform/db/seed_aetherium_genesis.sql
```

