# Invoke

## Identity

- Canonical ID: `invoke`
- Aliases: none
- Scope: library

## Purpose

Invoke turns vague development intent into governed authoring artifacts. The root spell file stays intentionally compact and delegates mode behavior to per-mode contracts under `spells/invoke/`.

## Trigger Conditions

- The user has something to build but the authoring baseline is missing or inconsistent.
- A reusable spec and glossary are needed before architecture or execution planning.
- The workflow needs one-question clarification, explicit approvals, and auditable outputs.

## Mode Contracts

| Mode       | Status           | Contract File                              | Notes                                                  |
| ---------- | ---------------- | ------------------------------------------ | ------------------------------------------------------ |
| `define`   | implemented (L0) | [define.md](./define.md)     | Active authoring baseline mode.                        |
| `design`   | deferred         | [design.md](./design.md)     | Activate at L1 after define promotion criteria pass.   |
| `plan`     | deferred         | [plan.md](./plan.md)         | Activate at L2 after design artifacts are stable.      |
| `full`     | deferred         | [full.md](./full.md)         | Composite execution mode, pending L2 and L3 readiness. |
| `validate` | deferred         | [validate.md](./validate.md) | Lifecycle validation mode, pending L3.                 |

## Core Required Sigils

| Sigil                       | Role In Spell                                                         | Required Mode  |
| --------------------------- | --------------------------------------------------------------------- | -------------- |
| `structured-interview-kits` | Clarify missing context one question at a time and capture approvals. | mode-dependent |
| `inventory`                 | Resolve local templates and record template usage evidence.           | mode-dependent |
| `context-builder`           | Build bounded context for invoke inputs and artifact linking.         | mode-dependent |

## Core Optional Sigils

| Sigil                            | Use When                                                             | Notes                                                                              |
| -------------------------------- | -------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `decision-gate`                  | A blocker-level decision cannot be resolved from available evidence. | Route only consequential unresolved choices.                                       |
| `spellcraft`                     | Approved invoke output targets spell authoring or spell revision.    | Invoke prepares handoff context; Spellcraft owns spell lifecycle execution.        |
| `sigil-development`              | Approved invoke output targets sigil authoring or sigil revision.    | Invoke prepares handoff context; Sigil Development owns sigil lifecycle execution. |
| `architecture-pattern-inventory` | Design-stage work is active.                                         | Deferred until design mode is implemented.                                         |
| `task-session`                   | Plan or execution-stage work is active.                              | Deferred until plan/full modes are implemented.                                    |

## Prerequisites

- Repository root is known.
- Development pack context is available under `spells/invoke/development/`.
- Local template inventory is available, or candidate-template creation is allowed by user approval.
- Necronomicon concept sources are reachable when glossary linking is requested.

## Shared State

| State                       | Owner | Updated By                                      | Consumed By                           |
| --------------------------- | ----- | ----------------------------------------------- | ------------------------------------- |
| define intent record        | spell | `structured-interview-kits` and `invoke define` | define synthesis, decision routing    |
| template selection record   | spell | `inventory` and `invoke define`                 | define synthesis, validation, handoff |
| spec artifact               | spell | `invoke define`                                 | downstream design or plan routing     |
| glossary artifact           | spell | `invoke define`                                 | downstream design or plan routing     |
| define transport report     | spell | `invoke define`                                 | Necronomicon session context          |
| unresolved gap ledger entry | spell | `invoke define` and optional `decision-gate`    | follow-up routing                     |

## Mode Router

1. Resolve requested mode and load the corresponding mode contract.
2. Execute the mode contract phases and collect mode outputs.
3. Apply global gates, observability, and handoff policy from this root contract.

## Global Handoff Artifacts

- define context summary
- mode artifact paths
- mode selection evidence
- unresolved gaps and blocker decisions
- Necronomicon transport report
- recommended next route (`spellcraft`, `sigil-development`, or deferred follow-up)

## Global Gates

- One-question interview cadence when context is missing in interactive mode.
- Template or recipe selection must show eligibility evidence and explicit user choice on ties.
- Candidate glossary or registry promotion is never automatic.
- No silent upstream mutation; direct upstream edits require explicit approval.
- Stage transport appends stage reports and complements matching Necronomicon sections only when they already exist.

## Global Failure Policy

- Return `block` when blocker ambiguity, missing mandatory inputs, or governance violations prevent safe mode output.
- Return `flag` when mode output is usable but includes unresolved non-blocker gaps.
- Stop at the first blocked gate and return remediation guidance rather than silently switching modes.

## Local Customization

- Spell root: `.arcanum/spells/` for local adaptations, `spells/` for this reusable library spell.
- Local paths: output paths come from selected templates and local project conventions.
- Gate strictness: standard for authoring modes; blocker decisions remain strict.
- Interaction mode: interactive one-question clarification by default.

## Observability

When `.arcanum/observability/` exists, record:

- spell name and mode,
- phases attempted,
- sigils invoked,
- gates passed, flagged, or blocked,
- artifact paths produced,
- unresolved gaps and blocker decisions,
- handoff target recommendation,
- referenced mode contract,
- validation and follow-up action.

## Root Output Contract

Return:

```markdown
## Invoke Result

- Mode: <define | design | plan | full | validate>
- Spell: invoke
- Canonical ID: invoke
- Scope: library
- Phase status: pass | flag | block
- Mode contract: <path>
- Outputs: <mode output paths>
- Template or recipe selection: <summary>
- Decisions: <summary>
- Unresolved gaps: <summary>
- Next route: spellcraft | sigil-development | deferred
```

Mode-specific execution phases and mode-level output contracts are defined in [define.md](./define.md), [design.md](./design.md), [plan.md](./plan.md), [full.md](./full.md), and [validate.md](./validate.md).
