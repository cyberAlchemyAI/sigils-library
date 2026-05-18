#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
INVOKE_DIR="$ROOT_DIR/arcanum/spells/invoke"
MATRIX="$INVOKE_DIR/development/TEMPLATE-VALIDATION-TASKS.md"
OUT_DIR="$INVOKE_DIR/development/example-prompts"

mkdir -p "$OUT_DIR"

count=0
in_matrix=0

while IFS= read -r line; do
	if [[ "$line" == '## Template Task Matrix' ]]; then
		in_matrix=1
		continue
	fi
	if [[ "$line" == '## Fixture Requirements' ]]; then
		in_matrix=0
	fi
	[[ "$in_matrix" -eq 1 ]] || continue
	[[ "$line" == \|* ]] || continue
	[[ "$line" == *'Task ID'* ]] && continue
	[[ "$line" == *'---'* ]] && continue

	IFS='|' read -r _ task_id template complexity user_task expected_use _ <<< "$line"
	task_id="$(printf '%s' "$task_id" | sed 's/^ *//; s/ *$//')"
	template="$(printf '%s' "$template" | sed 's/^ *//; s/ *$//')"
	complexity="$(printf '%s' "$complexity" | sed 's/^ *//; s/ *$//')"
	user_task="$(printf '%s' "$user_task" | sed 's/^ *//; s/ *$//')"
	expected_use="$(printf '%s' "$expected_use" | sed 's/^ *//; s/ *$//')"

	[[ -n "$task_id" ]] || continue

	cat > "$OUT_DIR/$task_id.md" <<PROMPT
# Invoke Example Prompt: $task_id

## Invocation

\`\`\`text
arcanum-spell-invoke $user_task
\`\`\`

## Codex Prompt

Use the Codex command adapter at \`.codex/commands/arcanum-spell-invoke.md\`.

Run \`invoke\` for this template validation example:

- Task ID: \`$task_id\`
- Template target: \`$template\`
- Complexity: \`$complexity\`
- User request: $user_task
- Expected invoke use: $expected_use

Return the standard \`Invoke Result\` shape from the canonical invoke contract. If the requested mode is deferred, return the deferred gate and expected next action instead of pretending execution is implemented.

Also include the primary user-facing artifact body for the selected template target after the \`Invoke Result\`. Do not collapse the artifact into one summary line.

Template artifact requirements:

- For \`architecture\`, include an \`## Architecture Plan\` artifact with source contracts, View 1 through View 6, dependency/interface rules, decision log, risks, downstream planning notes, design transport notes, and gate result.
- For \`research\`, include a research brief with claims, evidence, conflicts, gaps, and gate result.
- For \`spell\`, include spellcraft handoff context with phases, gates, handoff artifacts, observability, and next route.
- For \`sigil\`, include sigil-development handoff context with inputs, outputs, quality bar, anti-patterns, observability, and next route.
- For \`ux-plan\`, include UX plan artifact with actors, flows, states, content/accessibility notes, risks, and handoff notes.
- For \`implementation-plan\`, \`implementation-layering\`, and \`work-pack\`, include the relevant planning artifact body, or clearly block/flag if the current invoke mode is deferred.

Implementation-layering rule:

- In \`define\` and \`design\`, implementation layering may be seeded or recorded as a downstream gap.
- Missing implementation-layering decisions must not be treated as a design-mode blocker.
- Full implementation-layering artifacts are required only for \`plan\`, \`full\`, and \`validate\`.

Important capture rule:

- Do not edit or save files yourself.
- Return only the full markdown output that should be saved.
- The outer runner will save your final response to the output path.
- Do not respond with a summary like "Saved the output to ...".

## Expected Capture Path

The outer runner saves the final response as:

\`\`\`text
arcanum/spells/invoke/development/example-outputs/$task_id.output.md
\`\`\`
PROMPT

	count=$((count + 1))
done < "$MATRIX"

printf 'Generated %s prompt(s) in %s\n' "$count" "$OUT_DIR"
