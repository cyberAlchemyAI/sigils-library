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

Install the general `arcanum-orchestrate` command and individual artifact commands for each selected sigil and spell. Individual commands use `arcanum-sigil-<id>` and `arcanum-spell-<id>`. When `ontology-harness` is selected, also install `arcanum-necronomicon` as its friendly alias command and `arcanum-necronomicon-session` as the persistent repository harness command unless disabled.

When `experiment-harness` is selected for Codex, also install the short convenience aliases `experiment-next`, `experiment-run`, `experiment-validate`, and `experiment-observe`. These aliases remain thin wrappers around `arcanum-sigil-experiment-harness`.
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
				 .github/skills/arcanum-necronomicon-session/SKILL.md
				 .arcanum/runtimes/github-copilot/skills/arcanum-necronomicon-session/SKILL.md
claude         -> .claude/commands/arcanum-orchestrate.md
				 .arcanum/runtimes/claude/commands/arcanum-orchestrate.md
				 .claude/commands/arcanum-sigil-<id>.md
				 .arcanum/runtimes/claude/commands/arcanum-sigil-<id>.md
				 .claude/commands/arcanum-spell-<id>.md
				 .arcanum/runtimes/claude/commands/arcanum-spell-<id>.md
				 .claude/commands/arcanum-necronomicon-session.md
				 .arcanum/runtimes/claude/commands/arcanum-necronomicon-session.md
codex          -> .codex/commands/arcanum-orchestrate.md
				 .arcanum/runtimes/codex/commands/arcanum-orchestrate.md
				 .codex/commands/arcanum-sigil-<id>.md
				 .arcanum/runtimes/codex/commands/arcanum-sigil-<id>.md
				 .codex/commands/arcanum-spell-<id>.md
				 .arcanum/runtimes/codex/commands/arcanum-spell-<id>.md
				 .codex/commands/arcanum-necronomicon-session.md
				 .arcanum/runtimes/codex/commands/arcanum-necronomicon-session.md
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
7. Do not require generated `.arcanum/necronomicon/` registry files. If Necronomicon session state exists there, treat it as harness memory and selected capability state only.
8. Preserve local runtime conventions and avoid changing unrelated agent files.
9. When repository observability is installed, prefer the observed-run wrapper pattern:
   - start observed run,
   - execute the selected command inline or through the runtime,
   - checkpoint meaningful phases for long work,
   - finish observed run,
   - dispatch observer hook,
   - append capability telemetry and hook operation rows.

## Step 3 - Install Or Dry Run

10. In dry-run mode, return the files that would be created or updated.
11. In install mode, create or update only the selected runtime files under `.arcanum/runtimes/` plus the required platform discovery bridges.
12. If an existing adapter has unrelated local changes, stop and ask before overwriting.

## Step 4 - Validate

13. Check that the adapter file exists.
14. Check that the adapter contains or points to a resolvable canonical definition snapshot.
15. Check that links in generated markdown resolve when the repository has a markdown link checker.
16. Check that the adapter names the canonical source and does not make local wrappers authoritative.
17. Return pass, flag, or block.
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
- install the Necronomicon session command when the repository harness is enabled,
- avoid requiring generated `.arcanum/necronomicon/` definition files,
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
