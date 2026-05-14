# Ontology Drift Report

## Scope

- Repository: ontology-vault-branching proof
- Business source: [business-intent.md](../source-vault/business-intent.md)
- System source: [system-runtime.md](../source-vault/system-runtime.md)
- Review date: 2026-05-14

## Drift Findings

| Business Expectation | Observed System Behavior | Drift Type | Evidence | Severity |
| -------------------- | ------------------------ | ---------- | -------- | -------- |
| Clear eligibility feedback reduces repeated support contact. | Rejection reasons are counted, but support contact is not measured. | observability gap | [business-intent.md](../source-vault/business-intent.md), [system-runtime.md](../source-vault/system-runtime.md) | medium |
| Fast quote decisions improve completion. | Latency is measured, but quote completion rate is not. | observability gap | [business-intent.md](../source-vault/business-intent.md), [system-runtime.md](../source-vault/system-runtime.md) | medium |
| Quote decisions must explain rejection. | A test verifies reason visibility, but not reason quality. | test gap | [business-intent.md](../source-vault/business-intent.md), [system-runtime.md](../source-vault/system-runtime.md) | low |

## Impact

| Drift | Business Impact | System Impact | Recommended Action |
| ----- | --------------- | ------------- | ------------------ |
| Support-contact rate missing | Cannot prove the value claim. | Add or link analytics signal. | Add bridge edge to support analytics source. |
| Quote-completion rate missing | Cannot prove completion improvement. | Add quote-completion metric or event. | Add metric and update traceability matrix. |
| Reason quality untested | Visible reason may still be unclear. | Add acceptance check for reason content. | Add test evidence for reason quality. |

## Follow-Up

- Add metrics for quote-completion rate and support-contact rate when a real system exists.
- Add a test or review rule for rejection reason quality.