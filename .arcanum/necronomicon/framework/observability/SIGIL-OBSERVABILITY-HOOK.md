# Sigil Observability Hook

The Sigil Observability Hook is a portable post-run pattern for turning a sigil invocation into structured JSON telemetry.

The hook runs after a sigil finishes. It synthesizes the last request that used the sigil, records what happened, and appends a compact JSON event to a telemetry ledger. This gives future reflection a factual history of how the sigil is being used, where it succeeds, and where its workflow needs iteration.

In installed repositories, Necronomicon owns the runtime handoff to this hook through `.arcanum/necronomicon/OBSERVABILITY.md`. The hook still writes to `.arcanum/observability/`.

## Why Post-Run

A pre-run hook can identify intent, but it cannot know whether the sigil succeeded. A post-run hook can see:

- the triggering request,
- the sigil selected,
- output produced,
- files changed,
- validation performed,
- Quality Bar status,
- Anti-Pattern hits,
- workflow gaps,
- whether reflection thresholds were reached.

That makes post-run observation the best default for sigil learning.

## Hook Contract

The hook receives a Sigil Invocation Envelope:

```json
{
  "timestamp": "YYYY-MM-DDTHH:MM:SSZ",
  "sigil": "<sigil-name>",
  "tier": "formulae | transmutations | arcana",
  "mode": "new | update | observe | reflect | execute",
  "request": {
    "raw": "<last user request, if available>",
    "summary": "<one sentence summary>",
    "intent": "<what the user wanted the sigil to do>"
  },
  "execution": {
    "status": "completed | partial | blocked | failed",
    "outputs": ["<artifact or result summary>"],
    "files_changed": ["<path>"],
    "validation": ["<check performed>"],
    "notes": "<short execution note>"
  },
  "observer": {
    "quality_bar_status": "pass | partial | fail | not_checked",
    "anti_pattern_hits": ["<summary>"],
    "workflow_gaps": [
      {
        "category": "trigger | input | process | quality-bar | anti-pattern | output-contract | template | observability | reflection",
        "severity": "low | medium | high | severe",
        "summary": "<gap summary>",
        "evidence": "<observable evidence>"
      }
    ],
    "output_contract_drift": false,
    "reflection_trigger": "none | manual | usage-threshold | output-threshold | gap-threshold | severe-gap",
    "recommendation": "none | targeted-update | reflect-now"
  }
}
```

## Storage Pattern

Use an append-only JSONL ledger by default:

```text
.arcanum/observability/signals/sigil-invocations.jsonl
```

JSONL is preferred over a single JSON array because each invocation can be appended as one valid JSON object without rewriting the entire file. If a runtime requires a `.json` extension, store newline-delimited JSON in a clearly named file such as:

```text
.arcanum/observability/signals/sigil-invocations.ndjson
```

The important rule is one invocation per JSON object.

See [Repository Observability Package](REPOSITORY-PACKAGE.md) for central, per-sigil, and hybrid storage options.

## Hook Flow

1. Sigil execution completes or blocks.
2. Main agent builds the invocation envelope from visible context.
3. Observer subagent receives the envelope plus relevant output snippets.
4. Observer subagent synthesizes request summary, gap signals, Quality Bar status, Anti-Pattern hits, and reflection trigger state.
5. Main agent reviews the observer result.
6. Main agent appends one JSON object to the telemetry ledger.
7. Main agent reports whether reflection is now required.

If no subagent mechanism exists, the main agent runs a clearly labeled local observer pass and writes the same JSON shape.

## Minimal Hook Prompt

Use this prompt shape for the observer subagent:

```text
You are the sigil observability observer. Read the invocation envelope and visible outputs. Return one JSON object that summarizes the user's request, execution outcome, Quality Bar status, Anti-Pattern hits, workflow gaps, output-contract drift, reflection trigger state, and recommendation. Do not edit files. Do not include secrets. If evidence is missing, use not_checked or an empty list rather than guessing.
```

## Privacy And Safety Rules

- Do not store secrets, credentials, tokens, or private keys.
- Summarize large user requests instead of storing unnecessary full text.
- Store raw request text only when it is safe and useful for later reflection.
- Prefer file paths and artifact names over large content blocks.
- Mark missing evidence as `not_checked` instead of inferring success.

## Reflection Integration

After appending a hook event, update counters since the last reflection:

- meaningful executions,
- generated outputs,
- related workflow gaps,
- severe workflow gaps,
- Quality Bar failures,
- output-contract drift events.

Trigger reflection when the sigil's local thresholds are reached. The default thresholds are defined in [usage-telemetry.md](../../arcana/sigil-development/templates/usage-telemetry.md).

## Implementation Options

### Manual Agent Hook

The agent runs the hook as the final step of any sigil execution. This is easiest to adopt and works in any environment that can edit files.

### Runtime Wrapper

A command wrapper invokes the sigil, captures inputs and outputs, calls an observer, and appends the JSON event. This is better when sigils are run through a CLI or automation harness.

### Platform Event Hook

An agent platform emits a post-tool or post-skill event. The hook subscribes to that event and writes telemetry automatically. This is best long term, but requires platform support.

## Failure Handling

If telemetry cannot be written:

- report the write failure,
- preserve the synthesized JSON object in the final response or local report,
- do not mark reflection counters as updated,
- do not block the user's primary task unless observability is the primary task.