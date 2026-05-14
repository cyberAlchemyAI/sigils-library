# Spell Registry

This registry lists reusable spell compositions offered by Arcanum.

Each spell references existing sigils and defines a workflow around them. Repository-local adaptations should live under `.arcanum/spells/` in the consuming repository.

## Spells

| Spell | Aliases | Purpose | Sigils Composed | Use When | File |
| ----- | ------- | ------- | --------------- | -------- | ---- |
| Arcanum Bootstrap | Arcanum Install; Sigil Forge Install | Install Arcanum into a consuming repository with all or selected sigils, selected spells, observability folders, and optional runtime adapters. | `sigil-runtime-installer`, `observability-setup` | A repository should receive Arcanum locally and optionally expose it through GitHub Copilot, Claude, or Codex. | [arcanum-bootstrap.md](../spells/arcanum-bootstrap.md) |
| Repository Harness | Repository Codex | Install a reusable repository knowledge and architecture harness, then verify task-context retrieval. | `inventory`, `architecture-pattern-inventory`, `context-builder` | A repository needs compiled knowledge, architecture mapping, and focused task context to work together. | [repository-harness.md](../spells/repository-harness.md) |
| Ontology Harness | Necronomicon; Necronomicon Vault; Ontology Codex | Turn vault-like sessions, discoveries, premises, conventions, and optional business-system branches into a traceable ontology governance layer. | `inventory`, `ontology-vault`, `context-builder` | A repository needs ontology mapping, session distillation, confidence promotion, premise review, convention-change gates, or intent-to-system bridge validation. | [ontology-harness.md](../spells/ontology-harness.md) |
| Implementation Readiness |  | Move from rough implementation intent to layered plan, resolved decisions, and a task execution loop. | `implementation-layering`, `decision-gate`, `task-session` | A feature or workflow needs staged implementation planning before execution. | [implementation-readiness.md](../spells/implementation-readiness.md) |
| Discovery To Inventory |  | Turn vague or brownfield scope into discovery baseline, glossary, and reusable inventory entries. | `scope-interview`, `feature-glossary`, `inventory` | Early discovery should become persistent reusable knowledge rather than a one-off conversation. | [discovery-to-inventory.md](../spells/discovery-to-inventory.md) |
| Sigil Maintenance Loop |  | Observe sigil executions, reflect on accumulated signals, and route targeted sigil updates. | `signal-observer`, `workflow-reflect`, `sigil-development` | A reusable sigil needs evidence-based maintenance from telemetry. | [sigil-maintenance-loop.md](../spells/sigil-maintenance-loop.md) |

## Alias Rules

- Canonical spell IDs remain stable and map to filenames.
- Aliases are human-facing lookup names and may be more evocative.
- An alias must resolve to exactly one spell in the active registry.
- Local repositories may add local aliases under `.arcanum/spells/` without changing this registry.
- Spell run reports should record both the alias used and the canonical spell ID.

## Entry Requirements

A spell should be added here when it has:

- a purpose and trigger condition,
- required and optional sigils,
- phase definitions,
- shared state and handoff artifacts,
- gates and failure policy,
- observability guidance,
- output contract.