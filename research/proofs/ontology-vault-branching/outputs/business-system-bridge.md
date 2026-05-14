# Business System Bridge

## Scope

- Repository: ontology-vault-branching proof
- Business sources: [business-intent.md](../source-vault/business-intent.md)
- System sources: [system-runtime.md](../source-vault/system-runtime.md)
- Mapping date: 2026-05-14

## Bridge Edges

| Business Claim | Edge Type | System Evidence | Bridge Evidence | Status |
| -------------- | --------- | --------------- | --------------- | ------ |
| Quote eligibility requires a complete profile. | realized_by | Profile Completeness Check | Business rule links to system module and rejection test. | pass |
| Quote decisions must explain rejection. | tested_by | rejection-reason-visible | Business rule links to a system test. | pass |
| Fast quote decisions improve completion. | observed_by | quote_decision_latency_ms | Metric observes latency, but completion-rate signal is missing. | flag |
| Clear eligibility feedback reduces repeated support contact. | observed_by | quote_rejection_reason_total | Signal observes rejection reasons, not support contact. | flag |
| Profile completeness is evaluated synchronously. | constrained_by | Profile Completeness Check | Technical constraint may affect quote latency. | flag |

Allowed edge types: realized_by, depends_on, constrained_by, observed_by, tested_by, drifts_from, traced_to.

## Alignment Claims

| Claim | Business Evidence | System Evidence | Confidence | Gaps |
| ----- | ----------------- | --------------- | ---------- | ---- |
| Incomplete profiles are blocked by implementation. | [business-intent.md](../source-vault/business-intent.md) | [system-runtime.md](../source-vault/system-runtime.md) | medium | none in this proof. |
| Rejected quote decisions expose a reason. | [business-intent.md](../source-vault/business-intent.md) | [system-runtime.md](../source-vault/system-runtime.md) | medium | Does not prove reason quality. |
| Quote-decision latency is observable. | [business-intent.md](../source-vault/business-intent.md) | [system-runtime.md](../source-vault/system-runtime.md) | medium | Completion-rate signal missing. |

## Bridge Gaps

- Support-contact rate after rejection has no direct system signal.
- Quote-completion rate has no direct system signal.
- Rejection reason quality is not tested, only reason visibility.

## Decisions Needed

- Decide whether support-contact rate belongs in this system or an external analytics system.
- Decide the acceptable quote-decision latency threshold.