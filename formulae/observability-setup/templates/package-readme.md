# Sigil Observability

This package stores local telemetry for sigil usage in this repository.

## Files

- `config.json` defines storage model and reflection thresholds.
- `reflection-state.json` tracks counters since the last reflection.
- `signals/sigil-invocations.jsonl` is the central append-only invocation ledger.
- `by-sigil/` can hold optional or derived per-sigil ledgers.
- `reflections/` can hold reflection reports.

## Default Model

The default storage model is hybrid: use the central ledger as the source of truth and optional per-sigil ledgers for focused reflection.

## Privacy

Do not store secrets, credentials, tokens, private keys, or unnecessary raw request content in telemetry.
