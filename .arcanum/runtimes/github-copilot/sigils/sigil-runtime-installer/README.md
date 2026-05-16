# Sigil Runtime Installer

Sigil Runtime Installer is an Arcana sigil for installing Arcanum sigils into agent-specific command surfaces.

It creates runtime adapters for GitHub Copilot, Claude, or Codex so a repository can invoke Arcanum sigils and spells from the agent interface it actually uses. Canonical runtime adapter files live under `.arcanum/runtimes/`; platform-specific folders contain only discovery bridges when required.

For each selected runtime, the installer should create one general `arcanum-orchestrate` adapter plus individual adapters for every selected sigil and spell. Individual adapter names use `arcanum-sigil-<id>` and `arcanum-spell-<id>`. When `ontology-harness` is selected, it should also create `arcanum-necronomicon` as the friendly alias command.

## Problem It Solves

Arcanum stores canonical sigils and spells as framework artifacts, but each agent runtime has its own command surface and file conventions. A registry is useful only when agents can discover and invoke the selected capabilities from their local command surface.

Sigil Runtime Installer bridges that gap. It asks for the target runtime, installs adapters under `.arcanum/runtimes/`, adds the required platform discovery bridges, embeds the canonical instruction snapshot needed by each selected command, and validates that installed commands can run without generated `.arcanum/necronomicon/` registry files.

## Use When

- a repository should expose Arcanum sigils as slash-command style skills,
- GitHub Copilot should discover Arcanum through `.github/skills/` while the canonical local adapter lives under `.arcanum/runtimes/github-copilot/`,
- Claude or Codex needs a local command adapter plan,
- a consuming repository should use Arcanum without generated runtime registry folders,
- installed command wrappers need validation.

Adapters should use their embedded canonical instruction snapshots and apply observability handoff through `.arcanum/observability/`. Necronomicon is the Ontology Harness alias, not a generated definition-storage folder.

## Do Not Use When

- the user only wants to read the registry,
- the target runtime is unknown and the user cannot choose one,
- the repository should not receive agent-specific files,
- the requested install would make local wrappers authoritative over canonical sigils.

## Supported Targets

| Target         | Adapter Shape                  | Canonical Path                                               | Discovery Bridge                    |
| -------------- | ------------------------------ | ------------------------------------------------------------ | ----------------------------------- |
| GitHub Copilot | repository-local skill wrapper | `.arcanum/runtimes/github-copilot/skills/<command>/SKILL.md` | `.github/skills/<command>/SKILL.md` |
| Claude         | command adapter plan           | `.arcanum/runtimes/claude/commands/<command>.md`             | `.claude/commands/<command>.md`     |
| Codex          | command adapter plan           | `.arcanum/runtimes/codex/commands/<command>.md`              | `.codex/commands/<command>.md`      |

For artifact-specific adapters, `<command>` is `arcanum-sigil-<id>` or `arcanum-spell-<id>`.

Repositories may override paths when their local runtime uses a different convention.

## Output

The sigil can produce:

- target selection report,
- install manifest,
- GitHub Copilot skill wrapper,
- Claude command adapter plan,
- Codex command adapter plan,
- validation report.

## Why This Is Arcana

The sigil coordinates target-runtime selection, adapter generation, local path decisions, registry linking, validation, and installation reporting across repository boundaries.
