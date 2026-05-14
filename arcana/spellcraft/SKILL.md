---
name: spellcraft
description: "Use when: designing, installing, validating, observing, or revising a spell that composes multiple sigils into a localized workflow."
argument-hint: "<design|install|run-plan|validate|observe|reflect> <spell-name-or-goal> [--repo <path>] [--from <library-spell>] [--output <path>]"
tier: arcana
domain: spell-composition
version: 0.1.0
origin: created to compose sigils into reusable local workflows without bloating individual sigil contracts
allowed-tools: Read, Write, Glob, Grep, Bash, AskQuestions, Task
---

# Sigil: Spellcraft

<objective>
Create and maintain spell compositions that reference multiple sigils, define coherent execution phases, and preserve shared state, gates, handoffs, and observability.
</objective>

<logic-type>
Arcana: cross-sigil workflow composition, local adaptation, validation, and lifecycle governance.
</logic-type>

<modes>
- `design`: create a new spell from a user goal and available sigils.
- `install`: adapt a library spell into a repository-local spell file.
- `run-plan`: produce an execution plan for a spell without running all phases.
- `validate`: check spell structure, references, gates, and handoffs.
- `observe`: record spell-level telemetry after execution.
- `reflect`: improve a spell from accumulated telemetry or user feedback.
</modes>

<default-output>
For repository-local spells, write to:

```text
.arcanum/spells/<spell-name>.md
```

For reusable library spells, write to:

```text
spells/<spell-name>.md
```
</default-output>

<process>
1. Resolve mode, target repository, spell name, and whether the spell is local or reusable.
2. Resolve spell identity:
   - treat kebab-case filenames as canonical IDs,
   - search the library spell registry and local spell files for aliases,
   - match aliases case-insensitively,
   - return `BLOCK` if an alias maps to more than one spell,
   - record both alias used and canonical spell ID in reports.
3. Detect available sigils from the library and any local sigil folders.
4. Inspect existing repository harnesses when relevant:
   - `.arcanum/inventory/`,
   - `.arcanum/observability/`,
   - `.arcanum/spells/`,
   - architecture packages,
   - context packs,
   - decision records,
   - local docs or wiki folders.
5. If designing a spell, identify:
   - workflow goal,
   - trigger conditions,
   - required sigils,
   - optional sigils,
   - prerequisites,
   - shared state,
   - handoff artifacts,
   - gates,
   - failure policy,
   - observability needs.
6. If installing a library spell, adapt only local paths, thresholds, interaction mode, aliases, and gate strictness. Do not rewrite upstream sigil contracts.
7. If validating, check:
   - referenced sigils exist or are declared local/external,
   - aliases resolve to exactly one canonical spell,
   - every phase has input, output, gate, and failure policy,
   - handoff artifacts are named,
   - spell does not copy full sigil instructions,
   - observability is defined when the spell is expected to be reused.
8. If observing, record spell-level telemetry using the repository observability package when available.
9. If reflecting, review accumulated spell telemetry and propose targeted changes while preserving the spell's core purpose.
10. Return the spell file path, validation state, canonical ID, alias used, and next recommended action.
</process>

<spell-contract>
Every spell must define:

- canonical ID,
- aliases, when any,
- purpose,
- trigger conditions,
- required sigils,
- optional sigils,
- prerequisites,
- shared state,
- execution phases,
- handoff artifacts,
- gates,
- failure policy,
- local customization,
- observability,
- output contract.
</spell-contract>

<authority-rule>
A spell may compose sigils, but it must not redefine the internal contract of a referenced sigil. If a sigil contract needs to change, route that work through the sigil's own maintenance workflow.
</authority-rule>

<observability>
When `.arcanum/observability/` exists, record:

- spell name,
- mode,
- phases attempted,
- sigils invoked,
- gates passed,
- gates blocked,
- handoff failures,
- outputs produced,
- validation result,
- user corrections,
- recommended spell updates.
</observability>

<quality-bar>
A successful execution must:

- keep spells distinct from sigil tiers,
- resolve aliases to stable canonical IDs,
- reference sigils rather than copying their process bodies,
- define phase inputs, outputs, gates, and failure policy,
- preserve local customization without forking upstream sigils,
- validate referenced sigils and handoff artifacts,
- define observability for reusable spells,
- return a clear next action.
</quality-bar>

<anti-patterns>
Avoid:

- treating spells as a fourth sigil tier,
- allowing one alias to resolve to multiple active spells,
- hiding multiple unrelated workflows in one spell,
- copying full sigil instructions into a spell file,
- installing a library spell without adapting local paths,
- running later phases after an earlier gate blocks,
- letting a spell mutate a sigil contract without explicit maintenance work,
- omitting failure policy for handoff gaps.
</anti-patterns>

<output-contract>
Return:

```markdown
## Spellcraft Result

- Mode: design | install | run-plan | validate | observe | reflect
- Spell: <name>
- Canonical ID: <spell-id>
- Alias used: <alias or none>
- Scope: library | local
- Spell file: <path>
- Sigils referenced: <list>
- Phases: <count>
- Validation: pass | block | flag | not run
- Observability: configured | unavailable | not needed
- Next action: <action>
```
</output-contract>