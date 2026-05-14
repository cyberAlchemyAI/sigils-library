# System Runtime Source

## Components

| Artifact | Role | Runtime Fact |
| -------- | ---- | ------------ |
| Quote API | endpoint | Accepts quote requests and returns eligibility results. |
| Profile Completeness Check | module | Validates whether required profile fields are present. |
| Quote Decision Event | event | Records accepted and rejected quote decisions. |

## Tests

| Test | Verifies |
| ---- | -------- |
| incomplete-profile-rejection | Incomplete quote requests are rejected. |
| rejection-reason-visible | Rejected quote responses include a reason. |

## Observability

| Signal | Observes |
| ------ | -------- |
| quote_decision_latency_ms | Quote-decision latency. |
| quote_rejection_reason_total | Rejection reason counts. |

## Constraints

| Constraint | Impact |
| ---------- | ------ |
| Profile completeness is evaluated synchronously. | Quote latency may increase when profile checks become expensive. |