# Extraction Research Note: skill-transcriptor

## Reusable Core

- Convert a complete, coherent skill, prompt, command, or workflow into an Arcanum sigil package.
- Identify source purpose, triggers, modes, inputs, outputs, gates, tools, validation, and observability expectations.
- Classify the target tier as Formulae, Transmutations, or Arcana.
- Rewrite source-specific vocabulary into neutral Arcanum language.
- Produce a package plan for `README.md`, `SKILL.md`, templates, registry updates, and validation gates.
- Stop direct conversion when the source contains multiple separable capabilities.

## Coupling Risk

- Copying source project names, private routing terms, local command names, or incompatible frontmatter.
- Preserving implementation details that are not part of the reusable behavior.
- Converting a broad source file as one sigil when it should first be decomposed.
- Treating source tool permissions as automatically valid in Arcanum.

## Neutral Rewrite Strategy

- Preserve behavior, gates, and output contracts while translating identity, vocabulary, and artifact layout.
- Use Arcanum tiers and sigil entry requirements as the target package shape.
- Preserve source names only as local examples in conversion notes, not as canonical public terms.
- Route tangled or multi-capability sources to `skill-decomposer` before package authoring.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: create
- Rationale: direct conversion needs judgment, tier classification, coupling review, package planning, validation, and observability. That coordination belongs in Arcana.
