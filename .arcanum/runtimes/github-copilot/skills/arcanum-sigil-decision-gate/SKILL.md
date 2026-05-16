---
name: arcanum-sigil-decision-gate
description: Run the installed Arcanum sigil decision-gate from runtime-local contract files.
argument-hint: "<request-for-decision-gate>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: decision gate

<objective>
Run the installed Arcanum sigil decision-gate using runtime-local contract files.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Runtime-local contracts for this runtime live under .arcanum/runtimes/github-copilot/sigils/ and .arcanum/runtimes/github-copilot/spells/.
</context>

<process>
1. Read the runtime-local contract file at .arcanum/runtimes/github-copilot/sigils/decision-gate/SKILL.md.
2. For sigils, also read .arcanum/runtimes/github-copilot/sigils/decision-gate/README.md when it exists.
3. Execute only this installed sigil unless the definition explicitly delegates or the user asks to route elsewhere.
4. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
5. Apply the observability handoff by summarizing request, artifact, outputs, files changed, validation, gaps, and follow-up; append telemetry under .arcanum/observability/ when allowed.
6. Return the artifact used, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Use runtime-local contracts under .arcanum/runtimes/github-copilot/ as the command contract.
- Do not reference upstream Arcanum source paths from this runtime adapter.
</guardrails>
