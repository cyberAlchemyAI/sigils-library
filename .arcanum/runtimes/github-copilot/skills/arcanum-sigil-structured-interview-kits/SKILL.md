---
name: arcanum-sigil-structured-interview-kits
description: Run the installed Arcanum sigil structured-interview-kits from its embedded canonical definition snapshot.
argument-hint: "<request-for-structured-interview-kits>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: structured interview kits

<objective>
Run the installed Arcanum sigil structured-interview-kits using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/structured-interview-kits/SKILL.md.
</context>

<process>
1. Use the embedded canonical definition snapshot below as the execution contract.
2. For sigils, use both the README and SKILL snapshots when present. For spells, follow the spell snapshot directly.
3. Execute only this installed sigil unless the definition explicitly delegates or the user asks to route elsewhere.
4. Preserve the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
5. Apply the observability handoff by summarizing request, artifact, outputs, files changed, validation, gaps, and follow-up; append telemetry under .arcanum/observability/ when allowed.
6. Return the artifact used, command used, validation result, observability result, and next action.
</process>

<guardrails>
- Keep this skill as a thin runtime adapter for one installed artifact.
- Do not require or create .arcanum/necronomicon/ runtime registry files.
- Necronomicon means the Ontology Harness alias.
- Treat the embedded canonical snapshot as the local command contract.
</guardrails>

## Canonical README Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/structured-interview-kits/README.md

````markdown
# Structured Interview Kits

Structured Interview Kits is an Arcana sigil for running evidence-backed interviews one question at a time using pluggable interview modes.

It turns interviewing into a reusable system: select a mode, build a cheap evidence baseline, generate a discriminating question, ask it, record the answer, update the target artifact, and continue until exit criteria are met.

## Problem It Solves

Open-ended interviews can sprawl. Large question banks overwhelm users, and answers often fail to update the artifacts they were meant to clarify.

Structured Interview Kits solves this by enforcing a strict one-question cadence, evidence-backed prompts, explicit patch targets, and mode-specific exit criteria.

## Use When

- a plan, specification, audit, readiness review, or discovery artifact needs human clarification,
- interview behavior should be reusable across domains,
- questions should be generated from evidence rather than generic curiosity,
- each answer should update a concrete artifact,
- different interview modes are needed for different risks.

## Do Not Use When

- the user asked for a single quick answer,
- no artifact should be updated from the interview,
- the workflow cannot wait for human answers,
- the question set is already fixed and deterministic,
- the topic needs broad research before interviewing.

## Mode Model

Each interview mode should define:

- applicability signals,
- question formation strategy,
- required question fields,
- allowed patch targets,
- exit criteria,
- readiness verdict shape.

## Output

The sigil returns:

- selected mode,
- questions asked,
- answers recorded,
- artifacts updated,
- decisions captured,
- remaining ambiguities,
- readiness verdict.

## Why This Is Arcana

The sigil coordinates evidence gathering, mode selection, human gates, artifact mutation, and readiness interpretation across a multi-turn session.
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/structured-interview-kits/SKILL.md

````markdown
---
name: structured-interview-kits
description: "Use when: running one-question-at-a-time interviews with pluggable modes, evidence-backed prompts, and artifact updates after each answer."
argument-hint: "<target-scope> [--mode <mode-id>|auto] [--dry-run]"
tier: arcana
domain: structured-interviewing
version: 0.1.0
origin: generalized from recurring evidence-backed interview practice
allowed-tools: Read, Write, Glob, Grep, AskQuestions, Task
---

# Sigil: Structured Interview Kits

<objective>
Run a reusable interview session that asks one evidence-backed question at a time, records decisions, updates target artifacts, and exits with a readiness verdict.
</objective>

<logic-type>
Arcana: multi-turn human-gated inquiry with mode selection and artifact synchronization.
</logic-type>

<process>
1. Resolve the target scope and candidate artifacts.
2. Build a cheap evidence baseline before asking avoidable questions.
3. Select interview mode:
   - use an explicit mode when provided,
   - select automatically when applicability is clear,
   - ask one clarification question when mode choice is ambiguous.
4. Generate candidate questions using the selected mode's formation strategy.
5. Select the highest-discrimination question: the one most likely to resolve a blocker, expose a risk, or improve an artifact.
6. Ask exactly one question at a time.
7. Each question must include:
   - concise context,
   - why the answer matters,
   - recommended default when safe,
   - unresolved risk if unanswered,
   - target artifact or decision record.
8. Wait for the user answer.
9. Patch or update the target artifact immediately when the answer changes it.
10. Record selected option, rejected alternatives, and rationale when a decision is made.
11. Repeat until mode exit criteria are satisfied.
12. Return `pass`, `flag`, or `block` with remaining ambiguities.
</process>

<mode-extension-contract>
To add a new interview mode, define:

- mode ID,
- applicability signals,
- question formation strategy,
- required question fields,
- allowed patch targets,
- exit criteria,
- readiness verdict rules.

Do not change the orchestrating sigil unless the mode contract itself changes.
</mode-extension-contract>

<quality-bar>
A successful execution must:

- ask one question at a time,
- base each question on evidence or explicit uncertainty,
- avoid dumping full question banks,
- update artifacts after answers when mutation is in scope,
- preserve decision traceability,
- distinguish blocker ambiguity from non-blocker ambiguity,
- stop cleanly when exit criteria are met.
</quality-bar>

<anti-patterns>
Avoid:

- asking broad generic questions without evidence,
- asking multiple unrelated questions at once,
- continuing after a blocker answer contradicts the target artifact without updating it,
- using interview mode as hidden implementation planning,
- inventing answers for the user,
- treating unresolved blocker ambiguity as readiness.
</anti-patterns>

<output-contract>
Return:

```markdown
## Structured Interview Result

- Target scope: <scope>
- Mode: <mode-id>
- Questions asked: <count>
- Decisions recorded: <count>
- Artifacts updated: <paths or none>
- Remaining ambiguities: <summary>
- Verdict: pass | flag | block
- Next step: <action>
```
</output-contract>
````
