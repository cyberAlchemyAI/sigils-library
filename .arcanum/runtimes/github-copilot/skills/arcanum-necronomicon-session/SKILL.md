---
name: arcanum-necronomicon-session
description: Create, set up, resume, research, route, maintain, update, or close a repository-local Necronomicon session harness.
argument-hint: "<setup|start|resume|route|checkpoint|research|implementation-research|update-capabilities|fallback-discover|maintain|close> <request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Necronomicon Session

<objective>
Run the installed Necronomicon session harness using the runtime-local necronomicon-session spell contract.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon session state lives under .arcanum/necronomicon/. Runtime commands live under .arcanum/runtimes/.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/spells/necronomicon-session/README.md.
2. Read .arcanum/necronomicon/capabilities.json when it exists.
3. Resolve the mode as setup, start, resume, route, checkpoint, research, implementation-research, update-capabilities, fallback-discover, maintain, or close.
4. Load active session memory from .arcanum/necronomicon/sessions/ when resuming, routing, checkpointing, researching, or maintaining.
5. Prefer selected local capabilities from the manifest before considering fallback candidates.
6. Route ontology, vault, premise, branch, bridge, confidence, or session-distillation work to arcanum-necronomicon or arcanum-spell-ontology-harness when installed.
7. Route lifecycle authoring requests (define, design, plan, full, validate) and implementation-research handoffs to arcanum-spell-invoke when installed.
8. In research mode, use bounded source order (session/inventory/ontology/docs/code/web) and include web sources when runtime/tool support exists.
9. In maintain mode, aggregate route telemetry plus all selected sigil/spell signals and run arcanum-spell-sigil-maintenance-loop when installed.
10. If no selected capability matches, inspect installed runtime commands and runtime-local contracts, then offer 2-5 fallback candidates before adding anything.
11. Record route attempts, decisions, memory changes, gap updates, and capability update recommendations under .arcanum/necronomicon/ when mutation is allowed.
12. If web access is unavailable, continue repository research and report a web-unavailable note.
13. Apply the observability handoff under .arcanum/observability/ when available.
14. Return the session ID, selected route, confidence, fallback status, files updated, validation result, and next action.
</process>

<guardrails>
- Keep .arcanum/necronomicon/ as harness state only.
- Do not copy formulae, transmutations, arcana, spells, registries, or framework folders into .arcanum/necronomicon/.
- Do not add fallback capabilities silently.
- Do not treat session memory as more authoritative than source documents, registries, or implementation evidence.
</guardrails>
