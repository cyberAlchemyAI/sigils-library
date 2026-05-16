# Task Session

Task Session is an Arcana sigil for executing one bounded task end to end with explicit decisions, gate checks, completion criteria, validation, and synchronization.

It is useful when a task is too consequential for a quick edit but too narrow for a full planning workflow. The sigil keeps the session focused on one task, exposes trade-offs before action, blocks on unresolved gates, and leaves a concise record of what changed and why.

## Problem It Solves

Single-task execution can drift when the agent starts implementing before the task is fully resolved. Dependencies may be missed, options may be chosen silently, and completion criteria may be updated without evidence.

Task Session solves this by turning one task into a guided execution loop: resolve scope, prepare decision options, check gates, perform the work, validate outcomes, and synchronize the task record.

## Use When

- there is one explicit task to execute,
- the task has dependencies, trade-offs, or validation requirements,
- the user wants focused progress without opening a broad planning cycle,
- completion needs evidence rather than a verbal claim,
- task records or traceability artifacts should be kept current.

## Do Not Use When

- the task is trivial and reversible,
- the work is undefined or spans many independent tasks,
- unresolved blocker decisions should be handled by [decision-gate](../decision-gate/),
- the task belongs to an existing project-specific execution workflow,
- validation cannot be run or meaningfully substituted.

## Session Loop

1. Resolve one task scope.
2. Parse objective, dependencies, deliverables, and done criteria.
3. Build option cards for unresolved implementation choices.
4. Ask the user or auto-select only when explicitly allowed.
5. Evaluate blockers and dependency gates.
6. Execute the chosen path.
7. Validate against done criteria.
8. Synchronize task state and related records.
9. Return a compact session report.

## Output

The sigil produces:

- selected task scope,
- decisions and trade-offs,
- gate verdict,
- files or artifacts updated,
- validation results,
- synchronized completion evidence,
- follow-up items.

## Why This Is Arcana

Task Session coordinates decisions, gates, execution, validation, and state synchronization across a whole task lifecycle. It is more than a checklist: it governs whether the task may proceed, how choices are recorded, and when completion is credible.