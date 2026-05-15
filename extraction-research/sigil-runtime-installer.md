# Extraction Research Note: sigil-runtime-installer

## Reusable Core

- Install Arcanum sigils into agent-specific command surfaces.
- Let the user select a target runtime: GitHub Copilot, Claude, or Codex.
- Generate thin adapter files that route to Arcanum registries and sigil contracts rather than copying sigil internals.
- Support repository-local installation without changing the canonical sigil source.
- Validate that installed adapters point to existing registries and preserve target runtime conventions.

## Coupling Risk

- Treating one agent runtime layout as universal.
- Copying all sigil internals into command wrappers instead of linking back to Arcanum.
- Installing commands into a repository without an explicit target runtime selection.
- Making local adapter files authoritative over the canonical sigil registry.

## Neutral Rewrite Strategy

- Model each target as an adapter with its own install path, file shape, and validation rules.
- Use GitHub Copilot `.github/skills/<command>/SKILL.md` for Copilot slash-command style skills.
- Use Claude and Codex adapter plans as generated targets, while allowing repositories to override paths when their local runtime differs.
- Keep installed wrappers thin: discover, route, read canonical sigil files, execute the selected workflow, and report validation.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: create
- Rationale: runtime installation requires target selection, adapter generation, user decisions, path validation, and cross-repository integration.
