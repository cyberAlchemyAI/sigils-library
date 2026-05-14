# Proof Observability Package

This proof-local observability package records Arcanum sigil usage for the Ontology Vault Branching proof.

## Layout

- [config.json](config.json) - storage model and reflection thresholds.
- [reflection-state.json](reflection-state.json) - counters since the last reflection.
- [signals/sigil-invocations.jsonl](signals/sigil-invocations.jsonl) - append-only invocation ledger.
- `by-sigil/` - optional per-sigil ledgers.
- `reflections/` - future reflection reports.

## Storage Model

The package uses the hybrid model with the central JSONL ledger as source of truth.