---
name: arcanum-sigil-inventory
description: Run the installed Arcanum sigil inventory through its local runtime adapter.
argument-hint: "<request-for-inventory>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: inventory

<objective>
Expose the installed Arcanum sigil adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-sigil-inventory/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-sigil-inventory/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and then .arcanum/necronomicon/arcana/inventory/SKILL.md.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
