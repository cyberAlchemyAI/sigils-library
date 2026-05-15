---
module: {module-name}
version: current
status: draft
updatedAt: {date}
docType: implementation-plan
---

# Implementation Plan: {Module Name}

Use this template to turn approved architecture into delivery slices and execution-ready sequencing.

## Objective

Describe what this implementation plan must deliver.

## Inputs

- [module-spec.md](module-spec.md)
- [architecture-bundle.md](architecture-bundle.md)
- [glossary-ontology.md](glossary-ontology.md)

## Delivery Slices

| Slice | Goal | Dependencies | Exit Condition |
| --- | --- | --- | --- |
| S1 | {goal} | {dependencies} | {evidence of completion} |
| S2 | {goal} | {dependencies} | {evidence of completion} |

## Layer Progression

| Layer | Purpose | Includes | Defers |
| --- | --- | --- | --- |
| L0 | Minimum working unit | {core contracts and one end-to-end path} | {advanced governance or scale concerns} |
| L1 | Deterministic hardening | {retry, consistency, validations} | {degraded-path governance} |
| L2 | Governance hardening | {fallback and closure controls} | {scale-fit concerns} |
| L3 | Scale fit | {repeatability, packaging, rollout fit} | {future scope} |

## Task Decomposition

| Task ID | Description | Owner | Complexity | Depends On |
| --- | --- | --- | --- | --- |
| T-001 | {task summary} | {owner} | low, medium, high | {task ids} |

## Validation Strategy

| Validation Type | Target | Method |
| --- | --- | --- |
| Contract validation | {contract ids} | {tests or checks} |
| Link validation | all updated markdown files | check_markdown_links.sh per file |
| Gate validation | stage exits | explicit checklist and evidence |

## Blockers And Risks

| ID | Type | Description | Resolution Path |
| --- | --- | --- | --- |
| B-001 | blocker | {description} | {decision gate or follow-up action} |
| R-001 | risk | {description} | {mitigation} |

## Handoff To Execution Pack

Use [execution-pack.md](execution-pack.md) to convert this plan into wave-by-wave gated execution.
