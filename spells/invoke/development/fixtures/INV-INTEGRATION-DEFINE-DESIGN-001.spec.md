# Spec: Mars Rover Maintenance Log

## Objective

Create a reusable module for recording daily rover maintenance activity before architecture and implementation planning.

## Scope

- Daily inspection notes.
- Component status.
- Operator decisions.
- Unresolved repair questions.

## Out Of Scope

- Direct rover command execution.
- Automated repair scheduling.
- Hardware telemetry ingestion.

## Actors

- Rover operator.
- Maintenance reviewer.
- Mission planner.

## Core Workflows

1. Operator records daily inspection notes.
2. Operator updates component status.
3. Reviewer records operator decisions.
4. Team tracks unresolved repair questions.

## Acceptance Criteria

- Inspection notes are traceable to a rover, sol, operator, and component when applicable.
- Component status uses a controlled status set.
- Operator decisions include rationale and source note references.
- Unresolved repair questions remain visible for design and planning.

## Glossary Terms

- Mars rover maintenance log
- daily inspection note
- component status
- operator decision
- unresolved repair question

## Decisions

| Decision | Result |
| --- | --- |
| Module boundary | Record maintenance evidence and decisions; do not execute repairs. |

## Unresolved Questions

| Question | Impact |
| --- | --- |
| Should component status include severity? | Design can proceed with status extensibility noted. |
