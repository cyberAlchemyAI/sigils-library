# Ontology Harness Run Report

## Spell Result

- Spell: Ontology Harness
- Canonical ID: `ontology-harness`
- Alias used: none
- Repository: `arcanum/research/proofs/ontology-vault-branching/`
- Phases completed: 13
- Sigils invoked: `inventory`, `ontology-vault`, `context-builder`, `observability-setup`
- Gates: flag
- Outputs: [business ontology map](business-ontology-map.md), [system ontology map](system-ontology-map.md), [business-system bridge](business-system-bridge.md), [traceability matrix](traceability-matrix.md), [ontology drift report](ontology-drift-report.md), [context retrieval proof](context-retrieval-proof.md), [proof inventory](../.arcanum/inventory/index.md), [observability package](../.arcanum/observability/README.md)
- Validation: source links present, branch maps produced, bridge edges cite both branches, drift gaps preserved, proof-local telemetry emitted
- Follow-up: resolve the flagged value-measure gaps before treating the value claims as proven by implementation evidence

## Phase Notes

| Phase | Status | Evidence |
| ----- | ------ | -------- |
| Inventory package | pass | Proof-local inventory created under [../.arcanum/inventory/](../.arcanum/inventory/). |
| Source ingest | pass | [business-intent.md](../source-vault/business-intent.md) and [system-runtime.md](../source-vault/system-runtime.md) are indexed. |
| Ontology map | pass | Business and system maps are generated from explicit source evidence. |
| Branch-aware path | pass | Business, system, and bridge branches are separated. |
| Architecture evidence | skipped | This proof uses a neutral system source rather than a real repository architecture. |
| Bridge validation | flag | All bridge edges exist, but two value measures lack direct system signals. |
| Session distillation | skipped | No session records exist in this proof. |
| Premise and confidence review | flag | Premises remain low or medium confidence until real-world evidence exists. |
| Decision gate | skipped | Follow-up decisions are named but not resolved inside the proof. |
| Convention and drift report | pass | Drift gaps are preserved in [ontology-drift-report.md](ontology-drift-report.md). |
| Inventory update | pass | Inventory index and entry files reference the source and output artifacts. |
| Context proof | pass | [context-retrieval-proof.md](context-retrieval-proof.md) maps obligations to selector-level evidence. |
| Spell report | pass | This report records gates, outputs, validation, and follow-up. |

## Flagged Gaps

- Support-contact rate after rejection has no direct system signal.
- Quote-completion rate has no direct system signal.
- Rejection reason quality is not tested, only reason visibility.

## Next Action

Use this proof as the reference run for branch-aware `ontology-vault map --branches business,system` and `ontology-vault validate --bridge business-system`. In a real repository, add or link the missing analytics and quality evidence before promoting the value claims.