# Necronomicon Observability

Necronomicon owns the post-run observability handoff for installed Arcanum runtime usage.

## Ledger

- Central invocation ledger: [../observability/signals/sigil-invocations.jsonl](../observability/signals/sigil-invocations.jsonl)
- Reflection state: [../observability/reflection-state.json](../observability/reflection-state.json)
- Optional per-sigil ledgers: ../observability/by-sigil/
- Reflection reports: ../observability/reflections/

## Handoff Rules

1. After meaningful sigil or spell execution, summarize the request, route, selected definition, outputs, files changed, validation, quality-bar status, anti-pattern hits, workflow gaps, reflection trigger, and recommendation.
2. Append one JSON object to the central invocation ledger when writing telemetry is allowed.
3. Do not store secrets, credentials, private keys, tokens, or unnecessary raw request content.
4. If telemetry cannot be written, report the failure and preserve the synthesized event in the final response.
5. Do not block the user's primary task unless observability is the primary task.
