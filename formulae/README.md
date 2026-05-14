# Formulae - Operational Sigils

Formulae are deterministic sigils: tightly bounded procedures whose success depends on following explicit rules against explicit inputs.

Formulae should feel closer to a validator, formatter, adapter, converter, or mechanical checklist than to an open-ended reasoning partner. They may be executed by an LLM-enabled agent, but the agent's role is to apply rules faithfully rather than invent missing semantics.

## Epistemic Contract

- Primary logic: rule-based execution.
- State model: stateless or explicitly scoped state.
- Input tolerance: low; missing inputs should block, default, or fail predictably.
- Output shape: fixed, inspectable, and repeatable.
- Success measure: reliability, determinism, and auditability.

## Use Formulae For

- validating a document, schema, contract, link set, or policy gate,
- converting one known structure into another known structure,
- enforcing formatting, naming, routing, or packaging rules,
- calling APIs or tools where the operation has a fixed result shape,
- producing pass/fail reports from objective criteria.

## Avoid Formulae When

- the task requires synthesizing ambiguous meaning,
- the agent must decide what the categories themselves should be,
- the result depends on taste, interpretation, negotiation, or trade-off framing,
- the task must coordinate multiple independent agents or recursive decision loops.

## Quality Bar

A Formulae sigil is ready when:

- its trigger conditions are narrow and unambiguous,
- its process can be followed without inventing hidden steps,
- all required inputs and failure modes are named,
- its output contract is stable enough for another agent or script to consume,
- its anti-patterns prevent accidental use for interpretive work.

## Starter Example Pattern

No concrete Formulae sigil has been copied into this library yet. A good first candidate would be a deterministic markdown link validator, schema conformance checker, or registry synchronizer that always returns the same result for the same file state.

## Relationship To Other Tiers

- Formulae can serve Transmutations by validating the artifacts they produce.
- Formulae can serve Arcana by enforcing gates before or after autonomous orchestration.
- Formulae should not hide probabilistic judgment behind deterministic-sounding language.
