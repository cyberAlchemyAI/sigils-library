#!/usr/bin/env bash
set -euo pipefail

usage() {
	cat <<'USAGE'
Usage:
  validate-harness.sh <artifact-path>
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
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
contract_checker="$script_dir/check-contract-output.sh"
status="pass"
overall_quality_bar_status="not_checked"
overall_anti_pattern_hits_json='[]'
overall_workflow_gaps_json='[]'

merge_json_arrays() {
	local left="$1"
	local right="$2"
	jq -cn --argjson left "$left" --argjson right "$right" '$left + $right'
}

merge_quality_status() {
	local current="$1"
	local next="$2"
	case "$current:$next" in
		*fail*|fail:*) printf 'fail\n' ;;
		*partial*|partial:*) printf 'partial\n' ;;
		pass:*|*:pass) printf 'pass\n' ;;
		*) printf 'not_checked\n' ;;
	esac
}

flag() {
	if [[ "$status" != "block" ]]; then
		status="flag"
	fi
	printf 'FLAG: %s\n' "$1"
}

block() {
	status="block"
	printf 'BLOCK: %s\n' "$1"
}

require_file() {
	if [[ ! -f "$1" ]]; then
		block "missing required file: ${1#$artifact_abs/}"
	fi
}

require_dir() {
	if [[ ! -d "$1" ]]; then
		block "missing required directory: ${1#$artifact_abs/}"
	fi
}

require_dir "$dev_dir"
require_file "$dev_dir/VALIDATION-EXPERIMENT.md"
require_file "$dev_dir/VALIDATION.md"
require_dir "$dev_dir/fixtures"
require_dir "$dev_dir/runs"

for optional_dir in example-prompts example-outputs example-runs; do
	if [[ ! -d "$dev_dir/$optional_dir" ]]; then
		flag "missing optional runtime evidence directory: development/$optional_dir"
	fi
done

if [[ -d "$dev_dir/fixtures" ]]; then
	fixture_count="$(find "$dev_dir/fixtures" -maxdepth 1 -type f -name '*.md' ! -name '*.expected.md' | wc -l | tr -d ' ')"
	expected_count="$(find "$dev_dir/fixtures" -maxdepth 1 -type f -name '*.expected.md' | wc -l | tr -d ' ')"
	if [[ "$fixture_count" -eq 0 ]]; then
		flag "no fixture inputs found"
	fi
	if [[ "$expected_count" -eq 0 ]]; then
		flag "no expected fixture outputs found"
	fi
	while IFS= read -r fixture; do
		name="$(basename "$fixture" .md)"
		if [[ "$name" == *.* ]]; then
			continue
		fi
		base="${fixture%.md}"
		if [[ ! -f "$base.expected.md" ]] && ! compgen -G "$base.*.expected.md" >/dev/null; then
			flag "fixture missing expected pair: ${fixture#$artifact_abs/}"
		fi
	done < <(find "$dev_dir/fixtures" -maxdepth 1 -type f -name '*.md' ! -name '*.expected.md' | sort)
fi

if [[ -d "$dev_dir/example-outputs" ]]; then
	while IFS= read -r output; do
		if [[ ! -s "$output" ]]; then
			block "example output is empty: ${output#$artifact_abs/}"
			continue
		fi
		if rg -q -- '^Saved the .*output to |^Saved .* to \[' "$output"; then
			block "example output is a save-summary, not a real artifact body: ${output#$artifact_abs/}"
		fi
		if ! rg -q -- '^## .+Result|^# .+Result|^## Gate Result|^## Spell Result|^## Sigil .*Result' "$output"; then
			flag "example output has no recognizable result heading: ${output#$artifact_abs/}"
		fi
		if [[ -x "$contract_checker" ]]; then
			contract_result="$("$contract_checker" "$artifact_abs" "$output" || true)"
			printf '%s\n' "$contract_result"
			contract_validation="$(printf '%s\n' "$contract_result" | sed -n 's/^VALIDATION=//p' | tail -n 1)"
			contract_quality="$(printf '%s\n' "$contract_result" | sed -n 's/^QUALITY_BAR_STATUS=//p' | tail -n 1)"
			contract_anti_hits="$(printf '%s\n' "$contract_result" | sed -n 's/^ANTI_PATTERN_HITS_JSON=//p' | tail -n 1)"
			contract_gaps="$(printf '%s\n' "$contract_result" | sed -n 's/^WORKFLOW_GAPS_JSON=//p' | tail -n 1)"
			if [[ -n "$contract_quality" ]]; then
				overall_quality_bar_status="$(merge_quality_status "$overall_quality_bar_status" "$contract_quality")"
			fi
			if [[ -n "$contract_anti_hits" ]] && printf '%s\n' "$contract_anti_hits" | jq -e . >/dev/null 2>&1; then
				overall_anti_pattern_hits_json="$(merge_json_arrays "$overall_anti_pattern_hits_json" "$contract_anti_hits")"
			fi
			if [[ -n "$contract_gaps" ]] && printf '%s\n' "$contract_gaps" | jq -e . >/dev/null 2>&1; then
				overall_workflow_gaps_json="$(merge_json_arrays "$overall_workflow_gaps_json" "$contract_gaps")"
			fi
			case "$contract_validation" in
				block) block "contract output check blocked: ${output#$artifact_abs/}" ;;
				flag) flag "contract output check flagged: ${output#$artifact_abs/}" ;;
			esac
		fi
	done < <(find "$dev_dir/example-outputs" -maxdepth 1 -type f -name '*.output.md' | sort)
fi

if [[ -d "$dev_dir/live-evidence" ]]; then
	while IFS= read -r output; do
		if [[ ! -s "$output" ]]; then
			block "live evidence output is empty: ${output#$artifact_abs/}"
			continue
		fi
		if [[ -x "$contract_checker" ]]; then
			contract_result="$("$contract_checker" "$artifact_abs" "$output" || true)"
			printf '%s\n' "$contract_result"
			contract_validation="$(printf '%s\n' "$contract_result" | sed -n 's/^VALIDATION=//p' | tail -n 1)"
			contract_quality="$(printf '%s\n' "$contract_result" | sed -n 's/^QUALITY_BAR_STATUS=//p' | tail -n 1)"
			contract_anti_hits="$(printf '%s\n' "$contract_result" | sed -n 's/^ANTI_PATTERN_HITS_JSON=//p' | tail -n 1)"
			contract_gaps="$(printf '%s\n' "$contract_result" | sed -n 's/^WORKFLOW_GAPS_JSON=//p' | tail -n 1)"
			if [[ -n "$contract_quality" ]]; then
				overall_quality_bar_status="$(merge_quality_status "$overall_quality_bar_status" "$contract_quality")"
			fi
			if [[ -n "$contract_anti_hits" ]] && printf '%s\n' "$contract_anti_hits" | jq -e . >/dev/null 2>&1; then
				overall_anti_pattern_hits_json="$(merge_json_arrays "$overall_anti_pattern_hits_json" "$contract_anti_hits")"
			fi
			if [[ -n "$contract_gaps" ]] && printf '%s\n' "$contract_gaps" | jq -e . >/dev/null 2>&1; then
				overall_workflow_gaps_json="$(merge_json_arrays "$overall_workflow_gaps_json" "$contract_gaps")"
			fi
			case "$contract_validation" in
				block) block "live evidence contract check blocked: ${output#$artifact_abs/}" ;;
				flag) flag "live evidence contract check flagged: ${output#$artifact_abs/}" ;;
			esac
		fi
	done < <(find "$dev_dir/live-evidence" -type f -name 'output.md' | sort)
fi

latest_report="$(find "$dev_dir/runs" -maxdepth 1 -type f -name '*.md' 2>/dev/null | sort | tail -n 1 || true)"
if [[ -z "$latest_report" ]]; then
	if ! find "$dev_dir/live-evidence" -type f -name 'loop-report.md' 2>/dev/null | read -r _; then
		flag "no timestamped validation report found under development/runs"
	fi
else
	if ! rg -q -- 'Validation: pass|Validation: flag|Validation: block|Status: pass|Status: flag|Status: block' "$latest_report"; then
		flag "latest report does not expose a validation status: ${latest_report#$artifact_abs/}"
	fi
fi

printf 'VALIDATION=%s\n' "$status"
printf 'QUALITY_BAR_STATUS=%s\n' "$overall_quality_bar_status"
printf 'ANTI_PATTERN_HITS_JSON=%s\n' "$overall_anti_pattern_hits_json"
printf 'WORKFLOW_GAPS_JSON=%s\n' "$overall_workflow_gaps_json"

if [[ "$status" == "block" ]]; then
	exit 1
fi

exit 0
