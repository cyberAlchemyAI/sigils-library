---
name: arcanum-spell-discovery-to-inventory
description: Run the installed Arcanum spell discovery-to-inventory through its local runtime adapter.
argument-hint: "<request-for-discovery-to-inventory>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: discovery to inventory

<objective>
Expose the installed Arcanum spell adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-spell-discovery-to-inventory/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-spell-discovery-to-inventory/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, report a blocked install and ask to rerun Arcanum bootstrap.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
