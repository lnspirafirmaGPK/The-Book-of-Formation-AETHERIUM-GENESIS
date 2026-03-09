# Formation-to-Runtime Compiler Spec

## Source
- `manifest/formations.index.yaml`
- `formation/archetypes/*.yaml`
- `annotations/machine/*.yaml`

## Target payloads
- JSON preset
- shader preset fragment
- physics preset
- UI animation preset

## Canonical mapping
- `particle_bias.spawn_rate` -> `particle_spawn_rate`
- `physics_bias.turbulence_amplitude` -> `turbulence_amplitude`
- `shader_bias.pulse_envelope` -> `shader_pulse_envelope`
- machine semantics influence transition graph

## Output contract (minimal)
```json
{
  "formation_id": "emergence-soft-001",
  "particle_spawn_rate": 0.32,
  "emitter_topology": "spherical",
  "glow_persistence": 0.75,
  "turbulence_amplitude": 0.18,
  "transition_timing_graph": [0.0, 0.2, 0.6, 1.0]
}
```
