# Architecture: Mars Rover Maintenance Log

## Context View

The Mars rover maintenance log sits between rover operators, maintenance reviewers, and mission planners. It records human-authored maintenance evidence and decisions. It does not execute rover commands, schedule repairs, or ingest hardware telemetry directly.

Neighboring contexts:

- Rover operations notes provide daily inspection details.
- Mission planning consumes unresolved repair questions.
- Review workflows consume operator decisions and component status changes.

## High-Level Structure View

| Part | Responsibility |
| --- | --- |
| Maintenance Log | Owns the module boundary and record lifecycle. |
| Inspection Note Register | Stores daily inspection notes with rover, sol, operator, and component references. |
| Component Status Register | Tracks controlled status values for rover components. |
| Decision Log | Records operator decisions, rationale, and source evidence. |
| Repair Question Ledger | Keeps unresolved repair questions visible for planning. |

## Low-Level Components View

| Component | Inputs | Outputs | Notes |
| --- | --- | --- | --- |
| InspectionNote | rover id, sol, operator, note text, optional component | daily inspection note | Must remain traceable to source author and sol. |
| ComponentStatus | component id, status, rationale, source note | component status | Severity remains extensible but not required in L1 design. |
| OperatorDecision | decision, rationale, source references | operator decision | Cannot silently close unresolved repair questions. |
| RepairQuestion | question, related component, status, owner | unresolved repair question | Feeds plan-stage follow-up. |

## Workflow Process View

1. Operator creates a daily inspection note.
2. Operator updates component status when the note changes a component assessment.
3. Reviewer records or confirms operator decisions.
4. Repair questions are opened, updated, or left unresolved.
5. Planning consumes unresolved repair questions and status changes.

Failure paths:

- Missing rover, sol, or operator blocks inspection-note acceptance.
- Unknown component allows note capture but flags component linkage.
- Decision without rationale is flagged before planning handoff.

## Decision Flow View

| Decision Point | Rule | Outcome |
| --- | --- | --- |
| Is the inspection note traceable? | rover, sol, and operator are required | accept or block |
| Does the note affect a component? | component reference may be present | update component status or leave note-only |
| Does a decision close a repair question? | closure requires rationale and source evidence | close, update, or keep unresolved |
| Is severity required? | not required in L1 | defer to planning input |

## Dependency Interface View

| Dependency | Direction | Contract |
| --- | --- | --- |
| Rover operations notes | inbound | daily inspection note source references |
| Mission planning | outbound | unresolved repair questions and component status changes |
| Review workflow | inbound/outbound | operator decisions and rationale |

## Glossary Preservation

The design preserves these define-stage terms:

- Mars rover maintenance log
- daily inspection note
- component status
- operator decision
- unresolved repair question

## Planning Handoff Notes

- Decide whether `component status` needs severity before implementation planning.
- Keep `unresolved repair question` visible as a planning traceability label.
- Do not create execution tasks in design mode.
