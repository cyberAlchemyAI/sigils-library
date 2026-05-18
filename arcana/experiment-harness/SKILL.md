---
name: experiment-harness
description: "Use when initializing, running, validating, reporting, or observing repeatable development experiments for Arcanum spells and sigils, especially through Codex CLI."
argument-hint: "<init|next|run|validate|report|observe> <artifact-path> [example-id|report-path|--type spell|sigil|--all]"
tier: arcana
domain: spell-sigil-validation
version: 0.1.0
origin: created to make every spell and sigil development harness executable and portable across repositories
allowed-tools: Read, Write, Glob, Grep, Bash
---

# Sigil: Experiment Harness

<objective>
Create and operate a repeatable experiment harness for reusable spells and sigils so development evidence comes from realistic prompts, real runtime outputs, validation checks, and timestamped reports.
</objective>

<logic-type>
Arcana: lifecycle evidence orchestration for spell and sigil development.
</logic-type>

<applicability>
Use this sigil for:

- initializing a development harness for a spell or sigil,
- selecting the next missing example prompt,
- running one bounded Codex CLI example,
- validating fixtures, expected outputs, live outputs, and reports,
- writing a run report,
- emitting signal-observer-compatible telemetry from a run report,
- making the same harness pattern usable in external repositories.
</applicability>

<inputs>
Expected inputs:

- mode: `init`, `next`, `run`, `validate`, `report`, or `observe`,
- artifact path,
- artifact type for init: `spell` or `sigil`,
- optional example ID or `--all`,
- optional `RERUN=1` when overwriting existing example outputs is intentional,
- optional `CODEX_BIN` when Codex CLI is not on `PATH`.
</inputs>

<process>
1. Resolve the artifact path and confirm the artifact exists or can be initialized.
2. For `init`, create `development/` directories and starter validation files without overwriting existing files.
3. For `next`, select the first prompt in `development/example-prompts/` without a matching `development/example-outputs/<task-id>.output.md`.
4. For `run`, execute exactly one selected prompt through Codex CLI unless `--all` is explicitly provided.
5. Save Codex's final user-facing message to `development/example-outputs/<task-id>.output.md` and raw logs to `development/example-runs/`.
6. Reject empty outputs and self-referential save summaries such as `Saved the output to ...`.
7. For `validate`, check required harness files, fixture pairs, example outputs, and latest report shape.
8. For `report`, write a timestamped report under `development/runs/`.
9. For `observe`, or after `report` when observability exists, append one JSONL signal under `.arcanum/observability/` and update reflection counters.
10. Return the selected artifact, command mode, files touched, validation state, telemetry state, and next missing example.
</process>

<observability-loop>
The experiment harness closes the lifecycle loop by integrating with `signal-observer` and the framework observability package:

- reports become safe invocation envelopes,
- envelopes are appended to `.arcanum/observability/signals/sigil-invocations.jsonl`,
- observer hook activity is recorded under `.arcanum/observability/hooks/`,
- per-sigil telemetry is mirrored to `.arcanum/observability/by-sigil/experiment-harness.jsonl`,
- reflection counters are updated in `.arcanum/observability/reflection-state.json`,
- dedupe prevents repeated observer emissions for the same report and observer version,
- telemetry write failures never block the primary validation result.
</observability-loop>

<artifact-boundary>
This sigil owns testing mechanics only. Artifact-specific meaning stays with the target spell or sigil. If the output contract is wrong, route that change through `spellcraft` or `sigil-development`.
</artifact-boundary>

<codex-cli-contract>
Codex example execution uses this command shape:

```bash
codex exec \
  -C <repository-root> \
  --sandbox workspace-write \
  --output-last-message <artifact-folder>/development/example-outputs/<task-id>.output.md \
  "$(cat <artifact-folder>/development/example-prompts/<task-id>.md)"
```

Use `CODEX_BIN` when provided. Otherwise discover `codex` from `PATH` or known local extension paths.
</codex-cli-contract>

<quality-bar>
A successful execution must:

- create the standard harness layout for new reusable spells and sigils,
- preserve existing harness files unless overwrite is explicit,
- select exactly one prompt for normal runs,
- require explicit `--all` for batch model calls,
- save the real artifact response rather than a save-summary,
- write raw run logs and timestamped reports,
- emit one observer-compatible telemetry event when repository observability is available,
- report `pass`, `flag`, or `block` honestly,
- remain usable from external repositories through runtime command adapters.
</quality-bar>

<anti-patterns>
Avoid:

- treating a well-written contract as validation evidence without examples,
- silently running every prompt,
- overwriting outputs without `RERUN=1`,
- making artifact-local wrappers authoritative over the canonical sigil,
- validating only markdown presence while ignoring output shape,
- embedding invoke-specific assumptions in the generic harness.
</anti-patterns>

<output-contract>
Return:

```markdown
## Experiment Harness Result

- Mode: init | next | run | validate | report | observe
- Artifact: <path>
- Artifact type: spell | sigil | unknown
- Selection: <task-id | none | not applicable>
- Output: <path | none | not applicable>
- Report: <path | none | not applicable>
- Validation: pass | flag | block | not run
- Observation: recorded | skipped | failed
- Next unrun: <task-id | none | unknown>
```
</output-contract>
