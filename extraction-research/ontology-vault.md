# Extraction Research Note: ontology-vault

## Reusable Core

- Maintain a governed knowledge vault where documents have explicit roles, maturity, confidence, evidence links, and relationship rules.
- Distill raw session records into durable claims, decisions, contradictions, open questions, and promoted candidates.
- Treat premises as falsifiable working bets that may be promoted, revised, or demoted as evidence accumulates.
- Separate evidence confidence from commitment confidence so weak evidence and weak strategic commitment do not collapse into one vague confidence score.
- Keep ontology conventions explicit: roles, axes, statuses, tags, edge types, promotion rules, and migration impact.
- Preserve delegated evidence before synthesis. Raw research and synthesis findings should be distinct, linked artifacts.
- Use a domain-knowledge inflection heuristic: when domain knowledge is low, favor discovery and distillation; when knowledge crosses the inflection point, heavier ontology investment and promotion gates become justified.

## Private Coupling Risk

- Source-local role names, labels, dispatch terms, folder names, and workflow mechanics must not become canonical Arcanum vocabulary.
- The pattern must work for human research, agent research, audits, tests, session logs, and external sources, not only for one subagent system.
- The sigil should not force every repository into a full ontology program when a small inventory is enough.

## Neutral Rewrite Strategy

- Use generic roles such as `delegated-research`, `synthesis-findings`, `premise`, `constitution`, `discovery`, `session`, and `audit`.
- Use generic confidence dimensions: `evidence confidence` and `commitment confidence`.
- Let repositories alias their existing local labels to the generic dimensions during mapping.
- Treat local sessions as provenance inputs, not automatic authority.
- Route consequential ontology changes through explicit convention-change and promotion gates.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: rewrite
- Rationale: the vault pattern is reusable, but its source vocabulary and project-specific dispatch mechanics must be translated into neutral ontology governance.

## Minimum Safe Sigil

- An `ontology-vault` sigil that maps ontology structure, distills sessions, reviews premises, promotes or demotes confidence, proposes convention changes, validates links and roles, and preserves delegated evidence traceability.
