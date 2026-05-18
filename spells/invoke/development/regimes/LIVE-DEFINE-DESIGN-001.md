# Regime: LIVE-DEFINE-DESIGN-001

## Goal

Validate that live Codex execution can produce an inspectable define-to-design chain where design consumes define outputs without inventing upstream authority.

## Prompt

- Prompt: `example-prompts/invoke-define-design-live-pass.md`

## Required Output Patterns

- `## Invoke Result`
- `Mode:.*define`
- `Mode:.*design`
- `Phase status:.*pass`
- `Spec|spec`
- `Glossary|glossary`
- `Define transport|define transport`
- `Source Contracts|source contracts|source contract`
- `Context View|context view|View 1`
- `High-Level Structure View|high-level structure|View 2`
- `Low-Level Components View|low-level components|View 3`
- `Workflow Process View|workflow process|View 4`
- `Decision Flow View|decision flow|View 5`
- `Dependency Interface View|dependency interface|View 6`
- `Glossary consistency|glossary consistency`
- `Design transport|design transport`
- `consumes define|consume define|from the define output|approved define`

## Quality Bar

- Output must include define evidence, design evidence, and a clear handoff relationship.
- Design authority must come from define evidence.

## Anti-Patterns

- Avoid invented approvals.
- Avoid collapsing the chain into a one-line summary.
- Avoid routing directly to implementation without plan.

## Observability

- Attempt telemetry must preserve workflow gaps across both phases.

## Lessons To Capture

- Handoff drift.
- Glossary inconsistency.
- Missing authority boundaries.
