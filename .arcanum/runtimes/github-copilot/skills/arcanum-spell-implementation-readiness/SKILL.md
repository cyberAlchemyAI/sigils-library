---
name: arcanum-spell-implementation-readiness
description: Run the installed Arcanum spell implementation-readiness from its embedded canonical definition snapshot.
argument-hint: "<request-for-implementation-readiness>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: implementation readiness

<objective>
Run the installed Arcanum spell implementation-readiness using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/implementation-readiness.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/implementation-readiness.md

````markdown
# Implementation Readiness

## Identity

- Canonical ID: `implementation-readiness`
- Aliases: none
- Scope: library

Implementation Readiness composes `implementation-layering`, `decision-gate`, and `task-session` so a rough implementation goal becomes staged, decided, and ready for one bounded execution loop.

## Trigger Conditions

- The user has a feature, workflow, infrastructure change, or improvement idea.
- The work needs staged implementation before execution.
- Blocker decisions should be resolved before mutation.

## Required Sigils

| Sigil | Role In Spell | Required Mode |
| ----- | ------------- | ------------- |
| `implementation-layering` | Create staged implementation layers. | standard |
| `decision-gate` | Resolve blocker-level decisions revealed by the layers. | generic |
| `task-session` | Prepare or execute one selected task. | dry-run or execute |

## Shared State

| State | Owner | Updated By | Consumed By |
| ----- | ----- | ---------- | ----------- |
| layer plan | spell | `implementation-layering` | `decision-gate`, `task-session` |
| decision record | spell | `decision-gate` | `task-session` |
| task run report | spell | `task-session` | user, observability |

## Execution Phases

| Phase | Sigil | Input | Output | Gate | Failure Policy |
| ----- | ----- | ----- | ------ | ---- | -------------- |
| 1 | `implementation-layering` | implementation goal | layer plan | minimum useful proof identified | block if scope is unclear |
| 2 | `decision-gate` | layer plan | decision record | blocker decisions resolved | block on unresolved blockers |
| 3 | `task-session` | selected layer or task | task report | done criteria and validation path known | flag if execution should wait |
| 4 | optional `inventory` | layer plan and decisions | inventory entries | inventory exists | skip if no inventory package |

## Observability

Record layer count, decision count, blockers, selected task, validation readiness, and follow-up items when `.arcanum/observability/` exists.

## Output Contract

Return a readiness report with layer plan path or summary, resolved decisions, task-session result, blockers, and recommended next action.
````
