---
name: arcanum-spell-repository-harness
description: Run the installed Arcanum spell repository-harness through Necronomicon.
argument-hint: "<request-for-repository-harness>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: repository harness

<objective>
Run the installed Arcanum spell repository-harness through Necronomicon while preserving registry, route, and observability contracts.
</objective>

<context>
Arcanum is installed at .arcanum/ in this repository. Necronomicon is the runtime authority at .arcanum/necronomicon/. The selected definition is .arcanum/necronomicon/spells/repository-harness.md.
</context>

<process>
1. Read .arcanum/necronomicon/REGISTRY.md and .arcanum/necronomicon/OBSERVABILITY.md.
2. Read .arcanum/necronomicon/spells/repository-harness.md.
3. For sigils, also read the sibling README.md when it exists. For spells, follow the spell file directly.
4. Execute only the installed spell repository-harness unless the definition explicitly delegates or the user asks to route elsewhere.
5. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
6. Apply the observability handoff from .arcanum/necronomicon/OBSERVABILITY.md.
7. Return the artifact used, files read, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Do not bypass Necronomicon for registry or observability behavior.
- Do not copy full sigil or spell internals into this wrapper.
</guardrails>
