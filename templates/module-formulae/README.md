# Module Formulae Template Pack

This pack provides a neutral, module-first documentation model that preserves DomainSpec structure and governance semantics without DomainSpec-specific wording.

## Goal

Use these templates when you need:

- concept-first design,
- evidence-linked contracts,
- explicit governance gates,
- deterministic handoffs from definition to design to execution planning.

## Included Templates

| Template | Purpose |
| --- | --- |
| module-spec.md | Canonical module contract with capabilities, concept index, and relationship map. |
| glossary-ontology.md | Plain-language and formal terminology contract for business and system language. |
| concept-model.md | Structural model for records, value types, and enumerations. |
| operations.md | Action contract for rules, calculations, transitions, and outcomes. |
| flows-policies.md | Multi-step flow orchestration and policy decision contracts. |
| interfaces.md | External and internal integration contract mapping. |
| research-brief.md | Evidence-first discovery and decision framing before design. |
| architecture-bundle.md | Required architecture view set with assumptions, risks, and decisions. |
| implementation-plan.md | Delivery slices and layer progression from design to execution. |
| observability.md | Signal derivation and alert contract tied to source artifacts. |
| execution-pack.md | Phased implementation planning, gates, and closure obligations. |
| bundle-profile.md | Composable profile selection for discovery, architecture, implementation, and full runs. |
| vocabulary-map.md | One-to-one translation from DomainSpec-centric terms to Module Formulae terms. |

## Usage Contract

1. Keep structure; only adapt naming and examples.
2. Keep evidence links and source references in every major table.
3. Keep deterministic gates for approvals, blockers, and closure.
4. Keep traceability from concept definitions to execution tasks.
5. Keep business and system terminology synchronized through the glossary.

## Integration Notes

- These templates are intended for local inventory-first usage.
- A consuming workflow can select a subset, but the full pack is the default for high-complexity work.
- The glossary template is the terminology authority for all generated artifacts.

## Composable Bundle Profiles

Use [bundle-profile.md](bundle-profile.md) to compose templates by intent:

- discovery profile,
- architecture profile,
- implementation profile,
- full profile.
