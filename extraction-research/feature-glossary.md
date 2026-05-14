# Extraction Research Note: feature-glossary

## Reusable Core

- Turn feature-specific vocabulary into a concise glossary.
- Put plain-language terms before formal concepts.
- Link definitions back to source evidence.
- Detect duplicate, missing, stale, or conflicting terms.

## Private Coupling Risk

- Source workflow assumes a specific concept registry shape and private meta-type system.
- It also assumes fixed feature document paths and source anchors.

## Neutral Rewrite Strategy

- Treat any requirements, design, interface, UI, or operation document as valid source material.
- Define terms using evidence links and configurable source anchors.
- Keep formal concept fields optional and schema-neutral.

## Proposed Tier

- transmutations

## Extraction Decision

- Decision: rewrite
- Rationale: glossary construction is reusable as a bounded synthesis artifact when the source schema is neutralized.

## Minimum Safe Sigil

- A feature glossary builder that extracts vocabulary from selected source docs, separates plain-language and formal terms, links definitions to evidence, and reports unresolved vocabulary gaps.