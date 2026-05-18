# Regime: LIVE-DESIGN-001

## Goal

Validate that live Codex execution can run `invoke design` from approved source contracts and produce a governed six-view design artifact.

## Prompt

- Prompt: `example-prompts/invoke-design-live-pass.md`

## Required Output Patterns

- `## Invoke Result`
- `Mode:.*design`
- `Phase status:.*pass`
- `Source Contracts|source contracts`
- `Context View|context view|View 1`
- `High-Level Structure View|high-level structure|View 2`
- `Low-Level Components View|low-level components|View 3`
- `Workflow Process View|workflow process|View 4`
- `Decision Flow View|decision flow|View 5`
- `Dependency Interface View|dependency interface|View 6`
- `Risks|risks`
- `Glossary consistency|glossary consistency`
- `Design transport|design transport|Transport report|transport report`

## Quality Bar

- Output must include source contracts, six design views, risks, dependency/interface notes, glossary consistency, design transport, and next route evidence.

## Anti-Patterns

- Avoid treating missing source contracts as approved.
- Avoid creating implementation tasks in design mode.
- Avoid mutating downstream spell or sigil contracts.

## Observability

- Attempt telemetry must record design validation gaps and anti-pattern hits.

## Lessons To Capture

- Missing design views.
- Source-contract drift.
- Deferred plan/full behavior leaking into design.
