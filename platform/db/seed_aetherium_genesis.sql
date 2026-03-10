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
);

INSERT INTO workstreams (id, initiative_id, name, description, owner)
VALUES
  ('ws-arch', 'init-aetherium-platform-upgrade', 'Architecture', 'Integration boundaries and system topology decisions.', 'Platform Architect'),
  ('ws-protocol', 'init-aetherium-platform-upgrade', 'Protocol', 'Contract compatibility and versioning strategy.', 'Protocol Lead'),
  ('ws-reliability', 'init-aetherium-platform-upgrade', 'Reliability', 'SLO/error-budget controls and resilience readiness.', 'SRE Lead'),
  ('ws-benchmark', 'init-aetherium-platform-upgrade', 'Benchmark', 'Scenario benchmarks and regression quality gates.', 'QA Lead'),
  ('ws-ops', 'init-aetherium-platform-upgrade', 'Ops', 'Observability, runbooks, and release operations.', 'Ops Lead'),
  ('ws-migration', 'init-aetherium-platform-upgrade', 'Migration', 'Phased rollout/rollback implementation.', 'Engineering Manager');
