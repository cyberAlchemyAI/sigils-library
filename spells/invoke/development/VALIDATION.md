# Invoke Validation Report

Validation protocol: [VALIDATION-EXPERIMENT.md](VALIDATION-EXPERIMENT.md)

## Run Summary

- Artifact: `invoke`
- Scope: library spell
- Validation date: 2026-05-17
- Validated layer: L0 define and L1 design contract readiness
- Promotion target: proceed to L2 planning work after L0/L1 fixture evidence passes
- Verdict: `pass`
- Latest run report: [runs/20260517T230901Z.md](runs/20260517T230901Z.md)

## Checks Performed

| Check | Result | Evidence |
| --- | --- | --- |
| Markdown links | pass | `find arcanum/spells/invoke -name '*.md' -print0 \| xargs -0 -n1 ./tools/check_markdown_links.sh` passed for all invoke markdown files. |
| Spell contract structure | pass | [../README.md](../README.md), [../define.md](../define.md), and [../design.md](../design.md) define identity, modes, phases, gates, handoffs, failure policy, observability, and output contracts. |
| Template scaffold coverage | pass | [../templates/README.md](../templates/README.md) declares family scaffold requirements; `generic`, `research`, `architecture`, `implementation-plan`, `spell`, `sigil`, and `ux-plan` folders include README, primary template, passing example, and missing-input example. |
| Template task matrix coverage | pass | [TEMPLATE-VALIDATION-TASKS.md](TEMPLATE-VALIDATION-TASKS.md) lists low, medium, and complex tasks for Module Formulae, standalone companions, and each dedicated family. |
| Template prompt coverage | pass | [TEMPLATE-EXAMPLE-RUNBOOK.md](TEMPLATE-EXAMPLE-RUNBOOK.md) explains how to run every generated prompt in Codex; `example-prompts/` contains one prompt per template task. |
| Prompt selector coverage | pass | [select-template-example-prompt.sh](select-template-example-prompt.sh) resolves exact task IDs, template+complexity pairs, and `next`; Codex command bridges exist for `arcanum-sigil-invoke-example-runner`; [run-template-example-with-codex.sh](run-template-example-with-codex.sh) provides bounded `codex exec` automation. |
| Example output coverage | pass | Saved example outputs under `example-outputs/` are checked for real `Invoke Result` shape and rejected if they are save-summary responses; architecture outputs must include a full architecture artifact with all required sections. |
| Define gate coverage | pass | [../define.md](../define.md) blocks missing core goals, flags unapproved candidate-template cases, gates glossary promotion, and defines transport behavior. |
| Design gate coverage | pass | [../design.md](../design.md) requires six views, source-contract gating, glossary consistency, non-mutating upstream behavior, and design transport. |
| Registry gate | pass | [../../../registry/SPELLS.md](../../../registry/SPELLS.md) does not yet register `invoke`; release remains blocked until validation passes. |
| Codex adapter readiness | pass | Root-level `.arcanum/runtimes/codex/commands/arcanum-spell-invoke.md` and `.codex/commands/arcanum-spell-invoke.md` exist and route Codex to canonical `arcanum/spells/invoke` contracts. |
| Fixture replay | pass | `arcanum/spells/invoke/development/run-validation-fixtures.sh` reports all define and design realistic fixtures and expected output files passing. |
| Integration replay | pass | `INV-INTEGRATION-DEFINE-DESIGN-001` proves define artifacts feed design inputs, preserve glossary terms, emit six views, and route next to `plan`. |

## Fixture Status

| Fixture ID | Status | Notes |
| --- | --- | --- |
| [TEMPLATE-TASK-MATRIX](TEMPLATE-VALIDATION-TASKS.md) | pass | Template task inventory covers low, medium, and complex tasks for every invoke-owned template family or standalone companion. |
| PROMPT-SELECTOR | pass | Prompt selector and Codex command bridge can choose a prompt by task ID, template+complexity, or next unrun prompt. |
| EXAMPLE-OUTPUTS | pass | Existing Codex-generated example outputs have real result bodies, including `Mode` and `Phase status`. |
| [INV-DEFINE-PASS-001](fixtures/INV-DEFINE-PASS-001.md) | pass | Define dry-run from vague but usable Mars rover maintenance request produces spec, glossary, define transport, and layering seed evidence. |
| [INV-DEFINE-BLOCK-001](fixtures/INV-DEFINE-BLOCK-001.md) | pass | Define dry-run with missing core goal blocks at the expected gate and records missing goal and scope boundary. |
| [INV-DEFINE-FLAG-001](fixtures/INV-DEFINE-FLAG-001.md) | pass | Define dry-run with unsupported template fit flags candidate-template approval gap without promotion. |
| [INV-DEFINE-GLOSSARY-001](fixtures/INV-DEFINE-GLOSSARY-001.md) | pass | Define dry-run records `sol-thread` as a no-match glossary term with rationale and promotion gate. |
| [INV-DESIGN-PASS-001](fixtures/INV-DESIGN-PASS-001.md) | pass | Dry-run from approved spec, glossary, source contracts, and design constraints selects the Module Formulae architecture profile, requires all six views, emits glossary consistency and design transport outputs, and routes next to `plan`. |
| [INV-DESIGN-BLOCK-001](fixtures/INV-DESIGN-BLOCK-001.md) | pass | Dry-run with missing source contracts and no discovery approval blocks at the normal design activation gate and routes to `define` or explicit discovery-mode approval. |
| [INV-DESIGN-FLAG-001](fixtures/INV-DESIGN-FLAG-001.md) | pass | Dry-run with contradictory evidence selects the `research` companion, carries claim status into design decisions, and flags unless the ambiguity affects a required design decision, in which case it blocks. |
| [INV-DESIGN-HANDOFF-001](fixtures/INV-DESIGN-HANDOFF-001.md) | pass | Dry-run for spell and sigil targets emits handoff context only, routes lifecycle execution to `spellcraft` or `sigil-development`, and does not take lifecycle ownership. |
| [INV-INTEGRATION-DEFINE-DESIGN-001](fixtures/INV-INTEGRATION-DEFINE-DESIGN-001.md) | pass | Integration dry-run chains define output artifacts into design inputs and verifies glossary preservation, six-view design output, transport, and next route `plan`. |

## Runner Output

Command:

```bash
arcanum/spells/invoke/development/run-validation-fixtures.sh
```

Latest report:

[runs/20260517T230901Z.md](runs/20260517T230901Z.md)

Output:

```text
PASS: TEMPLATE-TASK-MATRIX
PASS: PROMPT-SELECTOR
PASS: EXAMPLE-OUTPUTS (1 checked)
PASS: INV-DEFINE-PASS-001
PASS: INV-DEFINE-BLOCK-001
PASS: INV-DEFINE-FLAG-001
PASS: INV-DEFINE-GLOSSARY-001
PASS: INV-DESIGN-PASS-001
PASS: INV-DESIGN-BLOCK-001
PASS: INV-DESIGN-FLAG-001
PASS: INV-DESIGN-HANDOFF-001
PASS: INV-INTEGRATION-DEFINE-DESIGN-001
RESULT: pass
```

The runner checks both the realistic user-request fixture files and their expected user-facing result files.

## Dry-Run Results

### INV-DESIGN-PASS-001

```markdown
## Invoke Validation Fixture Result

- Fixture: INV-DESIGN-PASS-001
- Mode: design
- Phase status: pass
- Inputs present: approved spec, approved glossary, source contracts, design constraints, define decision ledger, define transport report
- Template/profile selection: Module Formulae architecture profile plus architecture bundle
- Design views: context, high-level structure, low-level components, workflow process, decision flow, dependency interface
- Glossary consistency: pass
- Transport report: simulated design-stage append report
- Decisions: proceed from approved define outputs into plan-ready design handoff
- Unresolved gaps: none blocking
- Expected next route: plan
- Verdict: pass
```

### INV-DESIGN-BLOCK-001

```markdown
## Invoke Validation Fixture Result

- Fixture: INV-DESIGN-BLOCK-001
- Mode: design
- Phase status: block
- Inputs present: design request and goal only; source contracts missing; discovery approval missing
- Template/profile selection: none finalized
- Design views: n/a
- Glossary consistency: n/a
- Transport report: n/a
- Decisions: block normal design until source contracts exist or discovery mode is explicitly approved
- Unresolved gaps: source contracts; discovery-mode approval
- Expected next route: define
- Verdict: pass
```

### INV-DESIGN-FLAG-001

```markdown
## Invoke Validation Fixture Result

- Fixture: INV-DESIGN-FLAG-001
- Mode: design
- Phase status: flag
- Inputs present: approved spec, approved glossary, partial source contracts, contradictory architecture evidence
- Template/profile selection: Module Formulae architecture profile plus research companion
- Design views: six-view bundle may proceed only for unaffected decisions
- Glossary consistency: pass
- Transport report: simulated design-stage append report with evidence ambiguity gap
- Decisions: carry claim status into design decision log; block only if contradiction controls a required design decision
- Unresolved gaps: evidence conflict pending decision-gate or research follow-up
- Expected next route: deferred
- Verdict: pass
```

### INV-DESIGN-HANDOFF-001

```markdown
## Invoke Validation Fixture Result

- Fixture: INV-DESIGN-HANDOFF-001
- Mode: design
- Phase status: pass
- Inputs present: approved define outputs targeting spell or sigil artifact
- Template/profile selection: spell family for spell target; sigil family for sigil target
- Design views: handoff context only; lifecycle execution remains external
- Glossary consistency: pass
- Transport report: simulated handoff-ready design transport report
- Decisions: route spell execution to `spellcraft`; route sigil execution to `sigil-development`
- Unresolved gaps: none blocking
- Expected next route: spellcraft | sigil-development
- Verdict: pass
```

## Findings

1. The contract layer is coherent enough to run validation fixtures.
2. The template inventory is structurally complete for the declared candidate families.
3. Codex can discover `invoke` through the root-level `.codex/commands/arcanum-spell-invoke.md` bridge.
4. L1 design fixtures produce recorded dry-run evidence and pass.
5. The define-to-design integration fixture proves cross-stage handoff at the artifact level.

## Decision

Promote `invoke` from L1 validation to L2 planning work.

Do not register `invoke` in the spell registry yet. Registry release still requires L2/L3 plan, full, validate, examples, and release validation.

## Next Actions

1. Implement the L2 `plan` contract.
2. Extend Codex dry-run validation to `plan` low-complexity, `plan` medium/high-complexity, and blocked planning gates.
3. Keep registry release blocked until `full` and `validate` mode evidence exists.
