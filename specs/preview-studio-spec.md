# Preview Studio Specification

**Status**: Phase 2-3 Skeleton / UX Blueprint

## Objective
An interactive frontend for reviewing and testing formations without full runtime integration.

## Component Hierarchy
- `FormationBrowser`: List and filter canonical formations.
- `Viewport`: Simple Three.js renderer displaying the selected archetype.
- `ParameterInspector`: Real-time tweak of semantic profile (0.0-1.0).
- `IntentSimulator`: Input mock intent vectors to test the Retrieval Engine.
- `AnnotationViewer`: Sync human narrative notes with the visual timeline.

## Data Flow
1. User selects a formation.
2. `FormationResolver` fetches manifest data.
3. `MockCompiler` generates a temporary shader payload.
4. `Viewport` renders the visual result.
5. User adjusts `Turbulence` (0.1 -> 0.8) and sees live feedback.

## Integration
- **GitHub Auth**: Reviewers only.
- **Export**: Generate preset JSON for AETHERIUM-GENESIS.
