#!/usr/bin/env bash
set -euo pipefail

# Defaults can be overridden by environment variables.
export PGHOST="${PGHOST:-localhost}"
export PGPORT="${PGPORT:-5432}"
export PGUSER="${PGUSER:-postgres}"
export PGDATABASE="${PGDATABASE:-postgres}"

printf 'Using connection settings:\n'
printf '  PGHOST=%s\n' "$PGHOST"
printf '  PGPORT=%s\n' "$PGPORT"
printf '  PGUSER=%s\n' "$PGUSER"
printf '  PGDATABASE=%s\n' "$PGDATABASE"

exec psql
