#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
	cat <<'USAGE'
Usage:
  init-harness.sh <artifact-path> --type spell|sigil
USAGE
}

if [[ "$#" -ne 3 || "$2" != "--type" ]]; then
	usage >&2
	exit 2
fi

artifact="$1"
artifact_type="$3"

case "$artifact_type" in
	spell|sigil) ;;
	*)
		printf 'ERROR: artifact type must be spell or sigil\n' >&2
		exit 2
		;;
esac

mkdir -p "$artifact"
artifact_abs="$(cd "$artifact" && pwd)"
dev_dir="$artifact_abs/development"
repo_root="${EXPERIMENT_REPO_ROOT:-$(git -C "$PWD" rev-parse --show-toplevel 2>/dev/null || pwd)}"

mkdir -p \
	"$dev_dir/fixtures" \
	"$dev_dir/example-prompts" \
	"$dev_dir/example-outputs" \
	"$dev_dir/example-runs" \
	"$dev_dir/runs"

write_if_missing() {
	local path="$1"
	shift
	if [[ -e "$path" ]]; then
		printf 'KEEP: %s\n' "${path#$repo_root/}"
		return 0
	fi
	printf '%s\n' "$@" > "$path"
	printf 'CREATE: %s\n' "${path#$repo_root/}"
}

write_if_missing "$dev_dir/VALIDATION-EXPERIMENT.md" \
	"# Validation Experiment" \
	"" \
	"- Artifact: ${artifact_abs#$repo_root/}" \
	"- Artifact type: $artifact_type" \
	"- Runtime: Codex CLI" \
	"- Harness owner: experiment-harness" \
	"" \
	"## Goal" \
	"" \
	"Validate that this $artifact_type works against realistic low, medium, and complex tasks and produces user-facing outputs that satisfy its contract." \
	"" \
	"## Evidence Required" \
	"" \
	"- Fixture inputs and expected outputs." \
	"- Real example prompts." \
	"- Real Codex CLI example outputs when runtime execution is enabled." \
	"- Timestamped validation reports under \`development/runs/\`." \
	"" \
	"## Promotion Gate" \
	"" \
	"This artifact is not promotion-ready until validation passes, expected outputs are inspectable, and at least one real runtime output exists when a runtime adapter is available."

write_if_missing "$dev_dir/VALIDATION.md" \
	"# Validation" \
	"" \
	"- Latest report: pending" \
	"- Status: flag" \
	"- Reason: harness initialized, but fixtures and example outputs still need to be added." \
	"" \
	"## Checks" \
	"" \
	"- Harness layout exists." \
	"- Fixture pairs exist." \
	"- Example prompts cover low, medium, and complex cases when applicable." \
	"- Real outputs are not save summaries." \
	"- Latest run report is linked after validation."

write_if_missing "$dev_dir/TASK-MATRIX.md" \
	"# Task Matrix" \
	"" \
	"| ID | Complexity | Scenario | Expected Output | Status |" \
	"| --- | --- | --- | --- | --- |" \
	"| ${artifact_type}-low | low | Small focused request. | Contract-shaped result. | pending |" \
	"| ${artifact_type}-medium | medium | Multi-part realistic request. | Contract-shaped result with gates. | pending |" \
	"| ${artifact_type}-complex | complex | Cross-boundary or lifecycle request. | Contract-shaped result with risks and next steps. | pending |"

write_if_missing "$dev_dir/.gitignore" \
	"# Generated experiment evidence." \
	"example-outputs/*" \
	"example-runs/*" \
	"runs/*" \
	"" \
	"# Keep evidence directories present." \
	"!example-outputs/.gitkeep" \
	"!example-runs/.gitkeep" \
	"!runs/.gitkeep"

write_if_missing "$dev_dir/example-outputs/.gitkeep" ""
write_if_missing "$dev_dir/example-runs/.gitkeep" ""
write_if_missing "$dev_dir/runs/.gitkeep" ""

write_if_missing "$dev_dir/fixtures/${artifact_type}-low.md" \
	"# Fixture: ${artifact_type}-low" \
	"" \
	"## Request" \
	"" \
	"Create a small, realistic $artifact_type example." \
	"" \
	"## Inputs" \
	"" \
	"- Replace this fixture with artifact-specific inputs before promotion."

write_if_missing "$dev_dir/fixtures/${artifact_type}-low.expected.md" \
	"# Expected Output: ${artifact_type}-low" \
	"" \
	"## Result" \
	"" \
	"- Status: flag" \
	"- Reason: starter expected output must be replaced with artifact-specific contract evidence."

write_if_missing "$dev_dir/example-prompts/${artifact_type}-low.md" \
	"# Experiment Prompt: ${artifact_type}-low" \
	"" \
	"Run the target $artifact_type against this low-complexity validation request." \
	"" \
	"## Target Artifact" \
	"" \
	"${artifact_abs#$repo_root/}" \
	"" \
	"## User Request" \
	"" \
	"Create a small, realistic $artifact_type example and return the full user-facing result body. Do not summarize that you saved an output file." \
	"" \
	"## Required Capture" \
	"" \
	"Save only the final artifact result body to \`development/example-outputs/${artifact_type}-low.output.md\`."

write_if_missing "$dev_dir/select-example-prompt.sh" \
	"#!/usr/bin/env bash" \
	"set -euo pipefail" \
	"\"$SCRIPT_DIR/select-prompt.sh\" \"$artifact_abs\" \"\$@\""

write_if_missing "$dev_dir/run-example-with-codex.sh" \
	"#!/usr/bin/env bash" \
	"set -euo pipefail" \
	"\"$SCRIPT_DIR/run-with-codex.sh\" \"$artifact_abs\" \"\$@\""

write_if_missing "$dev_dir/run-validation-fixtures.sh" \
	"#!/usr/bin/env bash" \
	"set -euo pipefail" \
	"\"$SCRIPT_DIR/validate-harness.sh\" \"$artifact_abs\""

write_if_missing "$dev_dir/write-experiment-report.sh" \
	"#!/usr/bin/env bash" \
	"set -euo pipefail" \
	"\"$SCRIPT_DIR/report-harness.sh\" \"$artifact_abs\""

write_if_missing "$dev_dir/observe-experiment-report.sh" \
	"#!/usr/bin/env bash" \
	"set -euo pipefail" \
	"\"$SCRIPT_DIR/observe-harness.sh\" \"$artifact_abs\" \"\$@\""

chmod +x \
	"$dev_dir/select-example-prompt.sh" \
	"$dev_dir/run-example-with-codex.sh" \
	"$dev_dir/run-validation-fixtures.sh" \
	"$dev_dir/write-experiment-report.sh" \
	"$dev_dir/observe-experiment-report.sh"

printf 'HARNESS=%s\n' "${dev_dir#$repo_root/}"
printf 'TYPE=%s\n' "$artifact_type"
