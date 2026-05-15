---
module: {module-name}
version: current
status: draft
updatedAt: {date}
docType: bundle-profile
---

# Composable Bundle Profile: Module Formulae

Use this template to select and compose Module Formulae artifacts by workflow mode.

## Bundle Profiles

| Profile ID | Use When | Required Templates | Optional Templates |
| --- | --- | --- | --- |
| discovery | Context is unclear and needs evidence-first clarification. | research-brief.md, module-spec.md, glossary-ontology.md | concept-model.md |
| architecture | Scope is approved and structural design is required. | module-spec.md, glossary-ontology.md, concept-model.md, architecture-bundle.md, interfaces.md, flows-policies.md | observability.md |
| implementation | Architecture is approved and execution planning is required. | module-spec.md, architecture-bundle.md, implementation-plan.md, execution-pack.md | observability.md |
| full | End-to-end definition, design, and planning in one governed run. | module-spec.md, glossary-ontology.md, concept-model.md, operations.md, flows-policies.md, interfaces.md, architecture-bundle.md, implementation-plan.md, execution-pack.md, observability.md | research-brief.md |

## Mode To Profile Mapping

| Invoke Mode | Recommended Profile | Rationale |
| --- | --- | --- |
| define | discovery | Clarifies scope and establishes terminology before design. |
| design | architecture | Produces required structural and process views. |
| plan | implementation | Produces delivery slices and execution gates. |
| full | full | Runs all contracts with stage gates and handoffs. |
| validate | profile-specific | Validates selected profile outputs against gates. |

## Selection Rules

1. If context confidence is low, start with discovery profile.
2. If spec is approved, start with architecture profile.
3. If architecture is approved, start with implementation profile.
4. If user requests one-pass workflow, use full profile.

## Output Expectations

| Profile | Required Outputs |
| --- | --- |
| discovery | research brief, module spec, glossary baseline |
| architecture | design views, assumptions, risk and decision records |
| implementation | implementation plan and execution pack skeleton |
| full | complete contract set and handoff-ready artifacts |

## Governance Notes

- Profiles do not bypass approval gates.
- Template selection must be recorded in local inventory.
- Profile changes mid-run require an explicit decision snapshot.
