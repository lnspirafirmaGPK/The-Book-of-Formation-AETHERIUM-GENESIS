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
  ('epic-platform-foundation', 'init-aetherium-platform-upgrade', 'ws-arch', 'Platform Planning Data Foundation', 'Establish relational planning model and traceability.', 'active', 'Platform Architect')
ON CONFLICT (id) DO UPDATE SET
  initiative_id = EXCLUDED.initiative_id,
  workstream_id = EXCLUDED.workstream_id,
  title = EXCLUDED.title,
  objective = EXCLUDED.objective,
  status = EXCLUDED.status,
  owner = EXCLUDED.owner;

INSERT INTO stories (id, epic_id, title, objective, status, owner)
VALUES
  ('story-operational-traceability', 'epic-platform-foundation', 'Operational traceability', 'Track accountable execution with measurable completion.', 'active', 'Engineering Manager')
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

COMMIT;
