-- AETHERIUM GENESIS planning/control-plane schema
-- PostgreSQL-compatible and safe to re-run.

CREATE TABLE IF NOT EXISTS initiatives (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  scope TEXT NOT NULL,
  drivers TEXT NOT NULL,
  current_state TEXT NOT NULL,
  target_state TEXT NOT NULL,
  constraints_text TEXT NOT NULL,
  dependencies_text TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS workstreams (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  owner TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS epics (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  workstream_id TEXT,
  title TEXT NOT NULL,
  objective TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('planned', 'active', 'blocked', 'done')),
  owner TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (initiative_id, workstream_id) REFERENCES workstreams(initiative_id, id)
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_workstreams_initiative_id_id
  ON workstreams (initiative_id, id);

CREATE TABLE IF NOT EXISTS stories (
  id TEXT PRIMARY KEY,
  epic_id TEXT NOT NULL REFERENCES epics(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  objective TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('planned', 'active', 'blocked', 'done')),
  owner TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tasks (
  id TEXT PRIMARY KEY,
  story_id TEXT NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  acceptance_criteria TEXT NOT NULL,
  metric_name TEXT NOT NULL,
  metric_target TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('todo', 'in_progress', 'blocked', 'done')),
  owner TEXT NOT NULL,
  confidence_score NUMERIC(3,2) CHECK (confidence_score >= 0.00 AND confidence_score <= 1.00),
  due_date DATE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS quality_gates (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  gate_type TEXT NOT NULL CHECK (gate_type IN ('test', 'slo', 'benchmark', 'security', 'observability', 'runbook')),
  name TEXT NOT NULL,
  threshold TEXT NOT NULL,
  measurement_window TEXT NOT NULL,
  blocking BOOLEAN NOT NULL DEFAULT TRUE,
  owner TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS risks (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  risk_text TEXT NOT NULL,
  failure_mode TEXT NOT NULL,
  mitigation_plan TEXT NOT NULL,
  severity TEXT NOT NULL CHECK (severity IN ('low', 'medium', 'high', 'critical')),
  owner TEXT,
  status TEXT NOT NULL CHECK (status IN ('open', 'monitoring', 'mitigated', 'closed')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rollout_phases (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  phase_name TEXT NOT NULL,
  timeline_window TEXT NOT NULL,
  owner TEXT NOT NULL,
  entry_criteria TEXT NOT NULL,
  exit_criteria TEXT NOT NULL,
  rollback_trigger TEXT NOT NULL,
  phase_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (initiative_id, phase_order)
);

CREATE TABLE IF NOT EXISTS benchmark_results (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  scenario_id TEXT NOT NULL,
  metric_name TEXT NOT NULL,
  value_numeric NUMERIC(12,4) NOT NULL,
  target_numeric NUMERIC(12,4) NOT NULL,
  passed BOOLEAN NOT NULL,
  measured_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION touch_updated_at_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS initiatives_update_timestamp ON initiatives;
CREATE TRIGGER initiatives_update_timestamp
BEFORE UPDATE ON initiatives
FOR EACH ROW
EXECUTE FUNCTION touch_updated_at_timestamp();

DROP TRIGGER IF EXISTS workstreams_update_timestamp ON workstreams;
CREATE TRIGGER workstreams_update_timestamp
BEFORE UPDATE ON workstreams
FOR EACH ROW
EXECUTE FUNCTION touch_updated_at_timestamp();

DROP TRIGGER IF EXISTS epics_update_timestamp ON epics;
CREATE TRIGGER epics_update_timestamp
BEFORE UPDATE ON epics
FOR EACH ROW
EXECUTE FUNCTION touch_updated_at_timestamp();

DROP TRIGGER IF EXISTS stories_update_timestamp ON stories;
CREATE TRIGGER stories_update_timestamp
BEFORE UPDATE ON stories
FOR EACH ROW
EXECUTE FUNCTION touch_updated_at_timestamp();

DROP TRIGGER IF EXISTS tasks_update_timestamp ON tasks;
CREATE TRIGGER tasks_update_timestamp
BEFORE UPDATE ON tasks
FOR EACH ROW
EXECUTE FUNCTION touch_updated_at_timestamp();

DROP TRIGGER IF EXISTS risks_update_timestamp ON risks;
CREATE TRIGGER risks_update_timestamp
BEFORE UPDATE ON risks
FOR EACH ROW
EXECUTE FUNCTION touch_updated_at_timestamp();
