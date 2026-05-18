# Validation Experiment Protocol

Use this protocol before promoting any reusable Arcanum spell or sigil to canonical registry status.

The goal is to prove behavior with small, repeatable scenarios before release. A contract is not considered ready just because its markdown is complete; it must show that its trigger rules, gates, outputs, examples, observability, and handoff boundaries work together.

Use [EXPERIMENT-HARNESS-STANDARD.md](EXPERIMENT-HARNESS-STANDARD.md) for the artifact-local layout, runner expectations, prompt/output capture rules, and promotion evidence checklist.

## Applicability

Use this protocol for:

- new spells before adding them to [../registry/SPELLS.md](../registry/SPELLS.md),
- new sigils before adding them to [../registry/SIGILS.md](../registry/SIGILS.md),
- major revisions that change triggers, modes, gates, output contracts, or handoff behavior,
- candidate templates that should become canonical.

## Experiment Shape

Each validation experiment must define:

| Field | Requirement |
| --- | --- |
| Artifact | Spell or sigil canonical ID and source path. |
| Promotion target | Candidate, local reusable, library reusable, or registry release. |
| Hypothesis | The lifecycle behavior being tested. |
| Fixtures | Passing and negative scenarios with realistic user requests and fixed input files. |
| Execution method | Automated runner, contract dry-run runner, live command invocation, or explicitly approved manual review. |
| Expected outputs | User-facing result files plus required artifacts, reports, telemetry, or block result. |
| Gates | Conditions that must pass before promotion. |
| Observability | Signal path or explicit reason telemetry is not needed. |
| Verdict | `pass`, `flag`, or `block`. |
| Follow-up | Required fixes, deferred scope, or promotion action. |

## Minimum Validation Matrix

Every spell or sigil experiment should include:

| Check | Spell Requirement | Sigil Requirement |
| --- | --- | --- |
| Contract structure | Required spell sections exist. | `README.md` and `SKILL.md` define lifecycle behavior. |
| Link validation | Markdown links resolve. | Markdown links resolve. |
| Registry fit | Canonical ID is unique and aliases do not conflict. | Tier and registry category are correct. |
| Trigger fit | Trigger and non-trigger cases are distinguishable. | Use and do-not-use cases are distinguishable. |
| Positive scenario | One passing execution or dry-run fixture reaches expected output contract. | One passing execution or dry-run fixture reaches expected output contract. |
| Negative scenario | One missing-input or blocked-gate fixture returns `block` or `flag` as specified. | One misuse or missing-input fixture returns the expected refusal, block, or gap. |
| Handoff behavior | Handoff artifacts and next route are explicit. | Downstream handoff or lifecycle next step is explicit. |
| Observability | Reusable spells define telemetry expectations. | Reusable sigils define meaningful execution signals and reflection triggers. |
| Promotion rule | Registry entry is blocked until validation passes. | Registry entry is blocked until validation passes. |

## Standard Procedure

1. Identify the artifact and promotion target.
2. Read the current contract, examples, registry, and observability conventions.
3. Create or select fixture files for at least one passing scenario and one negative scenario. Fixtures should read like real user requests, including realistic constraints, missing information, and handoff needs.
4. Create or select a runner that can replay the fixtures.
5. Run markdown link checks for every changed markdown file.
6. Run the fixture runner and capture its output in the artifact-local validation report.
7. If a live runtime is available, invoke the runtime command against the same fixtures.
8. If a live runtime is not available, use a contract dry-run runner that checks fixture expectations against the canonical contract gates.
9. Manual review is allowed only when automation is not practical; the validation report must mark the fixture as manual, name the reviewer, and record why no runner was possible.
10. Validate contract-specific gates:
   - spells: use `spellcraft validate` criteria from [../arcana/spellcraft/SKILL.md](../arcana/spellcraft/SKILL.md),
   - sigils: use `sigil-development` criteria from [../arcana/sigil-development/SKILL.md](../arcana/sigil-development/SKILL.md).
11. Record the verdict in an artifact-local `development/VALIDATION.md` or equivalent validation report.
12. Add or update registry entries only after a `pass` verdict.

For artifacts with multiple modes, templates, or task classes, add a task matrix and prompt/output harness following [EXPERIMENT-HARNESS-STANDARD.md](EXPERIMENT-HARNESS-STANDARD.md).

## Reproducibility Rule

A validation dry-run is valid only when another maintainer can rerun it from repository files.

At minimum, every dry-run must include:

- fixture input files,
- realistic user requests in those fixtures,
- expected user-facing output files,
- expected fixture outcomes,
- a runner command,
- captured runner output or a validation report summary,
- an explanation of whether the runner used live execution or contract-based simulation.

Contract-based simulation is acceptable before a runtime exists, but it must check the fixture expectations and expected user-facing outputs against canonical contract gates rather than relying on prose alone.

## Realism Rule

Experiments should rehearse the experience a user will actually get.

Each fixture set should include:

- at least one normal real-world request,
- at least one blocked or missing-input request,
- domain-specific nouns and constraints rather than placeholder-only content,
- an expected result in the artifact's real output contract,
- any expected handoff route, unresolved gap, or transport note the user would see.

Placeholder-only fixtures are allowed for schema smoke tests, but they do not count as promotion evidence.

## Verdict Rules

Return `pass` when the artifact satisfies every promotion gate.

Return `flag` when the artifact is usable but has non-blocking gaps that must be tracked before broader release.

Return `block` when a required section, fixture, gate, output contract, authority boundary, or observability path is missing.

## Reuse Rule

Every new spell or sigil should carry a local validation report that references this protocol. That report is the release evidence. Registry files should point only to artifacts whose validation report has a passing verdict or an explicitly approved flagged release.
