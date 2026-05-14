---
name: arcanum-spell-ontology-harness
description: Run the installed Arcanum spell ontology-harness through its local runtime adapter.
argument-hint: "<request-for-ontology-harness>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: ontology harness

<objective>
Expose the installed Arcanum spell adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-spell-ontology-harness/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-spell-ontology-harness/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and then .arcanum/necronomicon/spells/ontology-harness.md.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
