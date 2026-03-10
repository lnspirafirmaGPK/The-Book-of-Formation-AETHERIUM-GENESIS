-- AETHERIUM GENESIS planning/control-plane schema

CREATE TABLE initiatives (
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

CREATE TABLE workstreams (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  owner TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (initiative_id, id)
);

CREATE TABLE epics (
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

CREATE TABLE stories (
  id TEXT PRIMARY KEY,
  epic_id TEXT NOT NULL REFERENCES epics(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  objective TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('planned', 'active', 'blocked', 'done')),
  owner TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tasks (
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

CREATE TABLE quality_gates (
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

CREATE TABLE risks (
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

CREATE TABLE rollout_phases (
  id TEXT PRIMARY KEY,
  initiative_id TEXT NOT NULL REFERENCES initiatives(id) ON DELETE CASCADE,
  phase_name TEXT NOT NULL,
  timeline_window TEXT NOT NULL,
  owner TEXT NOT NULL,
  entry_criteria TEXT NOT NULL,
  exit_criteria TEXT NOT NULL,
  rollback_trigger TEXT NOT NULL,
  phase_order INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE benchmark_results (
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
  EXECUTE format('UPDATE %I SET updated_at = CURRENT_TIMESTAMP WHERE id = $1', TG_TABLE_NAME)
  USING NEW.id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER initiatives_update_timestamp
AFTER UPDATE ON initiatives
FOR EACH ROW
WHEN (NEW.updated_at = OLD.updated_at)
EXECUTE FUNCTION touch_updated_at_timestamp();

CREATE TRIGGER workstreams_update_timestamp
AFTER UPDATE ON workstreams
FOR EACH ROW
WHEN (NEW.updated_at = OLD.updated_at)
EXECUTE FUNCTION touch_updated_at_timestamp();

CREATE TRIGGER epics_update_timestamp
AFTER UPDATE ON epics
FOR EACH ROW
WHEN (NEW.updated_at = OLD.updated_at)
EXECUTE FUNCTION touch_updated_at_timestamp();

CREATE TRIGGER stories_update_timestamp
AFTER UPDATE ON stories
FOR EACH ROW
WHEN (NEW.updated_at = OLD.updated_at)
EXECUTE FUNCTION touch_updated_at_timestamp();

CREATE TRIGGER tasks_update_timestamp
AFTER UPDATE ON tasks
FOR EACH ROW
WHEN (NEW.updated_at = OLD.updated_at)
EXECUTE FUNCTION touch_updated_at_timestamp();

CREATE TRIGGER risks_update_timestamp
AFTER UPDATE ON risks
FOR EACH ROW
WHEN (NEW.updated_at = OLD.updated_at)
EXECUTE FUNCTION touch_updated_at_timestamp();
