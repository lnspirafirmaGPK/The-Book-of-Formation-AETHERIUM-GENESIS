# Formation Compiler Specification

**Status**: Phase 2-3 Skeleton / Technical Contract

## Objective
To transform a static **Formation Entry** (Semantic Profile) into a **Runtime Payload** executable by graphics engines (Three.js, WebGL, Unity).

## I/O Contract

### Input: Semantic Profile
```yaml
onset_speed: 0.18
expansion_rate: 0.42
coherence: 0.81
turbulence: 0.12
curves:
  onset_curve: sigmoid_soft
```

### Output: Runtime Payload (Three.js Example)
```json
{
  "shader_uniforms": {
    "uOnsetRate": 0.18,
    "uCoherenceBias": 0.81,
    "uTurbulenceAmplitude": 0.12,
    "uCurveType": 2
  },
  "particle_system": {
    "max_particles": 500000,
    "spawn_rate": 2500,
    "lifespan_base": 0.42
  }
}
```

## Mapping Logic
- **Normalization**: Compiler maps [0.0 - 1.0] to engine-specific units.
- **Curve Approximation**: Translates `sigmoid_soft` into Bezier control points or shader step functions.
- **Bias Generation**: Combines `archetype` and `semantic_profile` to set post-processing (Bloom, Blur) parameters.
