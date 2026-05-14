---
name: arcanum-spell-implementation-readiness
description: Run the installed Arcanum spell implementation-readiness through its local runtime adapter.
argument-hint: "<request-for-implementation-readiness>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: implementation readiness

<objective>
Expose the installed Arcanum spell adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-spell-implementation-readiness/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-spell-implementation-readiness/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and then .arcanum/necronomicon/spells/implementation-readiness.md.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
