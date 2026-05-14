# Arcanum Bootstrap

## Identity

- Canonical ID: `arcanum-bootstrap`
- Aliases: `Arcanum Install`, `Sigil Forge Install`
- Scope: library

## Purpose

Arcanum Bootstrap installs Arcanum into a consuming repository. It exports framework files, registries, selected sigils, selected spells, a Necronomicon runtime book, observability folders, and optional runtime adapters under one repository-local `.arcanum/` root so users can invoke sigils from their preferred agent surface.

The spell supports two installation postures:

- install everything for a full local Arcanum copy,
- install selected sigils and spells for a smaller repository-local capability set.

## Trigger Conditions

- A user wants to add Arcanum to another repository.
- A repository should expose Arcanum through GitHub Copilot, Claude, or Codex.
- A repository needs `.arcanum/` runtime folders, observability storage, and local spell support.
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
- User chooses install posture: all sigils or selected sigils.
- User chooses runtime adapter: GitHub Copilot, Claude, Codex, or none.
- Existing target files are preserved unless overwrite is explicitly approved.

## Shared State

| State | Owner | Updated By | Consumed By |
| ----- | ----- | ---------- | ----------- |
| `.arcanum/` | target repository | bootstrap script | runtime adapters, users, local agents |
| `.arcanum/necronomicon/` | target repository | bootstrap script | runtime adapters, users, local agents |
| `.arcanum/necronomicon/formulae/` | target repository | bootstrap script | Necronomicon, runtime adapters, users, local agents |
| `.arcanum/necronomicon/transmutations/` | target repository | bootstrap script | Necronomicon, runtime adapters, users, local agents |
| `.arcanum/necronomicon/arcana/` | target repository | bootstrap script | Necronomicon, runtime adapters, users, local agents |
| `.arcanum/necronomicon/spells/` | target repository | bootstrap script | Necronomicon, runtime adapters, users, local agents |
| `.arcanum/observability/` | target repository | `observability-setup`, bootstrap script | Necronomicon, sigil runs, reflection workflows |
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
| 2 | bootstrap script | install posture | `.arcanum/necronomicon/framework/`, `.arcanum/necronomicon/registry/`, selected sigils, selected spells | existing files handled by force or block | block on overwrite risk |
| 3 | bootstrap script | installed definitions and selections | `.arcanum/necronomicon/` registry, routes, manifest, observability handoff | selected routes point to copied definitions | block on missing route definition |
| 4 | `observability-setup` | target root | `.arcanum/observability/` | folders exist | flag if setup partial |
| 5 | `sigil-runtime-installer` | selected runtime | `.arcanum/runtimes/<runtime>/` orchestrator, per-sigil adapters, per-spell adapters, plus required discovery bridges | adapters point to Necronomicon | skip if runtime is none |
| 6 | validation | installed files | link, route, manifest, and registry validation | selected sigils resolve through Necronomicon | block on broken local runtime links |
| 7 | spell report | phase outputs | install report | all blockers named | report partial if optional runtime skipped |

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
- Necronomicon runtime root: `.arcanum/necronomicon/`
- Installed sigil definitions: `.arcanum/necronomicon/formulae/`, `.arcanum/necronomicon/transmutations/`, `.arcanum/necronomicon/arcana/`
- Installed spell definitions: `.arcanum/necronomicon/spells/`
- Runtime adapter root: `.arcanum/runtimes/`
- Runtime discovery bridges: target-specific agent folders such as `.github/skills/`
- Individual runtime names: `arcanum-sigil-<id>` and `arcanum-spell-<id>`
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

Necronomicon owns the runtime observability handoff. Raw telemetry remains under `.arcanum/observability/`.

## Output Contract

Return:

```markdown
## Spell Result

- Spell: Arcanum Bootstrap
- Canonical ID: arcanum-bootstrap
- Alias used: <alias or none>
- Repository: <target path>
- Install root: .arcanum/
- Necronomicon root: .arcanum/necronomicon/
- Installed sigil definitions: .arcanum/necronomicon/formulae/, .arcanum/necronomicon/transmutations/, .arcanum/necronomicon/arcana/
- Installed spell definitions: .arcanum/necronomicon/spells/
- Sigils installed: all | <list>
- Spells installed: all | none | <list>
- Runtime adapter: github-copilot | claude | codex | none
- Phases completed: <count>
- Gates: pass | block | flag
- Outputs: <paths>
- Validation: <checks>
- Follow-up: <items or none>
```