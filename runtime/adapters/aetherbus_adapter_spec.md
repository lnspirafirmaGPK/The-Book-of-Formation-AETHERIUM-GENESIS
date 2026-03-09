# AetherBus Integration Adapter Spec

## Responsibility
Bridge AetherBus intent packets to formation runtime bias while preserving governance and auditability.

## Pipeline
1. Receive `intent_vector` + context packet.
2. Query `runtime/compiler/retrieval_spec.md` for top-k archetypes.
3. Resolve candidate with policy constraints (`runtime/compiler/governance_policy_matrix.yaml`).
4. Compile formation into runtime payload (`runtime/compiler/compiler_spec.md`).
5. Return envelope:
   - selected_formation
   - confidence
   - fallback_used
   - runtime_bias
   - audit_trace_id

## Envelope Example
```json
{
  "trace_id": "ab-20260309-001",
  "selected_formation": "emergence-soft-001",
  "confidence": 0.82,
  "fallback_used": false,
  "runtime_bias": {
    "particle_spawn_rate": 0.32,
    "shader_pulse_envelope": 0.35,
    "turbulence_amplitude": 0.18
  }
}
```
