#!/usr/bin/env bash
set -euo pipefail

if ! command -v jq >/dev/null 2>&1; then
  printf '{}\n'
  exit 0
fi

input="$(cat)"
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
observability_dir="$repo_root/.arcanum/observability"
observer="$repo_root/framework/observability/scripts/observe-invocation.sh"
turn_id="$(printf '%s\n' "$input" | jq -r '.turn_id // "unknown-turn"')"
safe_turn="${turn_id//[^A-Za-z0-9._-]/-}"
run_id="arcanum-hook-$safe_turn"
run_dir="$observability_dir/runs/arcanum-hooks/$run_id"
pending="$run_dir/pending-envelope.json"
closed="$run_dir/envelope.json"

if [[ ! -f "$pending" ]]; then
  printf '{}\n'
  exit 0
fi

timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
last_message="$(printf '%s\n' "$input" | jq -r '.last_assistant_message // ""')"
tool_event_count=0
if [[ -f "$run_dir/tool-events.jsonl" ]]; then
  tool_event_count="$(wc -l < "$run_dir/tool-events.jsonl" | tr -d ' ')"
fi

tmp="$(mktemp)"
jq \
  --arg timestamp "$timestamp" \
  --arg last_message "$last_message" \
  --argjson tool_event_count "$tool_event_count" \
  '.timestamp = $timestamp
  | .execution.status = "completed"
  | .execution.validation += ["codex Stop hook closed observer envelope"]
  | .execution.notes = ((.execution.notes // "") + "; tool_events=" + ($tool_event_count|tostring))
  | .observer.quality_bar_status = "pass"
  | .observer.recommendation = "none"
  | .observer.closeout_excerpt = ($last_message | if length > 800 then .[0:800] else . end)' \
  "$pending" > "$tmp" && mv "$tmp" "$closed"

if [[ ! -x "$observer" ]]; then
  jq -n --arg reason "Arcanum observer unavailable at framework/observability/scripts/observe-invocation.sh" '{
    decision: "block",
    reason: $reason
  }'
  exit 0
fi

observe_output="$("$observer" --envelope "$closed" --observability-dir "$observability_dir" 2>&1 || true)"
printf '%s\n' "$observe_output" > "$run_dir/observer-output.txt"

if printf '%s\n' "$observe_output" | grep -q '^OBSERVATION=\(recorded\|skipped\)'; then
  rm -f "$pending"
  jq -n --arg context "$observe_output" '{
    hookSpecificOutput: {
      hookEventName: "Stop",
      additionalContext: ("Arcanum observer closeout completed.\n" + $context)
    }
  }'
  exit 0
fi

jq -n --arg reason "Arcanum observer closeout did not complete. Inspect .arcanum/observability/runs/arcanum-hooks and finish telemetry before final closeout." '{
  decision: "block",
  reason: $reason
}'
