---
name: arcanum-spell-sigil-maintenance-loop
description: Run the installed Arcanum spell sigil-maintenance-loop from its embedded canonical definition snapshot.
argument-hint: "<request-for-sigil-maintenance-loop>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: sigil maintenance loop

<objective>
Run the installed Arcanum spell sigil-maintenance-loop using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/sigil-maintenance-loop.md.
</context>

<process>
1. Use the embedded canonical definition snapshot below as the execution contract.
2. For sigils, use both the README and SKILL snapshots when present. For spells, follow the spell snapshot directly.
3. Execute only this installed spell unless the definition explicitly delegates or the user asks to route elsewhere.
4. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
5. Apply the observability handoff by summarizing request, artifact, outputs, files changed, validation, gaps, and follow-up; append telemetry under .arcanum/observability/ when allowed.
6. Return the artifact used, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Do not require or create .arcanum/necronomicon/ runtime registry files.
- Necronomicon means the Ontology Harness alias.
- Treat the embedded canonical snapshot as the local command contract.
</guardrails>

## Canonical Spell Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/sigil-maintenance-loop.md

````markdown
# Sigil Maintenance Loop

## Identity

- Canonical ID: `sigil-maintenance-loop`
- Aliases: none
- Scope: library

Sigil Maintenance Loop composes `signal-observer`, `workflow-reflect`, and `sigil-development` so reusable sigils improve from usage evidence.

## Trigger Conditions

- A sigil has meaningful execution history.
- Telemetry shows repeated gaps, output drift, user corrections, or quality failures.
- The user asks to tune, reflect on, or improve a sigil.

## Required Sigils

| Sigil | Role In Spell | Required Mode |
| ----- | ------------- | ------------- |
| `signal-observer` | Record post-run behavior signals. | observe |
| `workflow-reflect` | Analyze accumulated signals and propose changes. | reflect |
| `sigil-development` | Apply approved targeted updates. | update or reflect |

## Execution Phases

| Phase | Sigil | Input | Output | Gate | Failure Policy |
| ----- | ----- | ----- | ------ | ---- | -------------- |
| 1 | `signal-observer` | latest invocation envelope | telemetry row | evidence is sufficient | skip when no meaningful run exists |
| 2 | `workflow-reflect` | telemetry ledger | reflection report | threshold or manual trigger met | stop if insufficient signal |
| 3 | `sigil-development` | reflection report | updated sigil or no-change decision | user approves change scope | block on contract-breaking changes |
| 4 | spell report | phase outputs | maintenance report | validation performed | flag remaining gaps |

## Observability

Record signal counts, thresholds, proposed changes, accepted changes, rejected changes, validation status, and next reflection trigger.

## Output Contract

Return a maintenance report with observed sigil, reflection trigger, proposal summary, files changed if any, validation, and next lifecycle step.
````
