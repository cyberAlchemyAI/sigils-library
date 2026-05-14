---
name: arcanum-sigil-implementation-layering
description: Run the installed Arcanum sigil implementation-layering from its embedded canonical definition snapshot.
argument-hint: "<request-for-implementation-layering>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum sigil: implementation layering

<objective>
Run the installed Arcanum sigil implementation-layering using the canonical definition snapshot embedded in this slash command.
</objective>

<context>
Arcanum runtime support is installed at .arcanum/ in this repository. Necronomicon is the Ontology Harness alias, not a generated runtime registry folder. The canonical source reference for this command is https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/implementation-layering/SKILL.md.
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

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/implementation-layering/README.md

````markdown
# Implementation Layering

Implementation Layering is a Transmutation sigil for turning an implementation goal into a staged build model.

It helps an agent or team avoid stuffing every concern into the first version. Instead, it defines Layer 0 as the smallest useful proof, then describes later layers that add repeatability, reliability, governance, scale, or packaging only when the evidence justifies them.

## Problem It Solves

Implementation plans often blur proof, hardening, pilot readiness, and productization into one oversized first step. That makes progress harder to verify and makes it unclear which decision the next work unit is supposed to unlock.

This sigil solves that by forcing each layer to answer a decision question:

```text
After this layer, we know whether ...
```

The result is an implementation path where scope grows because evidence unlocked the next decision, not because every desirable feature was bundled into the beginning.

## Use When

- a feature, workflow, or system improvement needs a practical build sequence,
- the first version is at risk of becoming too large,
- the team needs to separate proof, hardening, and scale concerns,
- there are known constraints around time, reliability, compliance, migration, or pilot readiness,
- reviewers need to understand why some work is included now and some is deferred.

## Do Not Use When

- the task is already a tiny deterministic edit,
- the work has no meaningful implementation sequence,
- the user needs a final architecture decision rather than staged execution,
- the main uncertainty is factual discovery rather than implementation scope.

## Inputs

Useful inputs include requirement notes, specs, issues, roadmap items, existing implementation files, tests, constraints, and stakeholder goals.

The sigil can still operate with partial context, but it should mark unresolved assumptions as open decisions rather than silently treating them as facts.

## Output

The primary output is an implementation layering artifact with:

- a Layer 0 minimum working unit,
- 3 to 5 decision-oriented layers,
- included and deferred scope for each layer,
- exit evidence and promotion decisions,
- non-regression guardrails,
- a recommended next layer.

## Why This Is A Transmutation

The sigil applies structured judgment to ambiguous planning material. It does not merely validate a fixed structure, and it does not coordinate autonomous multi-agent inquiry. Its job is bounded synthesis: transform rough implementation intent into a reviewable staged plan.
````

## Canonical SKILL Snapshot

Canonical source: https://github.com/cyberAlchemyAI/arcanum/blob/main/transmutations/implementation-layering/SKILL.md

````markdown
---
name: implementation-layering
description: "Use when: creating or evolving a project-agnostic implementation layering model for a feature, capability, product workflow, research workflow, infrastructure change, or system improvement. Builds layers from minimum working unit proof to progressive hardening using value/cost layer-boundary heuristics."
argument-hint: "<target-name> [--path <output-path>] [--update]"
tier: transmutations
domain: implementation-planning
version: 0.1.0
origin: generalized from recurring implementation-planning practice
allowed-tools: Read, Write, Glob, Grep
---

<objective>
Create or evolve a project-agnostic implementation layering model where Layer 0 is the smallest minimum working unit that proves the concept, and each later layer deliberately improves the previous layer without invalidating earlier guarantees.
</objective>

<logic-type>
Transmutation: bounded synthesis from target context into a minimum-proof implementation layering model.
</logic-type>

<applicability>
Use this skill for any project that needs to sequence implementation scope before building, including:

- product features,
- internal tools,
- research workflows,
- infrastructure changes,
- process automation,
- data pipelines,
- agentic or human-in-the-loop systems.
</applicability>

<inputs>
Expected inputs, if available:

- target name, capability name, feature name, or workflow name,
- existing requirements, specs, issues, PRDs, ADRs, README sections, or roadmap notes,
- existing implementation files or tests,
- known constraints such as budget, timeline, team size, safety, compliance, reliability, or pilot needs.
</inputs>

<default-output>
If the user does not provide `--path`, write the artifact to the first suitable location:

1. `docs/{target-name}/implementation-layering.md` when a target-specific docs folder exists,
2. `docs/implementation-layering.md` when project-level docs exist,
3. `implementation-layering.md` at the project root when no docs folder exists.
</default-output>

<template>
Use `templates/implementation-layering.md` as the starting point.
</template>

<process>
1. Identify the target and output path. If the target or output path is ambiguous, infer a conservative default from existing project docs and name it in the result.
2. Gather only relevant context: requirements, specs, user stories, existing architecture notes, README sections, issues, tests, and implementation files that define the target behavior.
3. Define Layer 0 as the minimum working unit POC: the smallest end-to-end slice that proves the target concept can work.
4. For every layer, write the layer decision question using this form: "After this layer, we know whether ...".
5. Apply the layer-boundary heuristic:
   - `Layer value = decision unlocked + user-visible outcome + risk reduced`
   - `Layer cost = implementation time + verification time + coordination burden`
   - Stop a layer when the next unit of work adds less value-per-cost to the current decision than starting the next decision layer.
6. For each layer, document:
   - decision question,
   - minimum working unit,
   - included scope,
   - explicitly deferred scope,
   - user-visible or operator-visible outcome,
   - risk reduced,
   - main cost drivers,
   - exit evidence,
   - promotion decision.
7. Make each later layer build on the previous layer by adding one bounded improvement theme, such as repeatability, reliability, policy depth, observability, degraded-mode behavior, scale, or packaging.
8. Preserve non-regression: state which guarantees from earlier layers must remain true.
9. Prefer 3 to 5 layers. Add more only when each layer unlocks a distinct decision.
10. Summarize the recommended next implementation layer and the most important deferred scope.
</process>

<quality-bar>
A good implementation layering artifact:

- lets the team start with the smallest useful proof,
- avoids mixing pilot, scale, fallback, and polish into the POC,
- makes deferrals explicit rather than accidental,
- makes promotion decisions evidence-based,
- balances working length against value delivered,
- can be understood by both implementation agents and human reviewers.
</quality-bar>

<anti-patterns>
Avoid:

- calling a layer "POC" while including production-scale concerns,
- creating layers that are just task buckets without decision questions,
- advancing to scale before repeatability is proven,
- making layer boundaries by component ownership alone,
- deferring verification until the final layer,
- adding a layer when it does not unlock a new decision.
</anti-patterns>

<output-contract>
Return:

```markdown
## Implementation Layering Result

- Target: <target-name>
- Artifact: <path>
- Mode: created | updated
- Layer count: <n>
- Recommended next layer: <L0/L1/...>
- Boundary heuristic: applied
- Key decision unlocked by L0: <decision>
- Major deferred scope: <summary>
- Validation: <checks performed or not run>
```

</output-contract>

````
