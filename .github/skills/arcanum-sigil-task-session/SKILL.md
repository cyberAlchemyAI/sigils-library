---
name: arcanum-sigil-task-session
description: Run the installed Arcanum sigil task-session through its local runtime adapter.
argument-hint: "<request-for-task-session>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: task session

<objective>
Expose the installed Arcanum sigil adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-sigil-task-session/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-sigil-task-session/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and then .arcanum/necronomicon/arcana/task-session/SKILL.md.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
