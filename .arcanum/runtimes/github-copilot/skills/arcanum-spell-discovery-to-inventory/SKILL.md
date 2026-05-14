---
name: arcanum-spell-discovery-to-inventory
description: Run the installed Arcanum spell discovery-to-inventory from its embedded canonical definition snapshot.
argument-hint: "<request-for-discovery-to-inventory>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: discovery to inventory

<objective>
Run the installed Arcanum spell discovery-to-inventory using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/discovery-to-inventory.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/discovery-to-inventory.md

````markdown
# Discovery To Inventory

## Identity

- Canonical ID: `discovery-to-inventory`
- Aliases: none
- Scope: library

Discovery To Inventory composes `scope-interview`, `feature-glossary`, and `inventory` so early discovery becomes persistent reusable knowledge.

## Trigger Conditions

- A user has a vague idea, brownfield project, or unclear project scope.
- Discovery findings should not disappear into chat history.
- Vocabulary and decisions should become reusable inventory entries.

## Required Sigils

| Sigil | Role In Spell | Required Mode |
| ----- | ------------- | ------------- |
| `scope-interview` | Build the discovery baseline. | greenfield, brownfield, or auto |
| `feature-glossary` | Clarify local vocabulary. | create or update |
| `inventory` | Install or update reusable knowledge entries. | install, ingest, backfill |

## Execution Phases

| Phase | Sigil | Input | Output | Gate | Failure Policy |
| ----- | ----- | ----- | ------ | ---- | -------------- |
| 1 | `scope-interview` | project idea or repository | discovery baseline | observed, stated, and hypothesized content separated | block on unresolved scope gate |
| 2 | `feature-glossary` | discovery baseline and source docs | glossary | terms link to evidence | flag unresolved vocabulary |
| 3 | `inventory` | baseline and glossary | inventory entries | index and log updated | flag missing source coverage |
| 4 | spell report | phase outputs | discovery-to-inventory report | blockers named | report partial when discovery remains open |

## Observability

Record questions asked, decisions captured, glossary terms, entries created, unresolved scope gaps, and next discovery actions.

## Output Contract

Return a report with discovery verdict, glossary coverage, inventory updates, blockers, and recommended next discovery or planning step.
````
