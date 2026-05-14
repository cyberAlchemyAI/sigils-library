---
name: task-session
description: "Use when: executing one bounded task end to end with explicit trade-offs, gate checks, completion criteria, validation, and synchronized evidence."
argument-hint: "<task-reference> [--auto] [--dry-run] [--output <path>]"
tier: arcana
domain: guided-execution
version: 0.1.0
origin: generalized from recurring single-task execution governance practice
allowed-tools: Read, Write, Glob, Grep, AskQuestions, Task, Bash
---

# Sigil: Task Session

<objective>
Execute one bounded task end to end while making trade-offs explicit, enforcing blockers, validating completion, and synchronizing task evidence.
</objective>

<logic-type>
Arcana: guided execution loop with human decision points, hard gates, and completion evidence.
</logic-type>

<flags>
- `--auto`: choose the recommended option for each non-blocking decision and record that it was auto-selected.
- `--dry-run`: return the execution path, decision pack, and gate checks without mutating files.
- `--output <path>`: write the session report to a specific path.
</flags>

<applicability>
Use this sigil when:

- there is one explicit task to execute,
- the task has dependencies, deliverables, or done criteria,
- implementation choices need visible trade-offs,
- gate failures must stop mutation,
- the task record should be synchronized with evidence after completion.
</applicability>

<inputs>
Expected inputs, if available:

- explicit task reference or task file,
- task objective,
- dependency list,
- implementation checklist,
- deliverables,
- done criteria,
- relevant constraints,
- validation commands or accepted substitutes.
</inputs>

<process>
## Step 1 - Resolve Task Scope

1. Resolve exactly one target task from the user input.
2. If multiple tasks are implied, ask the user to choose one or return `BLOCK`.
3. Parse the task objective, dependencies, deliverables, and done criteria.
4. Identify related artifacts that may need synchronization after completion.

## Step 2 - Build Decision Pack

5. Enumerate unresolved task decisions with more than one viable option.
6. For each decision, build option cards with:
   - what the option entails,
   - short-term consequence,
   - long-term consequence,
   - speed impact,
   - complexity impact,
   - risk impact,
   - maintenance impact,
   - recommended option with rationale.
7. Ask the user to choose each blocker decision.
8. If `--auto` is provided, auto-select only decisions that are non-blocking or where a recommendation is clearly safe, and record the auto-selection.

## Step 3 - Evaluate Gates

9. Check task dependencies, stated constraints, required approvals, and available validation paths.
10. If a blocker exists, return `BLOCK` with exact unblock actions and stop before mutation.
11. If the task can proceed with assumptions, record those assumptions before mutation.

## Step 4 - Execute Task

12. Convert selected options and checklist items into an ordered execution path.
13. Make only the changes required for the task scope.
14. Avoid unrelated refactors or opportunistic cleanup unless they are necessary for completion.

## Step 5 - Validate Completion

15. Validate against every done criterion.
16. Run relevant checks based on touched assets.
17. If validation cannot be run, record why and provide the closest useful substitute.
18. If validation fails, attempt bounded recovery when appropriate; otherwise return `FLAG` with required follow-up.

## Step 6 - Synchronize Evidence

19. Update the task record when evidence supports completion.
20. Update related traceability, checklist, registry, or status artifacts only when the task scope requires it.
21. If no synchronization is needed, report why.

## Step 7 - Report

22. Return a compact task-session report with decisions, gate verdict, files updated, validations, and remaining follow-up.
</process>

<authority-rule>
No consequential mutation proceeds when gate status is `BLOCK`. Completion state may only be updated when supporting evidence exists.
</authority-rule>

<observability>
For reusable use, emit a post-run invocation signal using the repository-local observability package when available.

Recommended signals:

- task reference,
- decision count,
- gate result,
- files changed count,
- validation commands,
- validation result,
- completion status,
- follow-up count,
- dry-run or auto mode usage.
</observability>

<quality-bar>
A successful execution of this sigil must:

- resolve exactly one task scope,
- expose meaningful implementation trade-offs,
- stop before mutation when blockers remain,
- keep edits within the declared task scope,
- validate all available done criteria,
- synchronize completion evidence accurately,
- return a report that a reviewer can audit without reconstructing the full session.
</quality-bar>

<anti-patterns>
Avoid:

- using the sigil for many unrelated tasks at once,
- treating `--auto` as permission to guess consequential user choices,
- changing files outside the task scope without recording why,
- marking completion without evidence,
- skipping validation because the edit looks small,
- hiding failed checks inside a success report,
- letting synchronization updates rewrite unrelated planning or status history.
</anti-patterns>

<output-contract>
Return:

```markdown
## Task Session Result

- Task: <task-reference>
- Result: PASS | BLOCK | FLAG
- Decisions: <resolved count and summary>
- Gate verdict: <summary>
- Files updated: <paths or none>
- Validation: <commands and results>
- Synchronized records: <paths or none>
- Follow-up: <items or none>
```
</output-contract>