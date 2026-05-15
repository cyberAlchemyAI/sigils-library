# Business Intent Source

## Capability

Users can request a quote and receive a clear eligibility decision before committing to a purchase.

## Business Rules

| Rule                                           | Meaning                                                                    | Outcome                                              |
| ---------------------------------------------- | -------------------------------------------------------------------------- | ---------------------------------------------------- |
| Quote eligibility requires a complete profile. | The user must provide enough information for a responsible quote decision. | The quote workflow should block incomplete requests. |
| Quote decisions must explain rejection.        | Users should know why they cannot proceed.                                 | Rejection output includes a reason.                  |

## Value Claims

| Claim                                                        | Value Measure                                     |
| ------------------------------------------------------------ | ------------------------------------------------- |
| Clear eligibility feedback reduces repeated support contact. | Support-contact rate after rejection.             |
| Fast quote decisions improve completion.                     | Quote-decision latency and quote-completion rate. |

## Premises

- Users prefer an immediate rejection reason over a delayed manual review when the profile is incomplete.
- A profile-completeness rule is acceptable if the missing fields are visible to the user.
