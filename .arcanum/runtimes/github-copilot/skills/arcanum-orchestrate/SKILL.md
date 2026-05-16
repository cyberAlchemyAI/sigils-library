---
name: arcanum-orchestrate
description: Route Arcanum requests through installed slash commands and ontology harness aliases.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Route a user request to the installed Arcanum slash-command surface. Treat Necronomicon ontology requests as the Ontology Harness alias and Necronomicon session requests as the repository harness session command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Runtime commands live under .arcanum/runtimes/ and may be exposed through repository-specific discovery bridges. Observability state lives under .arcanum/observability/. Necronomicon session state, when enabled, lives under .arcanum/necronomicon/.
</context>

<process>
1. Classify the request as Necronomicon session, Necronomicon/Ontology Harness, sigil usage, spell usage, install/setup, authoring, validation, observability, or help.
2. Route Necronomicon start, create, resume, close, memory, route, fallback, or capability-update requests to arcanum-necronomicon-session when installed.
3. Route Necronomicon ontology, vault, premise, session distillation, business/system branch, or bridge-validation requests to the Ontology Harness command.
4. Route explicit sigil or spell requests to the matching installed command and resolve configured sigil aliases to canonical commands.
5. If multiple routes are plausible, ask one focused clarification.
6. Read the selected installed command adapter and follow its runtime-local sigil or spell contract.
7. Apply the observability handoff by summarizing request, route, files changed, validation, gaps, and follow-up; append telemetry under .arcanum/observability/ when allowed.
8. Return the selected route, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter.
- Keep .arcanum/necronomicon/ as session harness state only when present.
- Do not require or create .arcanum/necronomicon/ runtime registry files.
- Necronomicon ontology requests mean the Ontology Harness alias; Necronomicon session requests mean the repository harness session command.
- Use installed slash commands as the local execution surface.
</guardrails>

## Installed Command Surface

- `arcanum-orchestrate`: general Arcanum router.
- `arcanum-necronomicon`: alias for `arcanum-spell-ontology-harness`.
- `arcanum-necronomicon-session`: persistent repository harness session command.
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
- `arcanum-sigil-interrogation`: alias (Interrogation) for `arcanum-sigil-structured-interview-kits`.
- `arcanum-sigil-task-session`
- `arcanum-sigil-workflow-reflect`
- `arcanum-spell-arcanum-bootstrap`
- `arcanum-spell-discovery-to-inventory`
- `arcanum-spell-implementation-readiness`
- `arcanum-spell-invoke`
- `arcanum-spell-necronomicon-session`
- `arcanum-spell-ontology-harness`
- `arcanum-spell-repository-harness`
- `arcanum-spell-sigil-maintenance-loop`
