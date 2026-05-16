---
template_id: invoke.implementation-plan
template_type: implementation-plan
applies_to:
  - plan
  - full
  - validate
required_inputs:
  - implementation_objective
  - source_design_refs
  - delivery_boundary
optional_inputs:
  - architecture_refs
  - implementation_layering_ref
  - work_pack_ref
  - execution_pack_ref
output_files:
  - IMPLEMENTATION-PLAN.md
status: candidate
authority_level: invoke-local
promotion_evidence: []
promotion_decision: pending
validation_rules:
  - source design refs present
  - delivery slices mapped
  - validation strategy present
  - standalone companion handoffs recorded
validation_examples:
  - examples/passing.md
  - examples/missing-input.md
created_at: 2026-05-16
updated_at: 2026-05-16
---

# Implementation Plan: {capability-name}

## Implementation Objective

{what must be delivered and why}

## Source Design References

| Ref ID | Source | Required | Notes |
| --- | --- | --- | --- |
| SD-001 | {path or decision} | yes or no | {notes} |

## Delivery Boundary

- Included: {included delivery}
- Excluded: {excluded delivery}
- Deferral rules: {what may be deferred}

## Delivery Slices

| Slice ID | Outcome | Dependencies | Validation |
| --- | --- | --- | --- |
| S-001 | {outcome} | {dependencies} | {validation check} |

## Dependency Plan

| Dependency | Needed By | Readiness | Risk |
| --- | --- | --- | --- |
| {dependency} | {slice} | ready, partial, or missing | {risk} |

## Layer Window

- Layering companion: [../implementation-layering.md](../implementation-layering.md)
- Selected start layer: {layer}
- Selected stop layer: {layer}
- Layer deferrals: {deferrals}

## Task Decomposition

| Task ID | Slice ID | Task | Done When |
| --- | --- | --- | --- |
| T-001 | S-001 | {task} | {completion check} |

## Blocker Ledger

| Blocker ID | Blocker | Impact | Resolution |
| --- | --- | --- | --- |
| B-001 | {blocker} | {impact} | {resolution} |

## Validation Strategy

| Check ID | Check | Scope | Tool Or Evidence |
| --- | --- | --- | --- |
| V-001 | {check} | {scope} | {tool or evidence} |

## Work-Pack Handoff

- Work-pack companion: [../work-pack.md](../work-pack.md)
- Required manifest entries: {entries}
- Deferred entries: {entries and reasons}

## Execution-Pack Handoff

- Execution-pack template: [../module-formulae/execution-pack.md](../module-formulae/execution-pack.md)
- Wave grouping: {wave notes}
- Parallelization boundary: {boundary}

## Closure Criteria

| Criterion | Evidence |
| --- | --- |
| {criterion} | {evidence} |

## Gate Result

- Status: pass, flag, or block
- Reason: {gate result summary}