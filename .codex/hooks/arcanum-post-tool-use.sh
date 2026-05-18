#!/usr/bin/env bash
set -euo pipefail

if ! command -v jq >/dev/null 2>&1; then
  printf '{}\n'
  exit 0
fi

input="$(cat)"
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
observability_dir="$repo_root/.arcanum/observability"
turn_id="$(printf '%s\n' "$input" | jq -r '.turn_id // "unknown-turn"')"
safe_turn="${turn_id//[^A-Za-z0-9._-]/-}"
run_id="arcanum-hook-$safe_turn"
run_dir="$observability_dir/runs/arcanum-hooks/$run_id"
envelope="$run_dir/pending-envelope.json"

if [[ ! -f "$envelope" ]]; then
  printf '{}\n'
  exit 0
fi

mkdir -p "$run_dir"
printf '%s\n' "$input" | jq -c '{
  timestamp: (now | todateiso8601),
  turn_id: (.turn_id // null),
  tool_name: (.tool_name // null),
  tool_use_id: (.tool_use_id // null),
  tool_input: (.tool_input // null),
  tool_response: (.tool_response // null)
}' >> "$run_dir/tool-events.jsonl"

tmp="$(mktemp)"
jq '.execution.validation += ["codex PostToolUse hook recorded tool evidence"]' "$envelope" > "$tmp" && mv "$tmp" "$envelope"

printf '{}\n'
