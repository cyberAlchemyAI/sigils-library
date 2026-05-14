# Sigil Development

Sigil Development is an Arcana sigil for designing, validating, observing, reflecting on, and iterating other sigils.

It turns sigil authoring into a governed lifecycle rather than a one-time file-writing task. The sigil guides the author through candidate capture, tier classification, behavior design, validation, trial execution, observability setup, reflection, and maintenance.

## Problem It Solves

Sigils can decay after they are written. A process can look clear in the first draft but later reveal ambiguous triggers, weak Quality Bars, missing Anti-Patterns, output drift, or repeated workflow gaps.

This sigil solves that by making observability part of the development lifecycle. Each sigil should emit enough usage telemetry for later reflection, and reflection should feed targeted improvements back into the sigil instead of relying on memory or anecdote.

## Use When

- creating a new sigil,
- revising an existing sigil,
- adding observability or telemetry to a sigil,
- evaluating whether a sigil is ready for promotion,
- reflecting on usage signals after repeated executions,
- investigating workflow gaps discovered during sigil use.

## Do Not Use When

- the task is only to run an already-defined sigil,
- the requested change is a tiny typo fix with no behavior impact,
- the user only needs a quick explanation of the library structure,
- no reusable capability is being created or maintained.

## Lifecycle Model

Sigil Development uses a closed lifecycle:

1. Design: define intent, tier, scope, and behavior.
2. Validate: check folder structure, links, Quality Bar, Anti-Patterns, and output contract.
3. Observe: define usage telemetry and emit a signal after meaningful usage.
4. Reflect: synthesize usage signals manually, by threshold, or when workflow gaps appear.
5. Iterate: apply targeted updates while preserving the sigil's core contract.

## Subagent Observer

This sigil uses a separate observer subagent when telemetry or reflection is needed.

The observer subagent should not rewrite the sigil directly. Its job is to inspect usage outputs, identify signals, classify gaps, and produce telemetry or reflection recommendations. The main agent remains responsible for applying changes after review.

If a subagent mechanism is unavailable, run the observer pass as a clearly labeled separate analysis step and preserve the same output format.

## Observability Outputs

The sigil can produce:

- per-use telemetry signals,
- threshold state summaries,
- reflection reports,
- iteration recommendations,
- updated Quality Bar or Anti-Patterns proposals.

Templates live in [templates/](templates/).

## Reflect Triggers

Reflection can be triggered in three ways:

- Manual: a user asks for review, reflection, or improvement.
- Threshold-based: usage signals or generated outputs exceed a configured count.
- Gap-based: a workflow gap, repeated misuse, failed Quality Bar, or unclear output contract is identified.

Default thresholds are intentionally conservative: reflect after 5 meaningful executions, 10 generated artifacts, 3 repeated gap signals, or 1 severe workflow gap.

## Why This Is Arcana

This sigil coordinates a recursive lifecycle, delegates observation to a subagent, preserves evidence across executions, and routes reflection into governed iteration. Its primary behavior is lifecycle orchestration, not a single deterministic check or bounded synthesis artifact.