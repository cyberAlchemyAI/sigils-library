# Business Ontology Map

## Scope

- Repository: ontology-vault-branching proof
- Source folders: `source-vault/`
- Mapping date: 2026-05-14

## Business Concepts

| Concept | Role | Meaning | Evidence | Confidence |
| ------- | ---- | ------- | -------- | ---------- |
| Quote eligibility | capability | A user can request a quote and receive an eligibility decision before purchase. | [business-intent.md](../source-vault/business-intent.md) | medium |
| Complete profile | business rule | The user must provide enough information for a responsible quote decision. | [business-intent.md](../source-vault/business-intent.md) | medium |
| Rejection explanation | business rule | Rejected quote decisions should tell the user why they cannot proceed. | [business-intent.md](../source-vault/business-intent.md) | medium |

## Actors And Workflows

| Actor Or Workflow | Intent | Outcome | Evidence | Gaps |
| ----------------- | ------ | ------- | -------- | ---- |
| Quote request workflow | Give users a clear eligibility decision before purchase. | Accepted or rejected quote decision. | [business-intent.md](../source-vault/business-intent.md) | Needs bridge to system implementation. |

## Rules, Policies, And Premises

| Claim | Type | Evidence Confidence | Commitment Confidence | Required System Bridge |
| ----- | ---- | ------------------- | --------------------- | ---------------------- |
| Quote eligibility requires a complete profile. | business rule | medium | high | yes |
| Quote decisions must explain rejection. | business rule | medium | high | yes |
| Users prefer immediate rejection reasons over delayed manual review. | premise | low | medium | yes |

## Outcomes And Value Measures

| Outcome | Value Measure | Evidence | Observability Need |
| ------- | ------------- | -------- | ------------------ |
| Reduced repeated support contact | Support-contact rate after rejection | [business-intent.md](../source-vault/business-intent.md) | No system signal in this proof. |
| Faster quote completion | Quote-decision latency and quote-completion rate | [business-intent.md](../source-vault/business-intent.md) | `quote_decision_latency_ms` covers latency only. |

## Open Questions

- Should support-contact rate be observed directly or inferred from another system?
- What threshold defines acceptable quote-decision latency?