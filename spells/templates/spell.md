# {Spell Name}

## Identity

- Canonical ID: `{spell-id}`
- Aliases: {alias list or none}
- Scope: library | local

## Purpose

{What the spell helps the user accomplish.}

## Trigger Conditions

- {When to use this spell.}

## Required Sigils

| Sigil | Role In Spell | Required Mode |
| ----- | ------------- | ------------- |
| {sigil-name} | {role} | {mode or freeform} |

## Optional Sigils

| Sigil | Use When | Notes |
| ----- | -------- | ----- |
| {sigil-name} | {condition} | {notes} |

## Prerequisites

- {Repository state, package, user input, or artifact required before the spell runs.}

## Shared State

| State | Owner | Updated By | Consumed By |
| ----- | ----- | ---------- | ----------- |
| {state artifact} | {owner} | {phase} | {phase} |

## Execution Phases

| Phase | Sigil | Input | Output | Gate | Failure Policy |
| ----- | ----- | ----- | ------ | ---- | -------------- |
| 1 | {sigil} | {input} | {output} | {gate} | {policy} |

## Local Customization

- Spell root: `.arcanum/spells/`
- Local paths: {paths}
- Gate strictness: strict | standard | advisory
- Interaction mode: interactive | guided-auto | dry-run

## Observability

Record spell-level telemetry when `.arcanum/observability/` exists:

- spell name,
- phases attempted,
- sigils invoked,
- gates passed or blocked,
- handoff artifacts created,
- validation result,
- follow-up actions.

## Output Contract

Return:

```markdown
## Spell Result

- Spell: {spell-name}
- Canonical ID: {spell-id}
- Alias used: {alias or none}
- Repository: {path}
- Phases completed: {count}
- Sigils invoked: {list}
- Gates: {pass | block | flag}
- Outputs: {paths}
- Validation: {checks}
- Follow-up: {items or none}
```