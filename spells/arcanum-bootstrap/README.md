# Arcanum Bootstrap

## Identity

- Canonical ID: `arcanum-bootstrap`
- Aliases: `Arcanum Install`, `Sigil Forge Install`
- Scope: library

## Purpose

Arcanum Bootstrap installs Arcanum runtime support into a consuming repository. It creates observability folders and optional runtime slash commands under one repository-local `.arcanum/` root so users can invoke sigils and spells from their preferred agent surface.

When `ontology-harness` is selected, bootstrap can also initialize Necronomicon session harness state for durable repository memory, selected capability routing, fallback discovery, and capability update reports.

The spell supports two installation postures:

- generate commands for all sigils and spells,
- generate commands for a selected sigil and spell capability set.

## Trigger Conditions

- A user wants to add Arcanum to another repository.
- A repository should expose Arcanum through GitHub Copilot, Claude, or Codex.
- A repository needs `.arcanum/` runtime folders, observability storage, and local slash-command support.
- A user wants to choose individual sigils rather than install all of Arcanum.
- A repository should use Necronomicon as a persistent harness for session memory and selected capability routing.

## Required Sigils

| Sigil                     | Role In Spell                                             | Required Mode      |
| ------------------------- | --------------------------------------------------------- | ------------------ |
| `sigil-runtime-installer` | Select target runtime and install a thin command adapter. | install or dry-run |
| `observability-setup`     | Ensure local `.arcanum/observability/` folders exist.     | install or verify  |

## Optional Sigils

| Sigil               | Use When                                                            | Notes                                             |
| ------------------- | ------------------------------------------------------------------- | ------------------------------------------------- |
| `inventory`         | The target repository should track installed knowledge entries.     | Useful for larger installs.                       |
| `context-builder`   | The target repository should prove retrieval over installed sigils. | Useful after selected installs.                   |
| `sigil-development` | The user plans to author local sigils.                              | Include in authoring-oriented installs.           |
| `spellcraft`        | The user plans to compose local spells.                             | Include when local workflow recipes are expected. |
| `experiment-harness` | The user plans to validate local spells or sigils with examples.    | Include in authoring-oriented installs.           |

## Prerequisites

- Arcanum source root is known.
- Target repository root is known.
- User chooses command posture: all sigils and spells or selected commands.
- User chooses runtime adapter: GitHub Copilot, Claude, Codex, or none.
- Existing target files are preserved unless overwrite is explicitly approved.

## Shared State

| State                                 | Owner             | Updated By                              | Consumed By                                                             |
| ------------------------------------- | ----------------- | --------------------------------------- | ----------------------------------------------------------------------- |
| `.arcanum/`                           | target repository | bootstrap script                        | runtime adapters, users, local agents                                   |
| `.arcanum/observability/`             | target repository | `observability-setup`, bootstrap script | runtime commands, sigil and spell runs, reflection workflows            |
| `.arcanum/runtimes/github-copilot/`   | target repository | `sigil-runtime-installer`               | GitHub Copilot discovery bridge, individual sigil and spell adapters    |
| `.arcanum/runtimes/claude/`           | target repository | `sigil-runtime-installer`               | Claude discovery bridge, individual sigil and spell adapters            |
| `.arcanum/runtimes/codex/`            | target repository | `sigil-runtime-installer`               | Codex discovery bridge, individual sigil and spell adapters             |
| `.arcanum/necronomicon/`              | target repository | bootstrap script, Necronomicon Session  | session memory, capability manifest, route ledgers, decisions, handoffs |
| artifact-local `development/`         | local artifacts   | `experiment-harness`                    | spellcraft, sigil-development, Codex CLI example runners                |
| `.github/skills/arcanum-orchestrate/` | target repository | `sigil-runtime-installer`               | GitHub Copilot discovery only                                           |
| `.claude/commands/`                   | target repository | `sigil-runtime-installer`               | Claude discovery only                                                   |
| `.codex/commands/`                    | target repository | `sigil-runtime-installer`               | Codex discovery only                                                    |
| install report                        | spell             | all phases                              | user, observability                                                     |

## Execution Phases

| Phase | Sigil Or Tool             | Input                                         | Output                                                                                                                                                                         | Gate                                                              | Failure Policy                                         |
| ----- | ------------------------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------ |
| 1     | bootstrap script          | target root, sigil selection, spell selection | dry-run plan or install plan                                                                                                                                                   | target root resolved                                              | block on missing target                                |
| 2     | bootstrap script          | command posture                               | selected sigil and spell command list                                                                                                                                          | selections resolve to canonical Arcanum artifacts                 | block on unknown command selection                     |
| 3     | `observability-setup`     | target root                                   | `.arcanum/observability/`                                                                                                                                                      | folders exist                                                     | flag if setup partial                                  |
| 4     | bootstrap script          | selected ontology/session posture             | optional `.arcanum/necronomicon/` harness state and `capabilities.json`                                                                                                        | folder contains harness state only                                | block on obsolete runtime-book files without `--force` |
| 5     | `sigil-runtime-installer` | selected runtime                              | `.arcanum/runtimes/<runtime>/` orchestrator, per-sigil adapters, per-spell adapters, Necronomicon alias command, Necronomicon session command, plus required discovery bridges | adapters contain executable instruction snapshots                 | skip if runtime is none                                |
| 6     | validation                | installed files                               | command, bridge, syntax, link, and observability validation                                                                                                                    | selected commands can run without copied Necronomicon definitions | block on broken local runtime links                    |
| 7     | spell report              | phase outputs                                 | install report                                                                                                                                                                 | all blockers named                                                | report partial if optional runtime skipped             |

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
- Necronomicon session runtime name: `arcanum-necronomicon-session`, installed by default when `ontology-harness` is selected unless disabled.
- Necronomicon session state root: `.arcanum/necronomicon/`, limited to harness memory, selected capabilities, routes, decisions, handoffs, and capability update reports.
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
- Necronomicon session harness status,
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
- Necronomicon session command: installed | skipped
- Necronomicon harness state: initialized | skipped
- Runtime adapter: github-copilot | claude | codex | none
- Phases completed: <count>
- Gates: pass | block | flag
- Outputs: <paths>
- Validation: <checks>
- Follow-up: <items or none>
```
