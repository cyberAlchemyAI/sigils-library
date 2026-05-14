# Extraction Research Note: residuality-spec

## Reusable Core

- Help users define or revise specifications by asking what should remain true when the system is stressed, degraded, overloaded, partially failing, or surprised.
- Identify stressors across technical, social, environmental, organizational, operational, and misuse dimensions.
- Define desired residue: what must survive, what may degrade, what may stop, and what must be communicated.
- Convert resilience reasoning into concrete specification material: invariants, degradation behavior, observability signals, verification ideas, and decisions.
- Identify attractors: recurring vulnerability clusters revealed by stressor analysis.

## Private Coupling Risk

- The sigil should not depend on any one architecture methodology, documentation stack, or domain-specific taxonomy.
- It must avoid turning a theory-inspired workflow into rigid ceremony.
- It should not pretend the whole system can be exhaustively mapped or all failures can be predicted.

## Neutral Rewrite Strategy

- Treat Residuality-inspired concepts as practical specification prompts.
- Keep the workflow repository-neutral and artifact-flexible.
- Make the output useful whether the user has a formal spec, a rough product idea, or an existing codebase.
- Position architecture hardening as downstream from spec decisions, not the only output.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: rewrite
- Rationale: stressor and residue analysis is broadly useful for resilient specification, but it needs a practical, repository-neutral execution contract.

## Minimum Safe Sigil

- A `residuality-spec` sigil that guides stressor discovery, residue decisions, degradation spec writing, attractor identification, and concrete spec patch planning.