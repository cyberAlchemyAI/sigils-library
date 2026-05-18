# Regime: LIVE-DEFINE-001

## Goal

Validate that live Codex execution can run `invoke define` and produce a real user-facing define artifact.

## Prompt

- Prompt: `example-prompts/invoke-define-live-pass.md`

## Required Output Patterns

- `## Invoke Result`
- `Mode:.*define`
- `Phase status:.*pass`
- `Spec|spec`
- `Glossary|glossary`
- `Define transport|define transport|Transport report|transport report`
- `Next route|next route`

## Quality Bar

- Output must include spec, glossary, decisions, unresolved gaps, define transport, and next route evidence.
- Output must be an artifact body, not a save-summary.

## Anti-Patterns

- Avoid treating vague input as complete without scope decisions.
- Avoid silently promoting new glossary terms.
- Avoid implementation planning in define mode.

## Observability

- Attempt telemetry must record Quality Bar status, Anti-Pattern hits, workflow gaps, and reflection trigger.

## Lessons To Capture

- Missing define sections.
- Prompt ambiguity that causes implementation behavior.
- Observer gaps.
