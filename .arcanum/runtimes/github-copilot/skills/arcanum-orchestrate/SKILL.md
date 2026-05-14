---
name: arcanum-orchestrate
description: Route Arcanum requests through installed slash commands and ontology harness aliases.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Route a user request to the installed Arcanum slash-command surface. Treat Necronomicon as the Ontology Harness alias, not as a generated runtime registry folder.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Runtime commands live under .arcanum/runtimes/ and may be exposed through repository-specific discovery bridges. Observability state lives under .arcanum/observability/.
</context>

<process>
1. Classify the request as Necronomicon/Ontology Harness, sigil usage, spell usage, install/setup, authoring, validation, observability, or help.
2. Route Necronomicon, ontology, vault, premise, session distillation, business/system branch, or bridge-validation requests to the Ontology Harness command.
3. Route explicit sigil or spell requests to the matching installed arcanum-sigil-<id> or arcanum-spell-<id> command.
4. If multiple routes are plausible, ask one focused clarification.
5. Read the selected installed command adapter and follow its embedded canonical definition snapshot.
6. Apply the observability handoff by summarizing request, route, files changed, validation, gaps, and follow-up; append telemetry under .arcanum/observability/ when allowed.
7. Return the selected route, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter.
- Do not require or create .arcanum/necronomicon/ runtime registry files.
- Necronomicon means the Ontology Harness alias.
- Use installed slash commands as the local execution surface.
</guardrails>

## Installed Command Surface

- `arcanum-orchestrate`: general Arcanum router.
- `arcanum-necronomicon`: alias for `arcanum-spell-ontology-harness`.
- `arcanum-sigil-observability-setup`
- `arcanum-sigil-context-builder`
- `arcanum-sigil-feature-glossary`
- `arcanum-sigil-implementation-layering`
- `arcanum-sigil-architecture-pattern-inventory`
- `arcanum-sigil-decision-gate`
- `arcanum-sigil-definitions-governance`
- `arcanum-sigil-inventory`
- `arcanum-sigil-ontology-vault`
- `arcanum-sigil-residuality-spec`
- `arcanum-sigil-robot-talks`
- `arcanum-sigil-scope-interview`
- `arcanum-sigil-sigil-development`
- `arcanum-sigil-sigil-runtime-installer`
- `arcanum-sigil-signal-observer`
- `arcanum-sigil-skill-decomposer`
- `arcanum-sigil-skill-transcriptor`
- `arcanum-sigil-spellcraft`
- `arcanum-sigil-structured-interview-kits`
- `arcanum-sigil-task-session`
- `arcanum-sigil-workflow-reflect`
- `arcanum-spell-arcanum-bootstrap`
- `arcanum-spell-discovery-to-inventory`
- `arcanum-spell-implementation-readiness`
- `arcanum-spell-ontology-harness`
- `arcanum-spell-repository-harness`
- `arcanum-spell-sigil-maintenance-loop`
