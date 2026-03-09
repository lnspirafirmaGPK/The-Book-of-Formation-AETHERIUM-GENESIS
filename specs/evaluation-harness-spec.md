# Evaluation Harness Specification

**Status**: Phase 3 Skeleton / Technical Contract

## Objective
To measure the "Semantic Fidelity" and "Emotional Congruence" of a chosen formation in a given context.

## Metrics
- **Semantic Fidelity**: Does the visual response match the intent vector? (Automated via vision-language models).
- **Smoothness**: Transition delta between frames.
- **Emotional Congruence**: Perceived emotional valence (Operator Scoring).
- **Policy Violation Rate**: Frequency of Audit Gate rejections.

## Test Scenarios
Standardized intent sequences (Golden Scenarios) to verify system response consistency.

## Workflow
1. Load Golden Scenario.
2. Simulate Intent through Retrieval Engine.
3. Generate Visual Bias via Compiler.
4. Record "Visual Snapshot" of the result.
5. Compare against Golden Reference.
