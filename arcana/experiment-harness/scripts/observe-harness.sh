#!/usr/bin/env bash
set -euo pipefail

usage() {
	cat <<'USAGE'
Usage:
  observe-harness.sh <artifact-path> [report-path]

Appends one signal-observer-compatible invocation envelope to the repository
observability ledger when .arcanum/observability exists.
USAGE
}

if [[ "$#" -lt 1 || "$#" -gt 2 ]]; then
	usage >&2
	exit 2
fi

if ! command -v jq >/dev/null 2>&1; then
	printf 'OBSERVATION=skipped\n'
	printf 'REASON=jq not found\n'
	exit 0
fi

artifact="$1"
if [[ ! -d "$artifact" ]]; then
	printf 'ERROR: artifact path not found: %s\n' "$artifact" >&2
	exit 1
fi

artifact_abs="$(cd "$artifact" && pwd)"
dev_dir="$artifact_abs/development"
repo_root="${EXPERIMENT_REPO_ROOT:-$(git -C "$PWD" rev-parse --show-toplevel 2>/dev/null || pwd)}"
observability_dir="${EXPERIMENT_OBSERVABILITY_DIR:-$repo_root/.arcanum/observability}"

if [[ ! -d "$observability_dir" ]]; then
	printf 'OBSERVATION=skipped\n'
	printf 'REASON=observability package not found: %s\n' "${observability_dir#$repo_root/}"
	exit 0
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
default_framework_observability_dir="$(cd "$script_dir/../../../framework/observability" && pwd)"
framework_observability_dir="${EXPERIMENT_FRAMEWORK_OBSERVABILITY_DIR:-$default_framework_observability_dir}"
hook_recorder="$framework_observability_dir/scripts/record-hook-operation.sh"
run_starter="$framework_observability_dir/scripts/start-observed-run.sh"
run_checkpointer="$framework_observability_dir/scripts/checkpoint-observed-run.sh"
run_finisher="$framework_observability_dir/scripts/finish-observed-run.sh"

mkdir -p "$observability_dir/signals" "$observability_dir/by-sigil" "$observability_dir/hooks/reflections" "$observability_dir/runs"
ledger="$observability_dir/signals/sigil-invocations.jsonl"
per_sigil_ledger="$observability_dir/by-sigil/experiment-harness.jsonl"
reflection_state="$observability_dir/reflection-state.json"
touch "$ledger" "$per_sigil_ledger" "$observability_dir/hooks/hook-operations.jsonl" "$observability_dir/hooks/failures.jsonl" "$observability_dir/hooks/dedupe.jsonl"

report="${2:-}"
if [[ -z "$report" ]]; then
	report="$(find "$dev_dir/runs" -maxdepth 1 -type f -name '*.md' 2>/dev/null | sort | tail -n 1 || true)"
fi

if [[ -z "$report" || ! -f "$report" ]]; then
	printf 'OBSERVATION=skipped\n'
	printf 'REASON=report not found\n'
	exit 0
fi

report_abs="$(cd "$(dirname "$report")" && pwd)/$(basename "$report")"
report_rel="${report_abs#$repo_root/}"
artifact_rel="${artifact_abs#$repo_root/}"
timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
safe_timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
target_run_id="experiment-${report_rel//[^A-Za-z0-9._-]/-}"
target_session_id="${EXPERIMENT_SESSION_ID:-experiment-harness}"
observer_version="0.1.0"
dedupe_key="$target_run_id:signal-observer:$observer_version"
hook_started_at_ms="$(date +%s%3N)"

record_hook() {
	if [[ -x "$hook_recorder" ]]; then
		"$hook_recorder" \
			--observability-dir "$observability_dir" \
			--hook signal-observer \
			--target-run-id "$target_run_id" \
			--target-session-id "$target_session_id" \
			--action observe \
			--status "$1" \
			--input "$report_rel" \
			--output "${ledger#$repo_root/}" \
			--emitted-signal "${2:-false}" \
			--reason "${3:-}" \
			--duration-ms "${4:-0}" \
			--dedupe-key "$dedupe_key" \
			--observer-version "$observer_version" >/dev/null || true
	fi
}

if [[ -x "$run_starter" ]]; then
	run_output="$("$run_starter" \
		--observability-dir "$observability_dir" \
		--session-id "$target_session_id" \
		--run-id "$target_run_id" \
		--capability experiment-harness \
		--kind sigil \
		--tier arcana \
		--mode observe \
		--summary "Observe experiment harness report for $artifact_rel" \
		--intent "Record experiment validation evidence as telemetry." 2>/dev/null || true)"
	run_dir="$(printf '%s\n' "$run_output" | sed -n 's/^RUN_DIR=//p' | tail -n 1)"
else
	run_dir=""
fi

record_hook started false "observer started" 0

validation="$(sed -n 's/^- Validation: //p' "$report_abs" | head -n 1)"
if [[ -z "$validation" ]]; then
	validation="$(sed -n 's/^RESULT: //p' "$report_abs" | sed 's/ .*//' | tail -n 1)"
fi
if [[ -z "$validation" ]]; then
	validation="not_checked"
fi

case "$validation" in
	pass)
		execution_status="completed"
		quality_bar_status="pass"
		reflection_trigger="none"
		recommendation="none"
		;;
	flag)
		execution_status="partial"
		quality_bar_status="partial"
		reflection_trigger="none"
		recommendation="targeted-update"
		;;
	block|fail|failed)
		execution_status="blocked"
		quality_bar_status="fail"
		reflection_trigger="severe-gap"
		recommendation="reflect-now"
		;;
	*)
		execution_status="partial"
		quality_bar_status="not_checked"
		reflection_trigger="none"
		recommendation="targeted-update"
		;;
esac

prompt_count="$(find "$dev_dir/example-prompts" -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
output_count="$(find "$dev_dir/example-outputs" -maxdepth 1 -type f -name '*.output.md' 2>/dev/null | wc -l | tr -d ' ')"
fixture_count="$(find "$dev_dir/fixtures" -maxdepth 1 -type f -name '*.md' ! -name '*.expected.md' 2>/dev/null | wc -l | tr -d ' ')"

if [[ -n "$run_dir" && -x "$run_checkpointer" ]]; then
	"$run_checkpointer" "$run_dir" \
		--phase "report-summary" \
		--summary "fixtures=$fixture_count prompts=$prompt_count outputs=$output_count validation=$validation" \
		--file "$report_rel" \
		--validation "experiment harness validation: $validation" \
		--next "append signal-observer telemetry" >/dev/null || true
fi

workflow_gaps_json='[]'
if [[ "$validation" != "pass" ]]; then
	workflow_gaps_json="$(
		jq -n \
			--arg severity "$([[ "$validation" == "block" || "$validation" == "fail" || "$validation" == "failed" ]] && printf 'severe' || printf 'medium')" \
			--arg summary "Experiment harness validation returned $validation" \
			--arg evidence "$report_rel" \
			'[{
				category: "validation",
				severity: $severity,
				summary: $summary,
				evidence: $evidence
			}]'
	)"
fi

event="$(
	jq -cn \
		--arg timestamp "$timestamp" \
		--arg sigil "experiment-harness" \
		--arg tier "arcana" \
		--arg mode "observe" \
		--arg summary "Observed experiment harness report for $artifact_rel" \
		--arg intent "Close the experiment cycle by recording harness validation evidence as observability telemetry." \
		--arg status "$execution_status" \
		--arg artifact "$artifact_rel" \
		--arg report "$report_rel" \
		--arg notes "fixtures=$fixture_count prompts=$prompt_count outputs=$output_count validation=$validation" \
		--arg validation_entry "experiment harness validation: $validation" \
		--arg quality "$quality_bar_status" \
		--arg trigger "$reflection_trigger" \
		--arg recommendation "$recommendation" \
		--argjson workflow_gaps "$workflow_gaps_json" \
		'{
			timestamp: $timestamp,
			sigil: $sigil,
			tier: $tier,
			mode: $mode,
			request: {
				raw: null,
				summary: $summary,
				intent: $intent
			},
			execution: {
				status: $status,
				outputs: [$report],
				files_changed: [$report],
				validation: [$validation_entry],
				notes: $notes
			},
			observer: {
				quality_bar_status: $quality,
				anti_pattern_hits: [],
				workflow_gaps: $workflow_gaps,
				output_contract_drift: false,
				reflection_trigger: $trigger,
				recommendation: $recommendation
			},
			target_artifact: $artifact
		}'
)"

dedupe_probe="$("$hook_recorder" \
	--observability-dir "$observability_dir" \
	--hook signal-observer \
	--target-run-id "$target_run_id" \
	--target-session-id "$target_session_id" \
	--action append \
	--status completed \
	--input "$report_rel" \
	--output "${ledger#$repo_root/}" \
	--emitted-signal true \
	--reason "capability telemetry append" \
	--duration-ms "$(( $(date +%s%3N) - hook_started_at_ms ))" \
	--dedupe-key "$dedupe_key" \
	--observer-version "$observer_version" 2>/dev/null || true)"

hook_status="$(printf '%s\n' "$dedupe_probe" | sed -n 's/^HOOK_OPERATION=//p' | tail -n 1)"
if [[ "$hook_status" == "skipped" ]]; then
	if [[ -n "$run_dir" && -x "$run_finisher" ]]; then
		"$run_finisher" "$run_dir" \
			--status partial \
			--output "$report_rel" \
			--file "$report_rel" \
			--validation "duplicate observer emission skipped" \
			--notes "dedupe_key=$dedupe_key" >/dev/null || true
	fi
	printf 'OBSERVATION=skipped\n'
	printf 'REASON=duplicate observer emission\n'
	printf 'DEDUPE_KEY=%s\n' "$dedupe_key"
	exit 0
fi

printf '%s\n' "$event" >> "$ledger"
printf '%s\n' "$event" >> "$per_sigil_ledger"

if [[ -f "$reflection_state" ]]; then
	tmp_state="$(mktemp)"
	jq \
		--arg sigil "experiment-harness" \
		--argjson generated_outputs "$output_count" \
		--arg quality "$quality_bar_status" \
		--arg trigger "$reflection_trigger" \
		'
		.counters.meaningful_executions += 1
		| .counters.generated_outputs += $generated_outputs
		| .counters.related_workflow_gaps += (if $quality == "partial" then 1 else 0 end)
		| .counters.severe_workflow_gaps += (if $trigger == "severe-gap" then 1 else 0 end)
		| .counters.quality_bar_failures += (if $quality == "fail" then 1 else 0 end)
		| .counters.output_contract_drift_events += 0
		| .by_sigil[$sigil].meaningful_executions = ((.by_sigil[$sigil].meaningful_executions // 0) + 1)
		| .by_sigil[$sigil].generated_outputs = ((.by_sigil[$sigil].generated_outputs // 0) + $generated_outputs)
		| .by_sigil[$sigil].last_observed_at = (now | todate)
		' "$reflection_state" > "$tmp_state" && mv "$tmp_state" "$reflection_state"
fi

if [[ -n "$run_dir" && -x "$run_finisher" ]]; then
	"$run_finisher" "$run_dir" \
		--status "$execution_status" \
		--output "$report_rel" \
		--file "$report_rel" \
		--validation "experiment harness validation: $validation" \
		--notes "observer_version=$observer_version dedupe_key=$dedupe_key" >/dev/null || true
fi

printf 'OBSERVATION=recorded\n'
printf 'LEDGER=%s\n' "${ledger#$repo_root/}"
printf 'PER_SIGIL_LEDGER=%s\n' "${per_sigil_ledger#$repo_root/}"
printf 'REFLECTION_TRIGGER=%s\n' "$reflection_trigger"
printf 'RUN_ID=%s\n' "$target_run_id"
printf 'DEDUPE_KEY=%s\n' "$dedupe_key"
