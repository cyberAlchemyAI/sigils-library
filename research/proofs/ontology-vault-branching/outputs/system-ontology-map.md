# System Ontology Map

## Scope

- Repository: ontology-vault-branching proof
- Source folders: `source-vault/`
- Mapping date: 2026-05-14

## System Artifacts

| Artifact                   | Role     | Runtime Fact                                            | Evidence                                               | Branch Confidence |
| -------------------------- | -------- | ------------------------------------------------------- | ------------------------------------------------------ | ----------------- |
| Quote API                  | endpoint | Accepts quote requests and returns eligibility results. | [system-runtime.md](../source-vault/system-runtime.md) | medium            |
| Profile Completeness Check | module   | Validates whether required profile fields are present.  | [system-runtime.md](../source-vault/system-runtime.md) | medium            |
| Quote Decision Event       | event    | Records accepted and rejected quote decisions.          | [system-runtime.md](../source-vault/system-runtime.md) | medium            |

## Data And Execution Flow

| Source    | Flow    | Target                     | Evidence                                               | Business Link                                  |
| --------- | ------- | -------------------------- | ------------------------------------------------------ | ---------------------------------------------- |
| Quote API | invokes | Profile Completeness Check | [system-runtime.md](../source-vault/system-runtime.md) | Quote eligibility requires a complete profile. |
| Quote API | emits   | Quote Decision Event       | [system-runtime.md](../source-vault/system-runtime.md) | Quote decisions must explain rejection.        |

## Tests And Observability

| Artifact                   | Test Or Signal               | Verifies Or Observes                       | Evidence                                               | Gap                            |
| -------------------------- | ---------------------------- | ------------------------------------------ | ------------------------------------------------------ | ------------------------------ |
| Profile Completeness Check | incomplete-profile-rejection | Incomplete quote requests are rejected.    | [system-runtime.md](../source-vault/system-runtime.md) | none                           |
| Quote API                  | rejection-reason-visible     | Rejected quote responses include a reason. | [system-runtime.md](../source-vault/system-runtime.md) | none                           |
| Quote API                  | quote_decision_latency_ms    | Quote-decision latency.                    | [system-runtime.md](../source-vault/system-runtime.md) | completion-rate signal missing |
| Quote Decision Event       | quote_rejection_reason_total | Rejection reason counts.                   | [system-runtime.md](../source-vault/system-runtime.md) | support-contact signal missing |

## Technical Constraints

| Constraint                                       | Affected Artifact          | Potential Business Impact                                        | Evidence                                               |
| ------------------------------------------------ | -------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------ |
| Profile completeness is evaluated synchronously. | Profile Completeness Check | Quote latency may increase when profile checks become expensive. | [system-runtime.md](../source-vault/system-runtime.md) |

## Open Questions

- Does the Quote Decision Event include the rejection reason text or only a reason code?
- Is synchronous profile validation acceptable under the target latency threshold?
