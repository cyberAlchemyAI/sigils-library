---
name: arcanum-sigil-feature-glossary
description: Run the installed Arcanum sigil feature-glossary from its embedded canonical definition snapshot.
argument-hint: "<request-for-feature-glossary>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: feature glossary

<objective>
Run the installed Arcanum sigil feature-glossary using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/feature-glossary/SKILL.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/feature-glossary/README.md

````markdown
# Feature Glossary

Feature Glossary is a Transmutation sigil for creating or updating a concise vocabulary layer for a feature, workflow, product area, or bounded project scope.

It turns scattered terminology into a reviewable glossary that starts with plain-language terms and then lists formal concepts when the source material supports them.

## Problem It Solves

Teams often reuse words like baseline, gate, variant, account, session, policy, or revision without defining what they mean in the current feature. Formal concepts may exist too, but readers need the everyday vocabulary first.

Feature Glossary gives readers a stable language layer while preserving links back to authoritative source material.

## Use When

- a feature or workflow has recurring terms that need shared meaning,
- source docs contain concept tables, requirements, UI terms, states, operations, or policies,
- onboarding readers need plain-language definitions,
- duplicate or conflicting terms are creating ambiguity,
- formal concept definitions should be summarized without becoming the authority source.

## Do Not Use When

- the source material is too unstable to define terms,
- new behavior needs to be invented inside the glossary,
- the glossary would replace the authoritative source document,
- the task requires global definitions governance instead,
- there are no recurring terms to clarify.

## Output

The glossary should include:

- feature language terms,
- formal concepts when present,
- source links,
- related terms,
- unresolved terms,
- duplicate or conflict notes.

## Why This Is A Transmutation

Feature Glossary transforms scattered vocabulary into a bounded, evidence-linked artifact. It requires interpretation, but it does not coordinate a long-running governance loop.
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/feature-glossary/SKILL.md

````markdown
---
name: feature-glossary
description: "Use when: creating or updating a concise glossary for a feature, workflow, product area, or bounded project scope from source evidence."
argument-hint: "<scope> [--update] [--output <path>]"
tier: transmutations
domain: vocabulary-synthesis
version: 0.1.0
origin: generalized from recurring feature vocabulary distillation practice
allowed-tools: Read, Write, Glob, Grep
---

# Sigil: Feature Glossary

<objective>
Create or update a concise human-readable glossary that explains plain-language terms first and formal concepts second, while linking each definition to source evidence.
</objective>

<logic-type>
Transmutation: vocabulary extraction, synthesis, and evidence-linked explanation.
</logic-type>

<process>
1. Resolve the target scope and output path.
2. Read relevant source material such as requirements, design docs, UI docs, state docs, operation docs, interface docs, tests, decisions, and existing glossary files.
3. Extract candidate terms from:
   - repeated words with local meaning,
   - formal concept tables or schemas,
   - UI labels and workflow states,
   - policies and constraints,
   - domain-specific nouns and verbs.
4. Separate candidates into:
   - plain-language feature terms,
   - formal concepts,
   - cross-scope terms,
   - unresolved terms.
5. Write plain-language definitions that teach the term in this scope.
6. Write formal concept rows only when source evidence supports them.
7. Link each definition to its source evidence.
8. Do not introduce new behavior in the glossary; if behavior is missing, report a source-doc gap.
9. Detect duplicate terms, conflicting definitions, missing sources, and stale anchors.
10. Summarize glossary coverage and unresolved terms.
</process>

<quality-bar>
A successful execution must:

- define important local terms before formal concepts,
- keep definitions explanatory and non-normative,
- link definitions to source evidence,
- avoid inventing behavior,
- identify duplicate or conflicting terms,
- report unresolved vocabulary gaps,
- keep the glossary concise enough to read.
</quality-bar>

<anti-patterns>
Avoid:

- turning the glossary into the authority source for behavior,
- copying source tables without explanation,
- defining every common word regardless of relevance,
- hiding missing source decisions behind vague definitions,
- mixing global definitions governance into a feature glossary,
- leaving terms without evidence links.
</anti-patterns>

<output-contract>
Return:

```markdown
## Feature Glossary Result

- Scope: <scope>
- Output: <path>
- Plain-language terms: <count>
- Formal concepts: <count>
- Cross-scope terms: <count>
- Unresolved terms: <count>
- Validation: <checks performed>
- Follow-up: <source gaps or none>
```
</output-contract>
````
