---
name: arcanum-sigil-robot-talks
description: Run the installed Arcanum sigil robot-talks through its local runtime adapter.
argument-hint: "<request-for-robot-talks>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: robot talks

<objective>
Expose the installed Arcanum sigil adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-sigil-robot-talks/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-sigil-robot-talks/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and then .arcanum/necronomicon/arcana/robot-talks/SKILL.md.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
