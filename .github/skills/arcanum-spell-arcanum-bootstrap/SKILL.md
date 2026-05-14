---
name: arcanum-spell-arcanum-bootstrap
description: Run the installed Arcanum spell arcanum-bootstrap through its local runtime adapter.
argument-hint: "<request-for-arcanum-bootstrap>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: arcanum bootstrap

<objective>
Expose the installed Arcanum spell adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-spell-arcanum-bootstrap/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-spell-arcanum-bootstrap/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and then .arcanum/necronomicon/spells/arcanum-bootstrap.md.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
