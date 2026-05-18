# Experiment Harness

Experiment Harness is an Arcana sigil for giving reusable spells and sigils a repeatable development test loop.

It creates an artifact-local `development/` harness, selects realistic prompts, runs bounded Codex CLI examples, saves the real user-facing output, validates expected structure, and records timestamped reports.

## Use When

- a new spell or sigil needs promotion evidence,
- a reusable artifact needs low, medium, and complex examples,
- a maintainer wants to run the next missing example output,
- Codex CLI output should be captured as real validation evidence,
- an external repository wants the same testing pattern as Arcanum.

## Do Not Use When

- the task is to design the artifact contract itself,
- the artifact has no reusable behavior to validate,
- the user only wants a one-off manual review,
- live model execution would be unsafe or too expensive without explicit approval.

## Commands

```bash
arcanum/arcana/experiment-harness/scripts/init-harness.sh <artifact-path> --type spell|sigil
arcanum/arcana/experiment-harness/scripts/select-prompt.sh <artifact-path> next
arcanum/arcana/experiment-harness/scripts/run-with-codex.sh <artifact-path> <example-id|next|--all>
arcanum/arcana/experiment-harness/scripts/validate-harness.sh <artifact-path>
arcanum/arcana/experiment-harness/scripts/report-harness.sh <artifact-path>
arcanum/arcana/experiment-harness/scripts/observe-harness.sh <artifact-path> [report-path]
```

Codex command adapters expose the same workflow through:

- `arcanum-sigil-experiment-harness`
- `experiment-next`
- `experiment-run`
- `experiment-validate`
- `experiment-observe`

## Closed Loop

The harness closes the development cycle with observability:

1. `run-with-codex.sh` captures real runtime output.
2. `validate-harness.sh` checks fixtures and output shape.
3. `report-harness.sh` writes a timestamped report.
4. `observe-harness.sh` appends one signal-observer-compatible event to `.arcanum/observability/signals/sigil-invocations.jsonl` when the repository observability package exists.
5. Observer hook activity is recorded in `.arcanum/observability/hooks/hook-operations.jsonl`.
6. Reflection counters are updated for later `sigil-development` or `workflow-reflect` review.

Set `EXPERIMENT_OBSERVE=0` when a report should not emit telemetry.

## Artifact Layout

```text
<artifact-folder>/
  development/
    VALIDATION-EXPERIMENT.md
    VALIDATION.md
    TASK-MATRIX.md
    fixtures/
    example-prompts/
    example-outputs/
    example-runs/
    runs/
    .gitignore
    run-validation-fixtures.sh
    run-example-with-codex.sh
    select-example-prompt.sh
    write-experiment-report.sh
    observe-experiment-report.sh
```

## Why This Is Arcana

The sigil coordinates lifecycle evidence across artifacts and runtimes. It does not decide what a spell or sigil should mean; it makes the development feedback loop executable and portable.
