---
name: arcanum-orchestrate
description: Route Arcanum requests through the installed local Arcanum runtime adapter.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Expose the installed Arcanum GitHub Copilot adapter to GitHub Copilot's required discovery path.
</objective>

<context>
The canonical local adapter lives at .arcanum/runtimes/github-copilot/skills/arcanum-orchestrate/SKILL.md. Necronomicon lives under .arcanum/necronomicon/.
</context>

<process>
1. Read .arcanum/runtimes/github-copilot/skills/arcanum-orchestrate/SKILL.md.
2. Follow that adapter's process.
3. If the runtime adapter is unavailable, read .arcanum/necronomicon/REGISTRY.md and .arcanum/necronomicon/ROUTES.md directly.
</process>

<guardrails>
- Keep this file as a discovery bridge only.
- Do not copy full sigil internals into this wrapper.
- Treat .arcanum/runtimes/github-copilot/ and .arcanum/necronomicon/ as authoritative for installed runtime behavior.
</guardrails>
