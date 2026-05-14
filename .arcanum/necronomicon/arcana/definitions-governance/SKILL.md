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