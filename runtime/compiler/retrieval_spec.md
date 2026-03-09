# Motion Archetype Retrieval Engine Spec

## Input
- intent_vector
- emotional_valence
- urgency
- conversational_mode
- trust_context

## Output
- top_k_candidates
- confidence_per_candidate
- fallback_archetype
- forbidden_archetypes (policy-derived)

## Retrieval Logic (v1)
1. Filter by phase compatibility (`emergence/stabilization/dissolution`).
2. Score semantic proximity with machine annotations.
3. Apply governance constraints.
4. Return top-k with confidence calibration.
