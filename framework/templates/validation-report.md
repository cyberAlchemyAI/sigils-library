# {Artifact Name} Validation Report

Validation protocol: `VALIDATION-EXPERIMENT.md`

## Run Summary

- Artifact: `{artifact-id}`
- Type: spell | sigil
- Validation date: `{date}`
- Promotion target: candidate | local reusable | library reusable | registry release
- Verdict: `pass | flag | block`
- Latest run report: `{runs/<timestamp>.md}`

## Checks Performed

| Check | Result | Evidence |
| --- | --- | --- |
| Contract structure | pass | {evidence} |
| Markdown links | pass | {evidence} |
| Fixture replay | pass | {evidence} |
| Real output shape | pass | {evidence} |
| Codex CLI output | pass | {evidence or n/a} |
| Integration handoff | n/a | {evidence} |
| Observability | pass | {evidence} |

## Fixture Status

| Fixture ID | Status | Notes |
| --- | --- | --- |
| {ARTIFACT-PASS-001} | pass | {notes} |
| {ARTIFACT-BLOCK-001} | pass | {notes} |
| {ARTIFACT-FLAG-001} | pass | {notes} |

## Decision

{promotion or block decision}

## Next Actions

1. {next action}
