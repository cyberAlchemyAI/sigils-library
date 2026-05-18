# Hook Operations Ledger

The hook operations ledger records background observability infrastructure work.

It is intentionally separate from capability telemetry. A sigil or spell execution writes capability telemetry to `signals/sigil-invocations.jsonl`; extraction, observer, append, dedupe, and hook-health work writes operational audit rows under `hooks/`.

## Default Layout

```text
.arcanum/observability/
  hooks/
    hook-operations.jsonl
    failures.jsonl
    dedupe.jsonl
    reflections/
      .gitkeep
```

## Event Shape

Each hook operation appends one compact JSON object:

```json
{
  "timestamp": "2026-05-18T00:00:00Z",
  "hook": "run-extractor | signal-observer | telemetry-appender | hook-health-reflect",
  "hook_run_id": "hook-20260518T000000Z-example",
  "target_run_id": "run-20260518T000000Z-example",
  "target_session_id": "session-20260518",
  "action": "extract | observe | append | update-counters | reflect",
  "status": "started | completed | skipped | failed",
  "inputs": ["safe/path/ref"],
  "outputs": ["safe/path/ref"],
  "emitted_signal": false,
  "reason": "short reason",
  "duration_ms": 0,
  "dedupe_key": "target:hook:version",
  "observe": false
}
```

## Loop Guards

- Hook operation rows never trigger `signal-observer`.
- Observer hooks may record themselves only in the hook ledger.
- Capability telemetry remains in `signals/sigil-invocations.jsonl`.
- Hook events must carry `observe: false`.
- A target run should receive at most one observer emission per observer version unless an explicit rerun changes the dedupe key.

## Failure Handling

Hook failures append to both `hook-operations.jsonl` and `failures.jsonl`. They do not change the primary user task result unless the hook itself was the requested task.

## Hook Health Reflection

Hook health reflection reads only hook ledgers and writes reports under:

```text
.arcanum/observability/hooks/reflections/
```

It may recommend changes to hook scripts, schemas, or runtime wrappers. It must not emit normal capability telemetry, and it must not recursively trigger itself.

Use `scripts/record-hook-operation.sh` for append-only hook rows and `scripts/reflect-hook-health.sh` for lightweight hook-health summaries.
