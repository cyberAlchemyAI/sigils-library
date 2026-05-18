#!/usr/bin/env bash
set -euo pipefail

usage() {
	cat <<'USAGE'
Usage:
  report-harness.sh <artifact-path>

Writes a timestamped report. If .arcanum/observability exists, also appends
one signal-observer-compatible telemetry event unless EXPERIMENT_OBSERVE=0.
USAGE
}

if [[ "$#" -ne 1 ]]; then
	usage >&2
	exit 2
fi

artifact="$1"
if [[ ! -d "$artifact" ]]; then
	printf 'ERROR: artifact path not found: %s\n' "$artifact" >&2
	exit 1
fi

artifact_abs="$(cd "$artifact" && pwd)"
dev_dir="$artifact_abs/development"
run_dir="$dev_dir/runs"
mkdir -p "$run_dir"

repo_root="${EXPERIMENT_REPO_ROOT:-$(git -C "$PWD" rev-parse --show-toplevel 2>/dev/null || pwd)}"

prompt_count="$(find "$dev_dir/example-prompts" -maxdepth 1 -type f -name '*.md' 2>/dev/null | wc -l | tr -d ' ')"
output_count="$(find "$dev_dir/example-outputs" -maxdepth 1 -type f -name '*.output.md' 2>/dev/null | wc -l | tr -d ' ')"
fixture_count="$(find "$dev_dir/fixtures" -maxdepth 1 -type f -name '*.md' ! -name '*.expected.md' 2>/dev/null | wc -l | tr -d ' ')"

validation_output="$("$dev_dir/run-validation-fixtures.sh" 2>&1 || true)"
validation="$(printf '%s\n' "$validation_output" | sed -n 's/^VALIDATION=//p' | tail -n 1)"
if [[ -z "$validation" ]]; then
	validation="$(printf '%s\n' "$validation_output" | sed -n 's/^RESULT: //p' | sed 's/ .*//' | tail -n 1)"
fi
if [[ -z "$validation" ]]; then
	validation="block"
fi

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
report="$run_dir/$timestamp.md"
if [[ -e "$report" ]]; then
	report="$run_dir/$timestamp-experiment-harness.md"
fi

{
	printf '# Experiment Harness Run %s\n\n' "$timestamp"
	printf '%s\n' "- Artifact: ${artifact_abs#$repo_root/}"
	printf '%s\n' "- Fixture inputs: $fixture_count"
	printf '%s\n' "- Example prompts: $prompt_count"
	printf '%s\n' "- Example outputs: $output_count"
	printf '%s\n\n' "- Validation: $validation"
	printf '## Validation Output\n\n'
	printf '```text\n%s\n```\n' "$validation_output"
} > "$report"

printf 'REPORT=%s\n' "${report#$repo_root/}"
printf 'VALIDATION=%s\n' "$validation"

if [[ "${EXPERIMENT_OBSERVE:-1}" != "0" ]]; then
	observer_script="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/observe-harness.sh"
	"$observer_script" "$artifact_abs" "$report" || true
fi
