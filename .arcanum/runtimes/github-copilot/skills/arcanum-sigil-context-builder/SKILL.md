---
name: arcanum-sigil-context-builder
description: Run the installed Arcanum sigil context-builder from its embedded canonical definition snapshot.
argument-hint: "<request-for-context-builder>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: context builder

<objective>
Run the installed Arcanum sigil context-builder using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/context-builder/SKILL.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/context-builder/README.md

````markdown
# Context Builder

Context Builder is a Transmutation sigil for creating a compact task-ready context pack from existing project evidence.

It selects only the source excerpts needed to execute a task, maps each excerpt to a concrete obligation, and rejects context that is merely interesting. The result is a smaller, more useful bundle for agents, reviewers, or implementation sessions.

## Problem It Solves

Large repositories often bury the relevant facts under too much background material. Agents can waste time reading whole files, miss the exact obligation, or carry unrelated context into the task.

Context Builder solves this by using link-first retrieval, selector-level evidence, obligation coverage, and noise limits.

## Use When

- a task needs a focused evidence pack before execution,
- requirements, architecture notes, code snippets, tests, and decisions are scattered,
- a later agent or reviewer should not reread the whole repository,
- the task has explicit obligations or completion criteria,
- context size must stay bounded.

## Do Not Use When

- the task is simple enough to execute directly,
- no source material exists,
- the user wants a broad codebase map rather than task context,
- the work requires autonomous orchestration rather than bounded synthesis,
- selected excerpts cannot be linked to concrete obligations.

## Output

The sigil produces a context pack with:

- target task,
- obligation matrix,
- selected excerpts,
- selectors or anchors,
- obligation coverage,
- excluded candidates,
- unresolved gaps,
- optional machine-readable index.

## Why This Is A Transmutation

Context Builder transforms scattered project material into a bounded, evidence-linked artifact. It requires judgment, but the output is a concrete context package rather than a long-running orchestration loop.
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/context-builder/SKILL.md

````markdown
---
name: context-builder
description: "Use when: building a compact, task-ready context pack from selector-level evidence and obligation-linked excerpts."
argument-hint: "<task-reference> [--mode lean|standard|deep] [--max-files <n>] [--strict] [--emit markdown|json|both] [--dry-run]"
tier: transmutations
domain: context-synthesis
version: 0.1.0
origin: generalized from recurring task-context retrieval practice
allowed-tools: Read, Write, Glob, Grep, Bash, AskQuestions
---

# Sigil: Context Builder

<objective>
Produce a minimal task-ready context bundle that maximizes relevance, preserves evidence selectors, and minimizes reading overhead.
</objective>

<logic-type>
Transmutation: bounded evidence selection and structured context synthesis.
</logic-type>

<flags>
- `--mode lean|standard|deep`: control excerpt budget. Default: `standard`.
- `--max-files <n>`: override the file count budget.
- `--strict`: require every selected item to map to an obligation. Default: on.
- `--emit markdown|json|both`: choose output format. Default: `markdown`.
- `--dry-run`: preview selected context without writing artifacts.
</flags>

<process>
1. Resolve the target task and its expected output.
2. Parse task obligations from the request, task file, requirements, checklist, acceptance criteria, or completion criteria.
3. Build an obligation matrix where each obligation has an ID, required evidence, and unresolved status.
4. Seed retrieval from explicit links and references first.
5. Extract selectors before inclusion:
   - markdown headings, anchors, tables, or bullet ranges,
   - code symbols, declarations, tests, endpoint contracts, or minimal snippet windows,
   - config keys, scripts, schemas, or command references.
6. Expand search only for uncovered obligations and scope searches to relevant folders or filenames.
7. Exclude any candidate that does not close at least one obligation.
8. Rank selected evidence by relevance, cost, and ambiguity.
9. Enforce budgets:
   - `lean`: up to 8 files and 140 excerpt lines,
   - `standard`: up to 14 files and 280 excerpt lines,
   - `deep`: up to 24 files and 520 excerpt lines.
10. Emit the context pack and optional index.
11. Return blockers for obligations that lack sufficient evidence.
</process>

<quality-bar>
A successful execution must:

- include only selector-level evidence,
- map every selected item to at least one obligation,
- keep the noise ratio low,
- separate evidence from inference,
- report uncovered obligations,
- avoid repository-wide context dumps,
- produce a compact artifact another agent can use immediately.
</quality-bar>

<anti-patterns>
Avoid:

- copying whole files when a selector would suffice,
- including background material because it is interesting,
- running broad unbounded searches,
- omitting why each item was selected,
- hiding unresolved obligations,
- exceeding the selected mode budget without explanation.
</anti-patterns>

<output-contract>
Return:

```markdown
## Context Pack Summary

- Task: <task-reference>
- Mode: lean | standard | deep
- Files selected: <count>
- Snippets selected: <count>
- Obligation coverage: <percent>
- Noise ratio: <value>
- Output markdown: <path or dry-run>
- Output index: <path or none>
- Blockers: <count>

### Included Context

- <path> - <why included> - <selectors> - <obligation refs>

### Excluded Candidates

- <path> - <why excluded>

### Next Actions

1. <action>
```
</output-contract>
````
