---
name: arcanum-sigil-sigil-runtime-installer
description: Run the installed Arcanum sigil sigil-runtime-installer from its embedded canonical definition snapshot.
argument-hint: "<request-for-sigil-runtime-installer>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: sigil runtime installer

<objective>
Run the installed Arcanum sigil sigil-runtime-installer using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/sigil-runtime-installer/SKILL.md.
</context>

<process>
1. Use the embedded canonical definition snapshot below as the execution contract.
2. For sigils, use both the README and SKILL snapshots when present. For spells, follow the spell snapshot directly.
3. Execute only this installed sigil unless the definition explicitly delegates or the user asks to route elsewhere.
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

## Canonical README Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/sigil-runtime-installer/README.md

````markdown
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
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/sigil-runtime-installer/SKILL.md

````markdown
---
name: sigil-runtime-installer
description: "Use when: installing Arcanum sigils into GitHub Copilot, Claude, or Codex command surfaces by user-selected target runtime."
argument-hint: "<github-copilot|claude|codex> [--repo <path>] [--command <name>] [--registry <path>] [--dry-run]"
tier: arcana
domain: sigil-runtime-installation
version: 0.1.0
origin: created to expose Arcanum sigils through agent-specific command adapters without copying canonical sigil internals
allowed-tools: Read, Write, Glob, Grep, Bash, AskQuestions
---

# Sigil: Sigil Runtime Installer

<objective>
Install runtime adapters that expose Arcanum sigils and spells through a selected agent command surface while preserving Necronomicon as the Ontology Harness alias.
</objective>

<logic-type>
Arcana: target selection, adapter generation, repository-local installation, validation, and runtime-specific routing.
</logic-type>

<targets>
- `github-copilot`: create `.arcanum/runtimes/github-copilot/skills/<command>/SKILL.md` and a `.github/skills/<command>/SKILL.md` discovery bridge.
- `claude`: create or plan `.arcanum/runtimes/claude/commands/<command>.md` and a `.claude/commands/<command>.md` discovery bridge.
- `codex`: create or plan `.arcanum/runtimes/codex/commands/<command>.md` and a `.codex/commands/<command>.md` discovery bridge.

Install the general `arcanum-orchestrate` command and individual artifact commands for each selected sigil and spell. Individual commands use `arcanum-sigil-<id>` and `arcanum-spell-<id>`. When `ontology-harness` is selected, also install `arcanum-necronomicon` as its friendly alias command.
</targets>

<applicability>
Use this sigil when a repository should invoke Arcanum sigils from an agent-specific slash-command style interface.
</applicability>

<inputs>
Expected inputs, if available:

- target runtime,
- repository root,
- Arcanum registry path,
- observability path,
- command name,
- install path override,
- dry-run preference,
- local runtime conventions.
</inputs>

<default-output>
If no command is provided, install or plan `arcanum-orchestrate` plus individual artifact adapters.

Default paths:

```text
github-copilot -> .github/skills/arcanum-orchestrate/SKILL.md
				 .arcanum/runtimes/github-copilot/skills/arcanum-orchestrate/SKILL.md
				 .github/skills/arcanum-sigil-<id>/SKILL.md
				 .arcanum/runtimes/github-copilot/skills/arcanum-sigil-<id>/SKILL.md
				 .github/skills/arcanum-spell-<id>/SKILL.md
				 .arcanum/runtimes/github-copilot/skills/arcanum-spell-<id>/SKILL.md
claude         -> .claude/commands/arcanum-orchestrate.md
				 .arcanum/runtimes/claude/commands/arcanum-orchestrate.md
				 .claude/commands/arcanum-sigil-<id>.md
				 .arcanum/runtimes/claude/commands/arcanum-sigil-<id>.md
				 .claude/commands/arcanum-spell-<id>.md
				 .arcanum/runtimes/claude/commands/arcanum-spell-<id>.md
codex          -> .codex/commands/arcanum-orchestrate.md
				 .arcanum/runtimes/codex/commands/arcanum-orchestrate.md
				 .codex/commands/arcanum-sigil-<id>.md
				 .arcanum/runtimes/codex/commands/arcanum-sigil-<id>.md
				 .codex/commands/arcanum-spell-<id>.md
				 .arcanum/runtimes/codex/commands/arcanum-spell-<id>.md
```
</default-output>

<process>
## Step 1 - Select Target Runtime

1. If the target runtime is not provided, ask the user to select GitHub Copilot, Claude, or Codex.
2. Resolve repository root and Arcanum registry path.
3. Resolve command name, defaulting to `arcanum-orchestrate`.
4. Detect whether the target install path already exists.

## Step 2 - Build Adapter Plan

5. Choose adapter shape for the selected target.
6. Keep the adapter focused: route requests, follow its embedded canonical definition snapshot, apply observability handoff, and report validation.
7. Do not require generated `.arcanum/necronomicon/` registry files.
8. Preserve local runtime conventions and avoid changing unrelated agent files.

## Step 3 - Install Or Dry Run

9. In dry-run mode, return the files that would be created or updated.
10. In install mode, create or update only the selected runtime files under `.arcanum/runtimes/` plus the required platform discovery bridges.
11. If an existing adapter has unrelated local changes, stop and ask before overwriting.

## Step 4 - Validate

12. Check that the adapter file exists.
13. Check that the adapter contains or points to a resolvable canonical definition snapshot.
14. Check that links in generated markdown resolve when the repository has a markdown link checker.
15. Check that the adapter names the canonical source and does not make local wrappers authoritative.
16. Return pass, flag, or block.
</process>

<github-copilot-adapter>
The canonical GitHub Copilot adapter should live at:

```text
.arcanum/runtimes/github-copilot/skills/<command>/SKILL.md
```

GitHub Copilot discovery still requires a bridge at:

```text
.github/skills/<command>/SKILL.md
```

It should include frontmatter fields supported by repository-local Copilot skills, then a compact process that:

1. maps the user request to a sigil, spell, or Necronomicon/Ontology Harness alias,
2. reads the selected installed command adapter,
3. follows the embedded canonical definition snapshot,
4. applies `.arcanum/observability/` handoff,
5. reports which canonical sigil or spell was used.
</github-copilot-adapter>

<claude-adapter>
The Claude adapter should be generated as a command adapter plan unless the repository already has a confirmed Claude command convention. Default canonical path:

```text
.arcanum/runtimes/claude/commands/<command>.md
```

Default discovery bridge:

```text
.claude/commands/<command>.md
```
</claude-adapter>

<codex-adapter>
The Codex adapter should be generated as a command adapter plan unless the repository already has a confirmed Codex command convention. Default canonical path:

```text
.arcanum/runtimes/codex/commands/<command>.md
```

Default discovery bridge:

```text
.codex/commands/<command>.md
```
</codex-adapter>

<quality-bar>
A successful execution must:

- require or infer a single selected target runtime,
- install orchestrator, per-sigil, and per-spell runtime adapter files plus required discovery bridges,
- keep Necronomicon as the Ontology Harness alias,
- avoid requiring generated `.arcanum/necronomicon/` files,
- validate adapter paths and registry links,
- preserve unrelated local agent configuration,
- report what was installed and how to invoke it.
</quality-bar>

<anti-patterns>
Avoid:

- installing for multiple runtimes when the user selected one,
- overwriting existing command files without checking ownership,
- embedding stale or untraceable copies of sigil instructions in adapter files,
- assuming Claude or Codex path conventions without allowing override,
- making a consuming repository's adapter the canonical sigil source,
- hiding validation failures behind a successful install message.
</anti-patterns>

<observability>
When `.arcanum/observability/` exists, emit telemetry for:

- selected target runtime,
- repository root,
- command name,
- files created,
- files updated,
- registry path,
- Necronomicon alias command status,
- validation result,
- blockers.
</observability>

<output-contract>
Return:

```markdown
## Sigil Runtime Installer Result

- Target runtime: github-copilot | claude | codex
- Repository: <path>
- Command: <name>
- Registry: <path>
- Files created: <paths>
- Files updated: <paths>
- Dry run: yes | no
- Validation: pass | flag | block
- Invocation: <command or command name>
- Next action: <action>
```
</output-contract>
````
