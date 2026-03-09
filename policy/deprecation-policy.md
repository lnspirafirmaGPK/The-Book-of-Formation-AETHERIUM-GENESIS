# Deprecation Policy for The Book of Formation

To maintain the integrity of the Knowledge Codex, formations follow a strict lifecycle.

## Lifecycle Statuses
1. **Draft**: Development phase. Not for runtime use.
2. **Review**: Candidate for the Canon. Under validation.
3. **Canonical**: Approved for production runtime use. Immutable versioning.
4. **Deprecated**: Still available but no longer recommended.
5. **Archived**: Removed from active indexes but preserved in history.

## Process
- **Major changes** to a Canonical formation require a new `version` (Semantic Versioning).
- **Deprecation** must include a `supersedes` or `deprecated_by` field in the manifest.
- **Linage** must be preserved to ensure auditability across versions.
