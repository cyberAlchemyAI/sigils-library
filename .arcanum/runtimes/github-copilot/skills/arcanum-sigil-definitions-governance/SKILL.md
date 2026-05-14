---
name: arcanum-sigil-definitions-governance
description: Run the installed Arcanum sigil definitions-governance from its embedded canonical definition snapshot.
argument-hint: "<request-for-definitions-governance>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: definitions governance

<objective>
Run the installed Arcanum sigil definitions-governance using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/definitions-governance/SKILL.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/definitions-governance/README.md

````markdown
# Definitions Governance

Definitions Governance is an Arcana sigil for keeping critical terminology authoritative, interpretable, indexed, and traceable across a repository.

It maintains one canonical definition source, keeps lookup artifacts synchronized, separates normative wording from explanatory intuition, and audits downstream drift where terms are reused.

## Problem It Solves

Projects drift when critical terms are redefined in papers, plans, specs, implementation notes, or presentations. A term may look familiar while its meaning silently changes across artifacts.

Definitions Governance prevents that by treating definitions as a governed authority layer with traceable downstream consumers.

## Use When

- a gate-critical or high-impact term is added or revised,
- formulas, notation, or formal constructs need stable interpretation,
- downstream documents reference canonical terms,
- narrative summaries risk redefining normative semantics,
- definition drift needs to be audited.

## Do Not Use When

- the term is local to one feature glossary,
- the wording is informal and non-critical,
- there is no canonical definitions source,
- the task is only to rename a label,
- the repository is not ready to own definition governance.

## Authority Model

The consuming repository should identify:

- canonical definitions source,
- lookup or index layer,
- narrative consumers,
- protocol or process consumers,
- validation checks,
- drift remediation targets.

## Why This Is Arcana

Definitions Governance coordinates authority, interpretation, indexing, drift detection, and remediation routing across many artifacts. It governs semantic consistency over time.
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/definitions-governance/SKILL.md

````markdown
---
name: definitions-governance
description: "Use when: maintaining canonical definitions, synchronized indexes, explanatory intuition, and downstream drift checks for critical terms."
argument-hint: "[--add <id>] [--update <id>] [--sync] [--audit] [--config <path>]"
tier: arcana
domain: semantic-governance
version: 0.1.0
origin: generalized from recurring canonical definitions maintenance practice
allowed-tools: Read, Write, Bash, Glob, Grep
---

# Sigil: Definitions Governance

<objective>
Keep critical definitions authoritative, interpretable, discoverable, and traceable across downstream artifacts.
</objective>

<logic-type>
Arcana: semantic authority governance with drift detection and remediation routing.
</logic-type>

<process>
1. Resolve the repository's authority model:
   - canonical definitions source,
   - lookup or index layer,
   - narrative consumers,
   - operational consumers,
   - validation checks.
2. Read the canonical definitions source and index before making changes.
3. Add or update critical terms with stable IDs when the repository uses IDs.
4. For formal or mathematical constructs, keep the minimum interpretation package together:
   - formal expression,
   - variable or notation meaning,
   - operational interpretation,
   - plain-language intuition.
5. Keep explanatory intuition colocated with the definition and clearly non-normative.
6. Sync lookup or index artifacts so definitions are discoverable.
7. Audit downstream drift:
   - conflicting wording,
   - stale anchors,
   - undefined critical terms,
   - narrative text that redefines authority,
   - missing references.
8. Emit remediation items with target files and recommended action.
9. Run available structure, link, or schema validation checks.
</process>

<authority-rule>
Only the configured canonical definitions source may define normative semantics. Narrative, summary, protocol, planning, or presentation artifacts may explain or reference definitions, but should not redefine them.
</authority-rule>

<quality-bar>
A successful execution must:

- keep critical terms in the canonical source,
- preserve stable IDs when used,
- colocate plain-language intuition with formal definitions,
- prevent intuition from contradicting normative wording,
- keep indexes synchronized,
- identify downstream drift with exact remediation targets,
- validate structure where checks exist.
</quality-bar>

<anti-patterns>
Avoid:

- letting narrative artifacts become hidden definition authorities,
- adding formulas without symbol meaning and plain-language intent,
- creating detached intuition that can drift away from the definition,
- changing stable IDs casually,
- syncing indexes without auditing downstream consumers,
- treating local glossary terms as global canonical definitions without review.
</anti-patterns>

<output-contract>
Return:

```markdown
## Definitions Governance Summary

- Definitions updated: <ids or none>
- Index synced: yes | no | not applicable
- Drift found: yes | no
- Undefined critical terms: <count>
- Conflicting consumers: <count>
- Validation: pass | fail | not run
- Follow-ups: <ordered remediation list>
```
</output-contract>
````
