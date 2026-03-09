# Ingestion Pipeline Specification

**Status**: Phase 3 Skeleton / Integration Spec

## Objective
A systematic workflow for onboarding new assets (video/stills) and creating new formation entries.

## Pipeline Steps
1. **Source Capture**: Upload raw reference to `sources/`.
2. **Annotation**: Use `schemas/annotation.schema.yaml` to create dual-layer notes.
3. **Drafting**: Create a new formation entry in `formations/` using `schemas/formation.schema.yaml`.
4. **Validation**: Local schema and integrity checks (via CI).
5. **Preview**: Review the result in the `Preview Studio` (see `preview-studio-spec.md`).
6. **Governance Gate**: Check against `policy/review-checklist.yaml`.
7. **Promotion**: Update `manifest/formations.index.yaml` to `status: canonical`.

## Automation
- **GitHub PR Template**: Pre-filled with the Governance Checklist.
- **CI/CD**: Auto-linting and semantic range enforcement.
