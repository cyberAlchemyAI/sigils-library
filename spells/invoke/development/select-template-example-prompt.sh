#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
exec "$ROOT_DIR/arcanum/arcana/experiment-harness/scripts/select-prompt.sh" "$ROOT_DIR/arcanum/spells/invoke" "$@"
