# Extraction Research Note: skill-decomposer

## Reusable Core

- Inspect a broad or tangled source and identify reusable capability candidates.
- Separate reusable behavior from source machinery, local vocabulary, and surrounding workflow context.
- Decide what to keep, rewrite, reject, defer, or hand off.
- Define a clear boundary for one candidate sigil before authoring begins.
- Produce a handoff package for `skill-transcriptor` when the candidate is coherent.

## Coupling Risk

- Extracting from too little context and losing important gates.
- Creating a sigil from an implementation detail rather than a reusable capability.
- Over-fragmenting one coherent skill into too many small sigils.
- Letting source-specific terms become public Arcanum vocabulary.

## Neutral Rewrite Strategy

- Build a source map before naming the target sigil.
- Score candidates for coherence, reuse value, coupling risk, and tier clarity.
- Ask a human decision only when candidate selection or boundaries are ambiguous.
- Do not create the final sigil until the boundary decision is explicit.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: create
- Rationale: decomposition coordinates ambiguity, boundary judgment, source-risk review, candidate scoring, and handoff into conversion.