---
name: arcanum-spell-sigil-maintenance-loop
description: Run the installed Arcanum spell sigil-maintenance-loop through Necronomicon.
argument-hint: "<request-for-sigil-maintenance-loop>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: sigil maintenance loop

<objective>
Run the installed Arcanum spell sigil-maintenance-loop through Necronomicon while preserving registry, route, and observability contracts.
</objective>

<context>
Arcanum is installed at .arcanum/ in this repository. Necronomicon is the runtime authority at .arcanum/necronomicon/. The selected definition is .arcanum/necronomicon/spells/sigil-maintenance-loop.md.
</context>

<process>
1. Read .arcanum/necronomicon/REGISTRY.md and .arcanum/necronomicon/OBSERVABILITY.md.
2. Read .arcanum/necronomicon/spells/sigil-maintenance-loop.md.
3. For sigils, also read the sibling README.md when it exists. For spells, follow the spell file directly.
4. Execute only the installed spell sigil-maintenance-loop unless the definition explicitly delegates or the user asks to route elsewhere.
5. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
6. Apply the observability handoff from .arcanum/necronomicon/OBSERVABILITY.md.
7. Return the artifact used, files read, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Do not bypass Necronomicon for registry or observability behavior.
- Do not copy full sigil or spell internals into this wrapper.
</guardrails>
