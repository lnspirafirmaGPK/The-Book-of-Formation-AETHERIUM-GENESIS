# CREATE_PLATFORM_WORK — AETHERIUM · GENESIS

## Structured Context (Single Source of Truth)
- **Initiative:** AETHERIUM · GENESIS Platform Reliability & Knowledge Operations Upgrade
- **Scope:** services / modules / infra across retrieval, compiler, policy, evaluation, and platform operations
- **Drivers:** reliability, cost, latency, security, developer experience
- **Current State (as-is):** Core schemas/specs exist, but production execution controls (gates, ownership, rollout state, risk tracking) are scattered.
- **Target State (to-be):** A database-backed operating model with measurable release gates, explicit ownership, and reversible migration.
- **Constraints:** P95 retrieval latency <= 120ms; compile success >= 99.5%; zero critical policy violations in RC; 2-quarter timeline; lineage traceability mandatory.
- **Dependencies:** Runtime team, Platform SRE, Security Governance, QA/Evaluation, CI maintainers.

---

## 1) Workstreams
1. **Architecture** — Define control-plane boundaries and artifact ownership.
2. **Protocol** — Version compatibility rules for retrieval/compiler/adapter contracts.
3. **Reliability** — SLO/error-budget governance and resilience tests.
4. **Benchmark** — Deterministic benchmark suites and promotion gates.
5. **Ops** — Observability, incident response, and runbook maturity.
6. **Migration** — Phased adoption with rollback guarantees.

---

## 2) Backlog (Epic -> Story -> Task with measurable acceptance criteria)

### Epic A — Control Plane Foundation
**Story A1:** Persist work model as relational data.
- **Task A1.1:** Create normalized tables for initiative/workstream/epic/story/task/gate/risk/rollout/benchmark.
  - **Acceptance:** Migration applies without errors; FK and CHECK constraints validated; idempotent re-run passes.
- **Task A1.2:** Seed baseline initiative data.
  - **Acceptance:** Upsert seed produces 0 constraint violations and >= 95% non-null governance fields.

**Story A2:** Remove duplicate planning artifacts.
- **Task A2.1:** Consolidate overlapping planning notes into canonical records.
  - **Acceptance:** Every active item maps to one canonical DB record ID and one canonical doc anchor.

### Epic B — Protocol & Compatibility Governance
**Story B1:** Contract compatibility policy.
- **Task B1.1:** Add compatibility strategy field (`backward`, `forward`, `breaking`) per protocol change.
  - **Acceptance:** 100% of new protocol changes tagged; breaking changes require migration plan ID.
- **Task B1.2:** Attach spec version references to work items.
  - **Acceptance:** Each protocol story links to at least one spec path and version.

### Epic C — Reliability & SLO Gates
**Story C1:** SLO gate definitions and enforcement.
- **Task C1.1:** Register latency and compile-success gates.
  - **Acceptance:** Retrieval P95 <= 120ms and compile success >= 99.5% computed from rolling 24h window.
- **Task C1.2:** Define error-budget policy.
  - **Acceptance:** Budget consumption alerts fire within 5 minutes of threshold breach.

### Epic D — Benchmark Readiness
**Story D1:** Release benchmark gate.
- **Task D1.1:** Track benchmark run results in DB.
  - **Acceptance:** RC promotion blocked when critical scenario pass rate < 95%.
- **Task D1.2:** Add regression tolerance policy.
  - **Acceptance:** Performance regression > 3% triggers mandatory rollback decision review.

### Epic E — Ops & Runbook Maturity
**Story E1:** Observability and incident control.
- **Task E1.1:** Dashboard for gate status, risk heatmap, and rollout phase.
  - **Acceptance:** Dashboard refresh interval <= 60s; alert routes verified for Sev-1 and Sev-2.
- **Task E1.2:** Publish runbooks and escalation matrix.
  - **Acceptance:** Incident drill MTTR <= 15 minutes for rollback execution scenario.

### Epic F — Migration Execution
**Story F1:** Safe phased rollout.
- **Task F1.1:** Execute Phase 0->3 adoption plan.
  - **Acceptance:** Entry/exit criteria logged for every phase transition.
- **Task F1.2:** Validate rollback from each phase.
  - **Acceptance:** Rollback success >= 99% in simulation; data integrity checks pass post-rollback.

---

## 3) Recommendation (Options + tradeoffs + chosen)

### Option 1 — Document-only governance
- **Pros:** Low setup effort.
- **Cons:** Weak traceability, low automation, manual audit burden.

### Option 2 — Repository-native DB control plane (**Chosen**)
- **Pros:** Strong auditability, measurable gates, automation-ready, aligned with version-controlled source-of-truth.
- **Cons:** Requires schema ownership and migration discipline.

### Option 3 — External planning SaaS
- **Pros:** Fast UI adoption.
- **Cons:** Knowledge drift risk and vendor lock-in.

**Chosen:** Option 2 for best reliability/governance balance and minimal source-of-truth drift.

---

## 4) Risks, Failure Modes, Mitigations
- **Risk:** Data staleness.
  - **Failure Mode:** Decisions made on outdated rollout/gate state.
  - **Mitigation:** Weekly freshness audit + CI check for untouched records > 14 days.
- **Risk:** Gate friction causes bypass behavior.
  - **Failure Mode:** Untracked exceptions and shadow releases.
  - **Mitigation:** Tiered gates (warn -> block), expiring waivers, leadership review.
- **Risk:** Ambiguous ownership during incident.
  - **Failure Mode:** Slow rollback and higher user impact.
  - **Mitigation:** Named owner + delegate per phase; incident commander default assignment.

---

## 5) Rollout / Rollback Plan (Owner + Timeline)

| Phase | Timeline | Owner | Entry Criteria | Exit Criteria | Rollback Trigger |
|---|---|---|---|---|---|
| Phase 0: Baseline | Week 1 | Platform PM | Schema approved | Seed validated | Migration apply failure |
| Phase 1: Canary | Week 2-3 | SRE Lead | 20% teams onboarded | No Sev-1/2 for 7 days | Gate integrity mismatch |
| Phase 2: Partial | Week 4-6 | Eng Manager | 60% workstreams active | Weekly SLA reporting stable | Freshness < 90% |
| Phase 3: Full | Week 7-8 | Head of Platform | 100% active tracking | Audit pass | Critical compliance breach |

**Rollback Objective:** Freeze writes, restore last-known-good snapshot, and resume with validated read-only mode within 15 minutes.

---

## 6) Production Definition of Done
- **Tests:** schema migration tests, seed integrity tests, contract compatibility tests all pass at 100%.
- **SLO Gates:** retrieval P95 <= 120ms; compile success >= 99.5% over rolling 24h.
- **Benchmark Gates:** critical scenario pass rate >= 95%; regression delta <= 3%.
- **Observability:** live dashboards + alerting wired for gate breach, stale records, incident states.
- **Runbooks:** rollout/rollback + incident command procedures published and drill-validated.
- **Security Checks:** policy matrix validation, least-privilege DB roles, audit log retention enabled.

---

## 7) Architecture / Protocol Update Outline
1. Introduce a non-runtime planning control-plane database.
2. Link every backlog item to spec and contract versions.
3. Require compatibility classification for protocol changes.
4. Persist benchmark outcomes as promotion evidence.
5. Store exception/waiver records with owner + expiry.

---

## 8) Reliability & Ops Readiness Checklist
- [ ] SLO queries validated against production-like telemetry.
- [ ] Release gates enforced in CI/CD.
- [ ] Incident alert routes tested (primary + fallback).
- [ ] Rollback drill completed with <= 15m target.
- [ ] Security review signed off for DB roles and access paths.
- [ ] Data duplication removed; canonical IDs referenced by docs.
