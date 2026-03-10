BEGIN;

INSERT INTO initiatives (id, name, scope, drivers, current_state, target_state, constraints_text, dependencies_text)
VALUES (
  'init-aetherium-platform-upgrade',
  'AETHERIUM GENESIS Platform Reliability & Knowledge Ops Upgrade',
  'services/modules/infra for retrieval, compiler, governance, ops rollout',
  'reliability,cost,latency,security,devex',
  'Repository has contracts and policy docs but limited integrated delivery controls.',
  'Database-backed delivery model with measurable gates and controlled migration plan.',
  'P95<=120ms; compile success>=99.5%; 2-quarter timeline; compliance traceability mandatory.',
  'Runtime team; SRE; security governance; QA; CI maintainers'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  drivers = EXCLUDED.drivers,
  current_state = EXCLUDED.current_state,
  target_state = EXCLUDED.target_state,
  constraints_text = EXCLUDED.constraints_text,
  dependencies_text = EXCLUDED.dependencies_text;

INSERT INTO workstreams (id, initiative_id, name, description, owner)
VALUES
  ('ws-arch', 'init-aetherium-platform-upgrade', 'Architecture', 'Integration boundaries and system topology decisions.', 'Platform Architect'),
  ('ws-protocol', 'init-aetherium-platform-upgrade', 'Protocol', 'Contract compatibility and versioning strategy.', 'Protocol Lead'),
  ('ws-reliability', 'init-aetherium-platform-upgrade', 'Reliability', 'SLO/error-budget controls and resilience readiness.', 'SRE Lead'),
  ('ws-benchmark', 'init-aetherium-platform-upgrade', 'Benchmark', 'Scenario benchmarks and regression quality gates.', 'QA Lead'),
  ('ws-ops', 'init-aetherium-platform-upgrade', 'Ops', 'Observability, runbooks, and release operations.', 'Ops Lead'),
  ('ws-migration', 'init-aetherium-platform-upgrade', 'Migration', 'Phased rollout/rollback implementation.', 'Engineering Manager')
ON CONFLICT (id) DO UPDATE SET
  initiative_id = EXCLUDED.initiative_id,
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  owner = EXCLUDED.owner;

INSERT INTO epics (id, initiative_id, workstream_id, title, objective, status, owner)
VALUES
  ('epic-platform-foundation', 'init-aetherium-platform-upgrade', 'ws-arch', 'Platform Planning Data Foundation', 'Establish relational planning model and traceability.', 'active', 'Platform Architect'),
  ('epic-reliability-gates', 'init-aetherium-platform-upgrade', 'ws-reliability', 'Reliability & Quality Gates', 'Codify SLO and benchmark gates as release controls.', 'active', 'SRE Lead'),
  ('epic-rollout-ops', 'init-aetherium-platform-upgrade', 'ws-migration', 'Migration & Rollout Operations', 'Phase migration with explicit rollback controls.', 'planned', 'Engineering Manager')
ON CONFLICT (id) DO UPDATE SET
  initiative_id = EXCLUDED.initiative_id,
  workstream_id = EXCLUDED.workstream_id,
  title = EXCLUDED.title,
  objective = EXCLUDED.objective,
  status = EXCLUDED.status,
  owner = EXCLUDED.owner;

INSERT INTO stories (id, epic_id, title, objective, status, owner)
VALUES
  ('story-operational-traceability', 'epic-platform-foundation', 'Operational traceability', 'Track accountable execution with measurable completion.', 'active', 'Engineering Manager'),
  ('story-slo-guardrails', 'epic-reliability-gates', 'Define SLO guardrails', 'Publish pass/fail thresholds and measurement windows.', 'active', 'SRE Lead'),
  ('story-phased-rollout', 'epic-rollout-ops', 'Controlled phased rollout', 'Define phase entry/exit and rollback triggers.', 'planned', 'Engineering Manager')
ON CONFLICT (id) DO UPDATE SET
  epic_id = EXCLUDED.epic_id,
  title = EXCLUDED.title,
  objective = EXCLUDED.objective,
  status = EXCLUDED.status,
  owner = EXCLUDED.owner;

INSERT INTO tasks (id, story_id, title, acceptance_criteria, metric_name, metric_target, status, owner, confidence_score, due_date)
VALUES
  (
    'task-task-metadata-coverage',
    'story-operational-traceability',
    'Enforce task metadata completeness',
    'All seeded tasks include owner, status, due date, confidence score, and metric target.',
    'task_metadata_completeness_pct',
    '100',
    'in_progress',
    'Engineering Manager',
    0.93,
    '2026-06-30'
  ),
  (
    'task-seed-validation-query',
    'story-operational-traceability',
    'Add validation query for measurable completion fields',
    'Validation query returns zero rows with missing owner/status/metric fields in task seed set.',
    'task_seed_validation_failures',
    '0',
    'todo',
    'QA Lead',
    0.88,
    '2026-07-07'
  ),
  (
    'task-slo-gate-catalog',
    'story-slo-guardrails',
    'Register SLO gate catalog',
    'Latency and compile-success gates are present with thresholds and measurement windows.',
    'slo_gate_catalog_coverage_pct',
    '100',
    'in_progress',
    'SRE Lead',
    0.91,
    '2026-07-14'
  )
ON CONFLICT (id) DO UPDATE SET
  story_id = EXCLUDED.story_id,
  title = EXCLUDED.title,
  acceptance_criteria = EXCLUDED.acceptance_criteria,
  metric_name = EXCLUDED.metric_name,
  metric_target = EXCLUDED.metric_target,
  status = EXCLUDED.status,
  owner = EXCLUDED.owner,
  confidence_score = EXCLUDED.confidence_score,
  due_date = EXCLUDED.due_date;

INSERT INTO quality_gates (id, initiative_id, gate_type, name, threshold, measurement_window, blocking, owner)
VALUES
  ('gate-retrieval-p95', 'init-aetherium-platform-upgrade', 'slo', 'Retrieval P95 latency', '<=120ms', 'rolling_24h', TRUE, 'SRE Lead'),
  ('gate-compile-success', 'init-aetherium-platform-upgrade', 'slo', 'Formation compile success rate', '>=99.5%', 'rolling_24h', TRUE, 'Runtime Lead'),
  ('gate-critical-benchmark-pass', 'init-aetherium-platform-upgrade', 'benchmark', 'Critical scenario benchmark pass', '>=95%', 'per_release_candidate', TRUE, 'QA Lead')
ON CONFLICT (id) DO UPDATE SET
  initiative_id = EXCLUDED.initiative_id,
  gate_type = EXCLUDED.gate_type,
  name = EXCLUDED.name,
  threshold = EXCLUDED.threshold,
  measurement_window = EXCLUDED.measurement_window,
  blocking = EXCLUDED.blocking,
  owner = EXCLUDED.owner;

INSERT INTO risks (id, initiative_id, risk_text, failure_mode, mitigation_plan, severity, owner, status)
VALUES
  ('risk-schema-drift', 'init-aetherium-platform-upgrade', 'Schema/process divergence from delivery reality', 'Planning data becomes stale and non-actionable', 'Weekly data quality audit + CI lint for mandatory fields', 'high', 'Platform Architect', 'open'),
  ('risk-gate-overstrict', 'init-aetherium-platform-upgrade', 'Overly strict gates delay delivery', 'Teams bypass governance outside official flow', 'Progressive gates (warn->block) and waiver protocol with expiry', 'medium', 'SRE Lead', 'monitoring')
ON CONFLICT (id) DO UPDATE SET
  initiative_id = EXCLUDED.initiative_id,
  risk_text = EXCLUDED.risk_text,
  failure_mode = EXCLUDED.failure_mode,
  mitigation_plan = EXCLUDED.mitigation_plan,
  severity = EXCLUDED.severity,
  owner = EXCLUDED.owner,
  status = EXCLUDED.status;

INSERT INTO rollout_phases (id, initiative_id, phase_name, timeline_window, owner, entry_criteria, exit_criteria, rollback_trigger, phase_order)
VALUES
  ('phase-0', 'init-aetherium-platform-upgrade', 'Baseline', 'Week 1', 'Platform PM', 'Schema approved', 'Seed data available', 'Schema migration failure', 0),
  ('phase-1', 'init-aetherium-platform-upgrade', 'Canary', 'Week 2-3', 'SRE Lead', '20% teams onboarded', 'No Sev-1/2 incident for 7 days', 'Gate integrity mismatch', 1),
  ('phase-2', 'init-aetherium-platform-upgrade', 'Partial', 'Week 4-6', 'Engineering Manager', '60% workstreams active', 'Weekly SLA reports generated', 'Data freshness below 90%', 2),
  ('phase-3', 'init-aetherium-platform-upgrade', 'Full', 'Week 7-8', 'Head of Platform', '100% active projects tracked', 'Quarterly audit passed', 'Critical compliance breach', 3)
ON CONFLICT (id) DO UPDATE SET
  initiative_id = EXCLUDED.initiative_id,
  phase_name = EXCLUDED.phase_name,
  timeline_window = EXCLUDED.timeline_window,
  owner = EXCLUDED.owner,
  entry_criteria = EXCLUDED.entry_criteria,
  exit_criteria = EXCLUDED.exit_criteria,
  rollback_trigger = EXCLUDED.rollback_trigger,
  phase_order = EXCLUDED.phase_order;

COMMIT;
