# Repository Architecture: The Book of Formation
## Canonical Knowledge Codex for AETHERIUM GENESIS

This repository serves as the **External Embodied Knowledge Base** for the AETHERIUM GENESIS platform. It defines the formal language of light, movement, and formation used by the AI cognitive core to express intent through generative interfaces.

---

## 1. System Role & Philosophy

In the AETHERIUM GENESIS ecosystem, **The Book of Formation** is the "Memory of Motion."

- **Frontend/Embodied Interface**: Executes the visuals (Three.js, Shaders, Particles).
- **Cognitive Core**: Reasons and generates intent (LLMs, Reasoning Engines).
- **AetherBus**: Securely transports intent vectors between components.
- **The Book of Formation (This Repo)**: Provides the **Semantic Reference** for how intent should look and move.

### Hard Constraint: No Executable Runtime Logic
This repository **must not** contain active runtime code (e.g., actual rendering engines or retrieval servers). It contains **Definitions, Schemas, Policies, and Contracts**. This ensures the "Canon" remains a pure knowledge layer, decoupled from specific implementation stacks.

---

## 2. Core Components

### 2.1 Manifest System (`/manifest`, `/schemas`)
The "Spine" of the codex.
- **Schemas**: JSON/YAML definitions for Formations, Annotations, and Manifests.
- **Index**: A global registry of all valid archetypes.
- **Lineage**: A relationship graph showing how formations derive from or supersede one another.

### 2.2 Formation Layer (`/formations`)
The "Embodied Knowledge" entries.
- Each entry combines **Poetic Narrative** (Human-facing Thai) and **Normalized Semantic Profiles** (Machine-facing English keys with 0.0 - 1.0 values).
- Parameters include: `onset_speed`, `coherence`, `turbulence`, `decay_tail`, etc.

### 2.3 Governance & Policy (`/policy`)
The "Regulatory Layer" for motion.
- **Policy Matrix**: Defines which archetypes are allowed in specific internal states (e.g., `calm`, `trust_sensitive`).
- **Allowed Enums**: Controlled vocabulary for phases, curves, and archetypes.
- **Review Checklist**: Mandatory quality gates for new entries.

---

## 3. Integration Interface (Contracts)

Systems interacting with this codex follow the technical contracts defined in `/specs`:

1.  **Retrieval Contract**: Input (Intent Vector + State) -> Output (Archetype ID).
2.  **Compiler Contract**: Input (Semantic Profile) -> Output (Runtime Preset / Shader Uniforms).
3.  **Adapter Contract**: Interface for AetherBus to wrap formation data into secure envelopes.

---

## 4. Development & Content Ingestion

### Validation Workflow
The repository uses GitHub Actions (`.github/workflows/validate-content.yaml`) to enforce:
- **Schema Validation**: All YAML files must match the canonical schemas.
- **Integrity Checks**: All paths referenced in the manifest must exist.
- **Normalization**: Numeric values must stay within the [0.0 - 1.0] range.

### Language Strategy
- **English**: Reserved for technical keys, schemas, enum values, and machine-facing fields.
- **Poetic Thai**: Reserved for narrative descriptions, author notes, and human-facing meanings to preserve the "Codex" identity.

---

## Summary (Technical)

The Book of Formation is a **Governance-aware, Semantic Knowledge Repo** that:
- Decouples "Motion Meaning" from "Rendering Implementation."
- Provides a normalized model for AI-driven generative UI.
- Enforces content integrity and safety through schema-driven governance.
- Serves as the "Universal Reference" for all light engineering in AETHERIUM GENESIS.
