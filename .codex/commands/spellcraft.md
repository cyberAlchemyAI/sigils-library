# Arcanum Sigil: spellcraft

<!-- arcanum:capability-id spellcraft -->
<!-- arcanum:capability-kind sigil -->
<!-- arcanum:capability-tier arcana -->
<!-- arcanum:command spellcraft -->

## Observer Envelope: Task Zero

Before doing domain work, establish the observer envelope for this Arcanum invocation.

- `run_id`: use an existing hook-provided run id when present; otherwise use `arcanum-spellcraft-<UTC timestamp>`.
- `capability.id`: `spellcraft`
- `capability.kind`: `sigil`
- `capability.tier`: `arcana`
- `capability.mode`: `command`
- `target_artifact`: this command file
- request summary: summarize the user request before execution.
- expected outputs: list intended artifacts before execution when known.

Closeout is mandatory but must not hide the primary result. At the end, report:

- `OBSERVATION`
- `LEDGER`
- `REFLECTION_TRIGGER`
- `RECOMMENDATION`
- `DEDUPE_KEY`

If deterministic hook or wrapper telemetry is unavailable, preserve the result and report the observability gap.


## Objective

Run the installed Arcanum sigil `spellcraft` using the canonical definition snapshot embedded below.

## Process

1. Use the embedded canonical README and SKILL snapshots as the execution contract.
2. Execute only this installed sigil unless the definition explicitly delegates or the user asks to route elsewhere.
3. Preserve the selected sigil's process, quality bar, anti-patterns, output contract, validation gates, gaps, and next route.
4. Return artifact used, command used, validation result, observability result, and next action.

## Guardrails

- Keep this command focused on `spellcraft`.
- Do not silently add, remove, or refresh capabilities.
- Do not treat generated observer telemetry as a substitute for the primary result.

## Canonical README Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/spellcraft/README.md

````markdown
# Spellcraft

Spellcraft is an Arcana sigil for designing, installing, validating, observing, and revising spells.

It helps users combine existing sigils into localized workflows without copying or mutating the sigils themselves. A spell defines orchestration: phases, shared state, gates, handoffs, failure policy, local customization, and observability.

Spellcraft also manages spell aliases. A spell keeps a stable canonical ID for filenames and automation, while users can invoke it through memorable aliases such as `Repository Codex`. The name `Necronomicon` is reserved for the persistent repository harness.

## Problem It Solves

Some work is best handled by multiple sigils together. Users should not have to remember the right sequence every time, and individual sigils should not grow extra responsibilities just to support a common workflow.

Spellcraft solves this by creating explicit spell contracts that compose sigils by reference.

## Use When

- several sigils should run together in a repeatable workflow,
- a repository needs a local spell under `.arcanum/spells/`,
- a user wants to adapt a library spell to local paths and policies,
- outputs from one sigil should become inputs to another,
- a spell needs validation, observability, or revision.

## Do Not Use When

- one sigil already handles the task,
- the composition is a one-off experiment,
- the workflow has no handoff artifacts or gates,
- the spell would copy sigil internals instead of referencing them,
- the user needs immediate execution rather than a reusable local workflow.

## Default Output

Repository-local spells should live at:

```text
.arcanum/spells/<spell-name>/README.md
```

Reusable library spells live in [spells](../../spells/).

## Alias Rules

- Canonical IDs are stable and use kebab-case.
- Aliases are human-facing names that resolve to canonical IDs.
- Alias lookup is case-insensitive.
- An alias must resolve to exactly one active spell.
- Local repositories may add local aliases without changing upstream spell contracts.
- Spell run reports should record both the alias used and the canonical ID.

## Why This Is Arcana

Spellcraft coordinates workflow design, local repository adaptation, sigil compatibility checks, gate design, observability, and lifecycle maintenance across multiple sigils.

````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/arcana/spellcraft/SKILL.md

````markdown
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
.arcanum/spells/<spell-name>/README.md
```

For reusable library spells, write to:

```text
spells/<spell-name>/README.md
```
</default-output>

<process>
1. Resolve mode, target repository, spell name, and whether the spell is local or reusable.
2. Resolve spell identity:
   - treat kebab-case spell folder names as canonical IDs,
   - search the library spell registry and local spell contracts for aliases,
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
6. If designing a reusable spell, initialize or preserve an experiment harness through `experiment-harness`:
   - create `development/VALIDATION-EXPERIMENT.md`, `VALIDATION.md`, fixtures, and runner scripts,
   - add low, medium, and complex examples when the spell has reusable modes or phases,
   - keep live Codex CLI execution explicit and bounded.
7. If installing a library spell, adapt only local paths, thresholds, interaction mode, aliases, and gate strictness. Do not rewrite upstream sigil contracts.
8. If validating, check:
   - referenced sigils exist or are declared local/external,
   - aliases resolve to exactly one canonical spell,
   - every phase has input, output, gate, and failure policy,
   - handoff artifacts are named,
   - spell does not copy full sigil instructions,
   - experiment harness evidence exists when the spell is expected to be reused,
   - observability is defined when the spell is expected to be reused.
9. If observing, record spell-level telemetry using the repository observability package when available.
10. If reflecting, review accumulated spell telemetry and propose targeted changes while preserving the spell's core purpose.
11. Return the spell file path, validation state, canonical ID, alias used, and next recommended action.
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
- define or preserve an experiment harness for reusable spells,
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

````
