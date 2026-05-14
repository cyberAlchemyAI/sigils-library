---
name: arcanum-sigil-scope-interview
description: Run the installed Arcanum sigil scope-interview from its embedded canonical definition snapshot.
argument-hint: "<request-for-scope-interview>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: scope interview

<objective>
Run the installed Arcanum sigil scope-interview using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/scope-interview/SKILL.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/scope-interview/README.md

````markdown
# Scope Interview

Scope Interview is an Arcana sigil for turning a vague idea or existing repository into a discovery baseline.

It supports greenfield work, brownfield work, and mixed contexts. The sigil inspects available evidence, asks focused questions, separates observed facts from stated intent and hypotheses, records blocker decisions, and returns a readiness verdict.

## Problem It Solves

Early project work often mixes what exists, what someone wants, and what the team hopes is true. That confusion makes later planning brittle.

Scope Interview creates a stable discovery baseline before detailed specification or implementation. It clarifies actors, goals, workflows, boundaries, decisions, metrics, risks, and unknowns.

## Use When

- a new idea needs structured discovery,
- an existing repository needs a brownfield scope audit,
- project boundaries are unclear,
- business, product, or workflow assumptions need to be surfaced,
- a team needs a readiness verdict before planning.

## Do Not Use When

- the scope is already stable and documented,
- the user wants implementation now,
- the question is local to one task,
- the repository cannot be inspected and the user cannot answer questions,
- the work needs a narrow decision gate rather than broad discovery.

## Discovery Baseline

The output package should separate:

- observed evidence,
- stated intent,
- inferred hypotheses,
- decisions made,
- blocker decisions,
- in-scope boundaries,
- out-of-scope boundaries,
- candidate validation activities.

## Why This Is Arcana

Scope Interview coordinates repository inspection, human discovery, evidence classification, decision capture, and readiness routing. It is a strategic entrypoint, not a single artifact transformation.
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/scope-interview/SKILL.md

````markdown
---
name: scope-interview
description: "Use when: interviewing a greenfield idea, brownfield repository, or mixed project scope into a structured discovery baseline."
argument-hint: "[greenfield|brownfield|auto] <project-or-scope> [--output <folder>]"
tier: arcana
domain: scope-discovery
version: 0.1.0
origin: generalized from recurring project discovery interview practice
allowed-tools: Read, Write, Glob, Grep, AskQuestions
---

# Sigil: Scope Interview

<objective>
Turn a vague idea or existing project into a usable discovery baseline that separates observed evidence, stated intent, hypotheses, decisions, and readiness gaps.
</objective>

<logic-type>
Arcana: discovery orchestration with evidence inspection, human interview, and readiness gates.
</logic-type>

<process>
1. Detect mode:
   - `greenfield`: little or no implementation or documentation exists,
   - `brownfield`: implementation or documentation already exists,
   - `auto`: inspect available materials and choose.
2. Build a cheap evidence baseline:
   - read project summaries, docs, tests, source entrypoints, existing decisions, and relevant notes when present,
   - avoid asking questions already answered by evidence.
3. Interview the user one focused question at a time about:
   - users or actors,
   - goals and jobs,
   - workflows,
   - policies and constraints,
   - integrations,
   - success metrics,
   - failure modes,
   - boundaries,
   - blocker decisions.
4. Separate every finding into one of these categories:
   - observed,
   - stated,
   - hypothesized,
   - decided,
   - unresolved.
5. Draft or update the discovery baseline package.
6. For brownfield or mixed mode, enforce scope gates:
   - in-scope areas have observed evidence or explicit user confirmation,
   - out-of-scope boundaries are documented,
   - blocker decisions are recorded with selected option or blocked status.
7. Add counter-positioning for central assumptions: plausible alternative explanations, downsides, or invalidation conditions.
8. Return a readiness verdict:
   - `ready for planning`,
   - `needs more discovery`,
   - `blocked on scope gate`,
   - `blocked on decisions`.
</process>

<quality-bar>
A successful execution must:

- distinguish observed, stated, hypothesized, decided, and unresolved content,
- cite repository evidence when available,
- document in-scope and out-of-scope boundaries,
- record blocker decisions or blocked status,
- make hypotheses falsifiable,
- avoid implementation planning before the baseline is stable,
- return a readiness verdict with concrete next actions.
</quality-bar>

<anti-patterns>
Avoid:

- treating user hopes as observed facts,
- inspecting code so broadly that the interview never starts,
- producing implementation tasks before scope is understood,
- hiding out-of-scope boundaries,
- omitting counter-positions for central assumptions,
- marking readiness while blocker decisions remain unresolved.
</anti-patterns>

<output-contract>
Return:

```markdown
## Scope Interview Result

- Mode: greenfield | brownfield | auto
- Scope: <scope>
- Evidence inspected: <summary>
- Discovery artifacts: <paths>
- Decisions recorded: <count>
- Blockers: <count>
- Verdict: ready for planning | needs more discovery | blocked on scope gate | blocked on decisions
- Next actions: <ordered list>
```
</output-contract>
````
