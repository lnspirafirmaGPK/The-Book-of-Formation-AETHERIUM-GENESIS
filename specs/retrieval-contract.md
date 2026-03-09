# Motion Archetype Retrieval Specification

**Status**: Phase 2-3 Skeleton / Interface Definition

## Objective
To select the most appropriate **Formation Archetype** based on an input **Intent Vector** and **Internal State**.

## Query Interface

### Request Pattern
```json
{
  "intent_vector": [0.8, 0.2, 0.5],
  "emotional_valence": 0.7,
  "internal_state": "calm",
  "urgency": 0.1,
  "context": "governance_audit"
}
```

### Response Pattern
```json
{
  "selected_formation_id": "emergence-soft-001",
  "confidence_score": 0.94,
  "fallback_id": "stabilization-sacred-001",
  "governance_applied": ["max_intensity_cap", "forbidden_vibrant_pulse"]
}
```

## Selection Process
1. **Semantic Filter**: Filter candidates by `internal_state` against the Policy Matrix.
2. **Vector Alignment**: Rank candidates by cosine similarity of intent vs. formation semantic profiles.
3. **Audit Gate**: Final check for forbidden archetypes or intensity caps based on context.
