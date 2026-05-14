# Extraction Research Note: scope-interview

## Reusable Core

- Interview a vague idea or existing repository into a discovery baseline.
- Separate stated intent, observed evidence, and hypotheses.
- Ask focused questions only after a cheap evidence pass.
- Produce project-level discovery artifacts and a readiness verdict.

## Private Coupling Risk

- Source workflow assumes a specific document stack, taxonomy, and artifact names.
- Brownfield gates and generated outputs must be made repository-neutral.
- Research and experiment language should remain optional rather than mandatory.

## Neutral Rewrite Strategy

- Express the workflow as generic scope discovery for greenfield, brownfield, or mixed contexts.
- Use configurable output artifacts instead of fixed private templates.
- Keep evidence categories generic: observed, stated, hypothesized, decided, unresolved.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: rewrite
- Rationale: the discovery loop is broadly reusable, but the source artifact model must be replaced with neutral discovery package concepts.

## Minimum Safe Sigil

- A scope interview sigil that inspects existing materials, asks one focused question at a time, writes a discovery baseline, records decisions, and returns a readiness verdict.