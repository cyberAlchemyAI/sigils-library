# Traceability Matrix

## Scope

- Repository: ontology-vault-branching proof
- Business scope: quote eligibility intent and value claims
- System scope: quote API, profile check, decision event, tests, and telemetry
- Review date: 2026-05-14

## Matrix

| Business Claim | System Artifact | Edge Type | Test Evidence | Observability Evidence | Status |
| -------------- | --------------- | --------- | ------------- | ---------------------- | ------ |
| Quote eligibility requires a complete profile. | Profile Completeness Check | realized_by | incomplete-profile-rejection | quote_rejection_reason_total | pass |
| Quote decisions must explain rejection. | Quote API | tested_by | rejection-reason-visible | quote_rejection_reason_total | pass |
| Fast quote decisions improve completion. | Quote API | observed_by | none | quote_decision_latency_ms | flag |
| Clear eligibility feedback reduces repeated support contact. | Quote Decision Event | observed_by | none | quote_rejection_reason_total | flag |
| Profile completeness is evaluated synchronously. | Profile Completeness Check | constrained_by | none | quote_decision_latency_ms | flag |

## Coverage Summary

- Business claims reviewed: 5
- Claims with implementation bridge: 5
- Claims with test evidence: 2
- Claims with observability evidence: 5
- Claims with drift findings: 0
- Unbridged claims: 0

## Gaps

- Completion-rate signal is missing.
- Support-contact signal is missing.
- Rejection reason quality is not tested.