---
name: arcanum-spell-sigil-maintenance-loop
description: Run the installed Arcanum spell sigil-maintenance-loop through its local runtime adapter.
argument-hint: "<request-for-sigil-maintenance-loop>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum spell: sigil maintenance loop

<objective>
Expose the installed Arcanum spell adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-spell-sigil-maintenance-loop/SKILL.md.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-spell-sigil-maintenance-loop/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, report a blocked install and ask to rerun Arcanum bootstrap.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full artifact internals into this wrapper.
</guardrails>
