---
name: arcanum-orchestrate
description: Route Arcanum requests through the installed local Necronomicon runtime book.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Route a user request through Necronomicon, the installed Arcanum runtime book for registry lookup, orchestration, and observability handoff.
</objective>

<context>
Arcanum is installed at .arcanum/ in this repository. Read .arcanum/necronomicon/README.md, .arcanum/necronomicon/REGISTRY.md, .arcanum/necronomicon/ROUTES.md, and .arcanum/necronomicon/OBSERVABILITY.md. Use definition paths from Necronomicon when a route is selected.
</context>

<process>
1. Read the installed Necronomicon runtime files.
2. Classify the request using .arcanum/necronomicon/ROUTES.md.
3. Select one installed sigil or spell from .arcanum/necronomicon/REGISTRY.md. If multiple routes are plausible, ask one focused clarification.
4. Read the selected definition path named by Necronomicon.
5. Follow the selected artifact's process and preserve its Quality Bar, Anti-Patterns, output contract, and validation gates.
6. Apply the observability handoff from .arcanum/necronomicon/OBSERVABILITY.md.
7. Return the selected route, files used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter.
- Treat .arcanum/necronomicon/ as the runtime authority for registry and orchestration.
- Treat .arcanum/necronomicon/formulae/, .arcanum/necronomicon/transmutations/, .arcanum/necronomicon/arcana/, and .arcanum/necronomicon/spells/ as definition storage selected through Necronomicon.
- Do not copy full sigil internals into this wrapper.
</guardrails>
