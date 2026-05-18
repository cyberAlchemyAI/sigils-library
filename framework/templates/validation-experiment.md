# {Artifact Name} Validation Experiment

This experiment follows the framework [Validation Experiment Protocol](../VALIDATION-EXPERIMENT-PROTOCOL.md) and [Experiment Harness Standard](../EXPERIMENT-HARNESS-STANDARD.md).

## Artifact

- Canonical ID: `{artifact-id}`
- Type: spell | sigil
- Source path: `{path}`
- Promotion target: candidate | local reusable | library reusable | registry release
- Current status: `{status}`

## Hypothesis

`{artifact-id}` can {core lifecycle behavior to prove}.

## Task Matrix

Use a task matrix when this artifact has multiple modes, templates, tiers, or complexity classes.

| Task ID | Mode Or Capability | Complexity | Realistic User Task | Expected Use |
| --- | --- | --- | --- | --- |
| {artifact-low} | {mode} | low | {realistic low-complexity request} | {expected behavior} |
| {artifact-medium} | {mode} | medium | {realistic medium-complexity request} | {expected behavior} |
| {artifact-complex} | {mode} | complex | {realistic complex request} | {expected behavior} |

## Fixtures

| Fixture ID | Scenario | Input Shape | Expected Result |
| --- | --- | --- | --- |
| {ARTIFACT-PASS-001} | Normal passing case. | {inputs} | `pass`; {output}. |
| {ARTIFACT-BLOCK-001} | Missing required input. | {missing inputs} | `block`; {remediation}. |
| {ARTIFACT-FLAG-001} | Usable with non-blocking gap. | {partial inputs} | `flag`; {gap}. |

## Execution Method

Run:

```bash
{artifact-folder}/development/run-validation-fixtures.sh
```

If a runtime adapter exists, run selected prompts through the bounded runtime runner and save outputs under:

```text
{artifact-folder}/development/example-outputs/
```

For Codex CLI:

```bash
{artifact-folder}/development/run-example-with-codex.sh <task-id>
{artifact-folder}/development/run-example-with-codex.sh next
RERUN=1 {artifact-folder}/development/run-example-with-codex.sh <task-id>
```

## Required Checks

| Check | Method | Pass Criteria |
| --- | --- | --- |
| Contract structure | Review source contract. | Required sections exist. |
| Link validation | Markdown link checker. | Links resolve. |
| Fixture replay | Local runner. | Fixtures pass or block as expected. |
| Real output shape | Local runner. | Outputs contain artifact body, not a save-summary. |
| Codex CLI output | Bounded `codex exec` runner, when available. | Saved output contains the artifact result body and runtime log is captured. |
| Integration handoff | Local runner, when applicable. | Downstream input consumes upstream output. |
| Observability | Contract review. | Reusable artifact defines signals or explains why not needed. |

## Promotion Gates

- Passing fixture passes.
- Missing-input fixture blocks for the expected reason.
- Flag fixture records a non-blocking gap honestly.
- Real output artifact is inspectable.
- Latest run report is linked from `VALIDATION.md`.
- Registry change is blocked until this experiment reaches `pass`.

## Current Verdict

`block`

Reason: experiment scaffold created; fixtures and runner not yet executed.
