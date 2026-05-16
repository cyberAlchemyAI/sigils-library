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