---
name: arcanum-spell-arcanum-bootstrap
description: Run the installed Arcanum spell arcanum-bootstrap from its embedded canonical definition snapshot.
argument-hint: "<request-for-arcanum-bootstrap>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: arcanum bootstrap

<objective>
Run the installed Arcanum spell arcanum-bootstrap using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/arcanum-bootstrap.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/spells/arcanum-bootstrap.md

````markdown
# Arcanum Bootstrap

## Identity

- Canonical ID: `arcanum-bootstrap`
- Aliases: `Arcanum Install`, `Sigil Forge Install`
- Scope: library

## Purpose

Arcanum Bootstrap installs Arcanum runtime support into a consuming repository. It creates observability folders and optional runtime slash commands under one repository-local `.arcanum/` root so users can invoke sigils and spells from their preferred agent surface.

The spell supports two installation postures:

- generate commands for all sigils and spells,
- generate commands for a selected sigil and spell capability set.

## Trigger Conditions

- A user wants to add Arcanum to another repository.
- A repository should expose Arcanum through GitHub Copilot, Claude, or Codex.
- A repository needs `.arcanum/` runtime folders, observability storage, and local slash-command support.
- A user wants to choose individual sigils rather than install all of Arcanum.

## Required Sigils

| Sigil | Role In Spell | Required Mode |
| ----- | ------------- | ------------- |
| `sigil-runtime-installer` | Select target runtime and install a thin command adapter. | install or dry-run |
| `observability-setup` | Ensure local `.arcanum/observability/` folders exist. | install or verify |

## Optional Sigils

| Sigil | Use When | Notes |
| ----- | -------- | ----- |
| `inventory` | The target repository should track installed knowledge entries. | Useful for larger installs. |
| `context-builder` | The target repository should prove retrieval over installed sigils. | Useful after selected installs. |
| `sigil-development` | The user plans to author local sigils. | Include in authoring-oriented installs. |
| `spellcraft` | The user plans to compose local spells. | Include when local workflow recipes are expected. |

## Prerequisites

- Arcanum source root is known.
- Target repository root is known.
- User chooses command posture: all sigils and spells or selected commands.
- User chooses runtime adapter: GitHub Copilot, Claude, Codex, or none.
- Existing target files are preserved unless overwrite is explicitly approved.

## Shared State

| State | Owner | Updated By | Consumed By |
| ----- | ----- | ---------- | ----------- |
| `.arcanum/` | target repository | bootstrap script | runtime adapters, users, local agents |
| `.arcanum/observability/` | target repository | `observability-setup`, bootstrap script | runtime commands, sigil and spell runs, reflection workflows |
| `.arcanum/runtimes/github-copilot/` | target repository | `sigil-runtime-installer` | GitHub Copilot discovery bridge, individual sigil and spell adapters |
| `.arcanum/runtimes/claude/` | target repository | `sigil-runtime-installer` | Claude discovery bridge, individual sigil and spell adapters |
| `.arcanum/runtimes/codex/` | target repository | `sigil-runtime-installer` | Codex discovery bridge, individual sigil and spell adapters |
| `.github/skills/arcanum-orchestrate/` | target repository | `sigil-runtime-installer` | GitHub Copilot discovery only |
| `.claude/commands/` | target repository | `sigil-runtime-installer` | Claude discovery only |
| `.codex/commands/` | target repository | `sigil-runtime-installer` | Codex discovery only |
| install report | spell | all phases | user, observability |

## Execution Phases

| Phase | Sigil Or Tool | Input | Output | Gate | Failure Policy |
| ----- | ------------- | ----- | ------ | ---- | -------------- |
| 1 | bootstrap script | target root, sigil selection, spell selection | dry-run plan or install plan | target root resolved | block on missing target |
| 2 | bootstrap script | command posture | selected sigil and spell command list | selections resolve to canonical Arcanum artifacts | block on unknown command selection |
| 3 | `observability-setup` | target root | `.arcanum/observability/` | folders exist | flag if setup partial |
| 4 | `sigil-runtime-installer` | selected runtime | `.arcanum/runtimes/<runtime>/` orchestrator, per-sigil adapters, per-spell adapters, Necronomicon alias command when `ontology-harness` is selected, plus required discovery bridges | adapters contain executable instruction snapshots | skip if runtime is none |
| 5 | validation | installed files | command, bridge, syntax, link, and observability validation | selected commands can run without generated Necronomicon files | block on broken local runtime links |
| 6 | spell report | phase outputs | install report | all blockers named | report partial if optional runtime skipped |

## Bootstrap Script

For consuming repositories, use the curl installer:

```bash
curl -fsSL https://raw.githubusercontent.com/cyberAlchemyAI/arcanum/main/tools/install_arcanum.sh | bash -s -- --target . --sigils all --spells all --runtime github-copilot
```

The curl installer downloads the Arcanum repository archive and delegates to the portable bootstrap script.

When working from a local checkout, run the bootstrap script directly:

```bash
arcanum/tools/bootstrap_arcanum.sh --target <repo> --sigils all --spells all --runtime github-copilot
```

Selected install example:

```bash
curl -fsSL https://raw.githubusercontent.com/cyberAlchemyAI/arcanum/main/tools/install_arcanum.sh | bash -s -- \
  --target . \
  --sigils ontology-vault,context-builder,sigil-runtime-installer \
  --spells ontology-harness \
  --runtime github-copilot
```

Dry-run example:

```bash
arcanum/tools/bootstrap_arcanum.sh --target <repo> --sigils all --runtime none --dry-run
```

## Local Customization

- Install root: `.arcanum/`
- Runtime adapter root: `.arcanum/runtimes/`
- Runtime discovery bridges: target-specific agent folders such as `.github/skills/`
- Individual runtime names: `arcanum-sigil-<id>` and `arcanum-spell-<id>`
- Necronomicon runtime name: `arcanum-necronomicon`, installed when `ontology-harness` is selected.
- Observability root: `.arcanum/observability/`
- Gate strictness: strict for overwrites, standard for selected install validation.
- Interaction mode: interactive for selection, dry-run for preview, install for execution.

## Observability

Record spell-level telemetry when `.arcanum/observability/` exists:

- spell name,
- target repository,
- install posture,
- selected sigils,
- selected spells,
- runtime adapter,
- files created,
- files skipped,
- validation result,
- follow-up actions.

Runtime commands own the observability handoff. Raw telemetry remains under `.arcanum/observability/`.

## Output Contract

Return:

```markdown
## Spell Result

- Spell: Arcanum Bootstrap
- Canonical ID: arcanum-bootstrap
- Alias used: <alias or none>
- Repository: <target path>
- Install root: .arcanum/
- Sigil commands: all | <list>
- Spell commands: all | none | <list>
- Necronomicon alias command: installed | skipped
- Runtime adapter: github-copilot | claude | codex | none
- Phases completed: <count>
- Gates: pass | block | flag
- Outputs: <paths>
- Validation: <checks>
- Follow-up: <items or none>
```
````
