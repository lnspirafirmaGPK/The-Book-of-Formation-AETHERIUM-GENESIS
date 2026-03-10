#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
ENV_FILE="${REPO_ROOT}/platform/db/psql.env"
EXAMPLE_ENV_FILE="${REPO_ROOT}/platform/db/psql.env.example"

SAVED_PGHOST="${PGHOST-}"
SAVED_PGPORT="${PGPORT-}"
SAVED_PGUSER="${PGUSER-}"
SAVED_PGDATABASE="${PGDATABASE-}"
HAD_PGHOST="${PGHOST+x}"
HAD_PGPORT="${PGPORT+x}"
HAD_PGUSER="${PGUSER+x}"
HAD_PGDATABASE="${PGDATABASE+x}"

if [[ -f "${ENV_FILE}" ]]; then
  # shellcheck source=/dev/null
  source "${ENV_FILE}"
elif [[ -f "${EXAMPLE_ENV_FILE}" ]]; then
  # shellcheck source=/dev/null
  source "${EXAMPLE_ENV_FILE}"
fi

if [[ -n "${HAD_PGHOST}" ]]; then
  export PGHOST="${SAVED_PGHOST}"
fi
if [[ -n "${HAD_PGPORT}" ]]; then
  export PGPORT="${SAVED_PGPORT}"
fi
if [[ -n "${HAD_PGUSER}" ]]; then
  export PGUSER="${SAVED_PGUSER}"
fi
if [[ -n "${HAD_PGDATABASE}" ]]; then
  export PGDATABASE="${SAVED_PGDATABASE}"
fi

# Defaults can be overridden by environment variables or env files.
export PGHOST="${PGHOST:-localhost}"
export PGPORT="${PGPORT:-5432}"
export PGUSER="${PGUSER:-postgres}"
export PGDATABASE="${PGDATABASE:-postgres}"

if ! command -v psql >/dev/null 2>&1; then
  printf 'Error: psql is not installed or is not available in PATH.\n' >&2
  printf 'Install PostgreSQL client tools, then retry.\n' >&2
  exit 127
fi

printf 'Using connection settings:\n'
printf '  PGHOST=%s\n' "$PGHOST"
printf '  PGPORT=%s\n' "$PGPORT"
printf '  PGUSER=%s\n' "$PGUSER"
printf '  PGDATABASE=%s\n' "$PGDATABASE"

exec psql "$@"
