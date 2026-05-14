# Sigil Runtime Installer

Sigil Runtime Installer is an Arcana sigil for installing Arcanum sigils into agent-specific command surfaces.

It creates thin runtime adapters for GitHub Copilot, Claude, or Codex so a repository can invoke Arcanum sigils from the agent interface it actually uses. Canonical runtime adapter files live under `.arcanum/runtimes/`; platform-specific folders contain only discovery bridges when required.

For each selected runtime, the installer should create one general `arcanum-orchestrate` adapter plus individual adapters for every installed sigil and spell. Individual adapter names use `arcanum-sigil-<id>` and `arcanum-spell-<id>`.

## Problem It Solves

Arcanum stores canonical sigils as framework artifacts, but each agent runtime has its own command surface and file conventions. A sigil registry is useful only when agents can discover and invoke it without copying the whole framework into every command.

Sigil Runtime Installer bridges that gap. It asks for the target runtime, installs thin adapters under `.arcanum/runtimes/`, adds the required platform discovery bridges, points each adapter at `.arcanum/necronomicon/`, and validates that installed commands can find installed sigils and spells through Necronomicon.

## Use When

- a repository should expose Arcanum sigils as slash-command style skills,
- GitHub Copilot should discover Arcanum through `.github/skills/` while the canonical local adapter lives under `.arcanum/runtimes/github-copilot/`,
- Claude or Codex needs a local command adapter plan,
- a consuming repository should use Arcanum without copying sigil internals,
- installed command wrappers need validation.

Adapters should read Necronomicon first for registry lookup, orchestration routing, and observability handoff. Installed definitions live under `.arcanum/necronomicon/formulae/`, `.arcanum/necronomicon/transmutations/`, `.arcanum/necronomicon/arcana/`, and `.arcanum/necronomicon/spells/`.

## Do Not Use When

- the user only wants to read the registry,
- the target runtime is unknown and the user cannot choose one,
- the repository should not receive agent-specific files,
- the requested install would make local wrappers authoritative over canonical sigils.

## Supported Targets

| Target | Adapter Shape | Canonical Path | Discovery Bridge |
| ------ | ------------- | -------------- | ---------------- |
| GitHub Copilot | repository-local skill wrapper | `.arcanum/runtimes/github-copilot/skills/<command>/SKILL.md` | `.github/skills/<command>/SKILL.md` |
| Claude | command adapter plan | `.arcanum/runtimes/claude/commands/<command>.md` | `.claude/commands/<command>.md` |
| Codex | command adapter plan | `.arcanum/runtimes/codex/commands/<command>.md` | `.codex/commands/<command>.md` |

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