---
module: {module-name}
version: current
status: draft
updatedAt: {date}
docType: work-pack
---

# WORK-PACK: {module-name}

## Purpose

Stable execution manifest for invoke planning outputs.

This artifact is the planning entrypoint that maps implementation-plan decisions into execution-ready structure.
It can stay single-file for low complexity or link split modules and execution-pack artifacts for medium/high complexity.
This template is standalone at invoke scope and is composed by Module Formulae implementation and full profiles.

## Control Fields

| Field | Value | Notes |
| --- | --- | --- |
| workPackGateStatus | pass or block | Must be pass before mutation-capable execution. |
| complexity | low, medium, or high | Current complexity level. |
| outputMode | single-file or split | Split is required when scope exceeds low complexity. |
| implementationPlanRef | {path} | Source implementation-plan artifact. |
| executionPackRef | {path or n/a} | Required for medium/high complexity execution. |
| layeringArtifactRef | {path or n/a} | Should reference implementation-layering.md. |
| activeLayerWindow | L0, L1, L2, L3, or n/a | Primary layer focus for current execution slice. |
| lastUpdatedAt | {iso-timestamp} | Last update time for this work-pack. |
| readinessProfile | pilot, release-candidate, production | Completion target profile. |

## Objective Summary

- Objective: {what this work-pack must deliver}
- Primary inputs: implementation plan, layering decisions, architecture references
- Success condition: {evidence-based completion condition}

## Implementation Plan Mapping

| Implementation Plan Source | Work-Pack Target | Mapping Rule |
| --- | --- | --- |
| Delivery Slices | Task Status Board | Each slice produces one or more tasks with explicit dependencies. |
| Layer Boundary Decisions | activeLayerWindow and task layer fields | Every task and wave maps to at least one layer decision. |
| Task Decomposition | Task Status Board and task files | Preserve task IDs, dependencies, and owners. |
| Blockers And Risks | Blockers section | Carry blocker IDs and resolution paths forward unchanged. |
| Validation Strategy | Gate checks and evidence references | Reuse validation targets and expected evidence commands. |

## Task Status Board

| Task ID | Goal | Layer | Complexity | Waves | Gate Status | Status |
| --- | --- | --- | --- | --- | --- | --- |
| TASK-A | {goal summary} | L0, L1, L2, or L3 | low, medium, high | W1, W2 | ready or blocked | not-started, in-progress, completed |
| TASK-VERIFY | Completion verification | L2 or L3 | medium or high | W3+ | ready-after-implementation | not-started, in-progress, completed |

## Blockers

| Blocker ID | Scope | Description | Owner | Next Action | Target Date |
| --- | --- | --- | --- | --- | --- |
| B-001 | task or cross-task | {blocked item} | {owner} | {unblock action} | {date} |

## Required Links

Single-file mode:

- Keep this file as the only planning artifact when scope remains low complexity and reviewable.

Split mode:

- module-formulae/execution-pack.md
- work-pack/shared/context.md
- work-pack/shared/cross-task-gaps.md
- work-pack/shared/cross-task-decisions.md
- work-pack/shared/traceability.md
- work-pack/tasks/TASK-A.md
- work-pack/waves/W0.md
- work-pack/waves/W1.md

## Gate Checks

1. `workPackGateStatus` must be pass before mutation-capable execution.
2. Medium/high complexity requires `executionPackRef` and baseline wave W0.
3. Layer mappings must be consistent with `layeringArtifactRef` deferred scope and promotion decisions.
4. Any unresolved blocker that affects acceptance criteria keeps gate status at block.

## Handoff To Execution Pack

Use [module-formulae/execution-pack.md](module-formulae/execution-pack.md) for wave-by-wave execution details.

- Low complexity: execution details may remain in this file with `executionPackRef = n/a`.
- Medium/high complexity: generate or update execution-pack and set `executionPackRef`.
- Keep task IDs and layer assignments consistent between work-pack and execution-pack.

## Change Log

| Date | Change | Author |
| --- | --- | --- |
| {date} | Initial work-pack created | {name} |