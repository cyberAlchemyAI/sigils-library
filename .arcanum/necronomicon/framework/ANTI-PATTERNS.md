# Anti-Patterns

Anti-Patterns define how a sigil should not be used and what kinds of execution should be rejected.

They are not a list of minor preferences. They are guardrails against predictable misuse: wrong trigger conditions, overreach, under-specified execution, unsafe shortcuts, and outputs that look complete while violating the sigil's purpose.

## Problem It Solves

A sigil can fail even when every process step was followed. The wrong sigil may be selected, the task may be too broad or too small, or the agent may produce a confident answer outside the sigil's authority.

Anti-Patterns prevent that by making known failure modes explicit before execution begins.

## What Anti-Patterns Should Do

- define when not to use the sigil,
- identify common misuse cases,
- name outputs that should be rejected,
- protect the sigil's tier boundary,
- prevent silent expansion of authority or scope.

## Tier-Specific Shape

Formulae Anti-Patterns should block interpretation-heavy work, hidden repair, ambiguous inputs, and non-repeatable judgment.

Transmutations Anti-Patterns should block unsupported invention, source drift, over-compression, unmarked assumptions, and decisions that need a human gate.

Arcana Anti-Patterns should block unnecessary orchestration, action before synthesis, duplicated agent scopes, missing preservation, and bypassed human validation.

## Authoring Pattern

Write each anti-pattern as a concrete failure mode:

```text
Avoid <misuse> because <reason or risk>.
```

Prefer specific warnings:

- Avoid using this sigil for single-file bugs because its coordination overhead exceeds the value of the investigation.
- Avoid silently filling missing required inputs because the output will appear more certain than the evidence allows.
- Avoid treating inferred categories as authoritative unless the output labels them as decisions or assumptions.

Avoid generic warnings:

- Avoid bad outputs.
- Avoid being unclear.
- Do not make mistakes.

## Minimum Contents

Every sigil Anti-Patterns section should answer:

- What task shape should use a different sigil?
- What inputs are too weak or ambiguous for safe execution?
- What shortcuts would make the result untrustworthy?
- What scope expansion must be blocked?
- What output would look complete but still be wrong?

## Example Anti-Patterns

For a Formulae sigil:

- Avoid accepting partial inputs unless the output contract defines a partial-result mode.
- Avoid interpreting user intent when the sigil is only authorized to validate structure.
- Avoid changing source material while reporting validation status.

For a Transmutation sigil:

- Avoid inventing missing domain facts to make the synthesis feel complete.
- Avoid collapsing disagreements into a single summary without preserving the disagreement.
- Avoid expanding the artifact beyond the requested decision boundary.

For an Arcana sigil:

- Avoid launching multiple investigators before the central question is clear.
- Avoid assigning overlapping roles that answer the same question with different labels.
- Avoid recommending implementation before evidence has been synthesized and gated.

## Relationship To Quality Bar

[Quality Bar](QUALITY-BAR.md) defines what successful execution must satisfy. Anti-Patterns define the failure modes that should block or redirect execution.

Use both together: if the Quality Bar is the acceptance threshold, Anti-Patterns are the warning signs that the sigil is being misapplied.