# Extraction Research Note: definitions-governance

## Reusable Core

- Maintain one canonical definitions source.
- Keep an index or lookup layer synchronized.
- Distinguish normative definitions from explanatory intuition.
- Audit downstream drift in documents that reference the definitions.

## Private Coupling Risk

- Source workflow assumes fixed IDs, fixed research artifacts, and a specific canonical location.
- Mathematical definition rules are useful but must not rely on private naming conventions.

## Neutral Rewrite Strategy

- Use configurable definition IDs and paths.
- Require each critical term to have stable ID, formal wording when needed, plain-language intuition, and downstream references.
- Treat narrative artifacts as consumers rather than authority unless configured otherwise.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: rewrite
- Rationale: definition authority and drift governance are broadly reusable, but the artifact map must be supplied by the consuming repository.

## Minimum Safe Sigil

- A definitions governance sigil that updates canonical terms, syncs a lookup index, audits downstream drift, and returns remediation actions.