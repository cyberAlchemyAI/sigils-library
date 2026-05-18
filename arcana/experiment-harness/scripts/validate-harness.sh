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
status="pass"

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
	done < <(find "$dev_dir/example-outputs" -maxdepth 1 -type f -name '*.output.md' | sort)
fi

latest_report="$(find "$dev_dir/runs" -maxdepth 1 -type f -name '*.md' 2>/dev/null | sort | tail -n 1 || true)"
if [[ -z "$latest_report" ]]; then
	flag "no timestamped validation report found under development/runs"
else
	if ! rg -q -- 'Validation: pass|Validation: flag|Validation: block|Status: pass|Status: flag|Status: block' "$latest_report"; then
		flag "latest report does not expose a validation status: ${latest_report#$artifact_abs/}"
	fi
fi

printf 'VALIDATION=%s\n' "$status"

if [[ "$status" == "block" ]]; then
	exit 1
fi

exit 0
