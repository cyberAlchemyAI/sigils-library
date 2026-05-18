# Invoke Experiment Regimes

This document is the human-readable control sheet for revalidating the implemented `invoke` scope.

The experiment validates:

- `define` as a standalone phase,
- `design` as a standalone phase,
- `define -> design` as an integration chain,
- Quality Bar and Anti-Pattern behavior,
- required live Codex execution for the current implemented scope.

Generated evidence belongs under ignored folders:

- `development/example-outputs/`
- `development/example-runs/`
- `development/experiment-loops/`
- `development/runs/`

Durable evidence belongs under tracked fixtures, prompts, and future loop regime files:

- `development/fixtures/`
- `development/example-prompts/`
- `development/regimes/`
- this regimes document.

## Command Sequence

Run deterministic controls first. These are controls, not promotion evidence:

```bash
arcanum/spells/invoke/development/run-validation-fixtures.sh
arcanum/arcana/experiment-harness/scripts/validate-harness.sh arcanum/spells/invoke
```

Then run the live regimes as the blocking promotion evidence:

```bash
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-DEFINE-001
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-DESIGN-001
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-DEFINE-DESIGN-001
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-OBSERVABILITY-001
```

Direct single-run Codex prompts remain useful for development smoke tests:

```bash
RERUN=1 arcanum/spells/invoke/development/run-template-example-with-codex.sh invoke-define-live-pass
RERUN=1 arcanum/spells/invoke/development/run-template-example-with-codex.sh invoke-design-live-pass
RERUN=1 arcanum/spells/invoke/development/run-template-example-with-codex.sh invoke-define-design-live-pass
```

Finally emit observability from the latest live loop report:

```bash
latest_report="$(find arcanum/spells/invoke/development/experiment-loops -name loop-report.md | sort | tail -n 1)"
arcanum/arcana/experiment-harness/scripts/observe-harness.sh arcanum/spells/invoke "$latest_report"
```

The observer telemetry must include:

- `quality_bar_status`,
- `anti_pattern_hits`,
- `workflow_gaps`,
- `reflection_trigger`.

## CTRL-DEFINE-001: Define Phase Control

Goal: prove `invoke define` handles useful, missing, unsupported, and glossary-sensitive input shapes.

Inputs:

- `fixtures/INV-DEFINE-PASS-001.md`
- `fixtures/INV-DEFINE-BLOCK-001.md`
- `fixtures/INV-DEFINE-FLAG-001.md`
- `fixtures/INV-DEFINE-GLOSSARY-001.md`

Expected outputs:

- `INV-DEFINE-PASS-001.expected.md` returns `Phase status: pass`.
- `INV-DEFINE-BLOCK-001.expected.md` returns `Phase status: block`.
- `INV-DEFINE-FLAG-001.expected.md` returns `Phase status: flag`.
- `INV-DEFINE-GLOSSARY-001.expected.md` records no-match glossary promotion as gated.

Pass criteria:

- missing core goal blocks,
- candidate template creation flags when unapproved,
- glossary promotion is never automatic,
- define transport evidence is present.

Failure examples:

- vague input passes without naming missing scope,
- unsupported template is promoted silently,
- new glossary terms are treated as approved definitions.

Evidence paths:

- tracked expected outputs in `development/fixtures/`,
- generated control report in `development/runs/`.

## CTRL-DESIGN-001: Design Phase Control

Goal: prove `invoke design` consumes approved define outputs and produces a governed six-view design bundle.

Inputs:

- `fixtures/INV-DESIGN-PASS-001.md`
- `fixtures/INV-DESIGN-BLOCK-001.md`
- `fixtures/INV-DESIGN-FLAG-001.md`
- `fixtures/INV-DESIGN-HANDOFF-001.md`

Expected outputs:

- pass when approved spec, glossary, source contracts, and constraints exist,
- block when source contracts are missing and discovery mode is not approved,
- flag or block when contradictory evidence controls a design decision,
- hand off spell and sigil lifecycle work to `spellcraft` or `sigil-development`.

Pass criteria:

- all six design views are represented,
- glossary consistency is explicit,
- dependency/interface notes and risks are present,
- design mode does not create work-pack tasks,
- downstream spell/sigil contracts are not mutated from design mode.

Failure examples:

- missing source contracts are treated as approved,
- design silently performs deferred `plan` or `full` behavior,
- design edits spell or sigil contracts instead of producing handoff context.

Evidence paths:

- tracked expected outputs in `development/fixtures/`,
- generated control report in `development/runs/`.

## CTRL-INTEGRATION-001: Define To Design Control

Goal: prove design consumes define artifacts without inventing upstream authority.

Input:

- `fixtures/INV-INTEGRATION-DEFINE-DESIGN-001.md`

Expected outputs:

- define expected output names spec, glossary, and define transport artifacts,
- design expected output names architecture, glossary consistency, and design transport artifacts,
- architecture preserves define glossary terms,
- design routes next to `plan`.

Pass criteria:

- design consumes the approved define output,
- glossary terms remain consistent,
- unresolved define gaps remain visible,
- design emits six views and transport evidence.

Failure examples:

- design introduces source contracts not present in define evidence,
- design removes glossary uncertainty,
- design routes to implementation without `plan`.

Evidence paths:

- tracked integration fixture bundle in `development/fixtures/`,
- generated control report in `development/runs/`.

## CTRL-CONTRACT-001: Quality Bar And Anti-Patterns Control

Goal: prove experiment validation distinguishes real success from polished-looking boundary violations.

Input:

- `fixtures/INV-QUALITY-ANTI-PATTERN-001.md`

Expected output:

- `fixtures/INV-QUALITY-ANTI-PATTERN-001.expected.md`

Pass criteria:

- pass, partial, and fail Quality Bar classifications are represented,
- Anti-Pattern hits can flag or block,
- expected telemetry fields are present.

Failure examples:

- save-summary output passes,
- output claims pass while naming missing required source contracts,
- anti-pattern hits are not exposed to observer telemetry.

Evidence paths:

- tracked quality fixture and expected output,
- generated report machine summary.

## LIVE-DEFINE-001: Live Codex Define Loop

Goal: prove a real Codex execution produces a user-facing `Invoke Result` for define mode.

Input:

- `example-prompts/invoke-define-live-pass.md`

Command:

```bash
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-DEFINE-001
```

Expected output:

- `example-outputs/invoke-define-live-pass.output.md`

Pass criteria:

- output contains `## Invoke Result`,
- output contains `Mode: define`,
- output contains `Phase status: pass`,
- output includes spec, glossary, define transport, and next route evidence,
- output is not a save-summary.

Failure examples:

- Codex CLI unavailable,
- output missing or empty,
- output says only that a file was saved,
- output lacks spec or glossary evidence.

## LIVE-DESIGN-001: Live Codex Design Loop

Goal: prove a real Codex execution produces a governed design artifact from approved define/source-contract inputs.

Input:

- `example-prompts/invoke-design-live-pass.md`

Command:

```bash
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-DESIGN-001
```

Expected output:

- `example-outputs/invoke-design-live-pass.output.md`

Pass criteria:

- output contains `## Invoke Result`,
- output contains `Mode: design`,
- output contains `Phase status: pass`,
- output includes source contracts,
- output includes six design views,
- output includes risks, dependency/interface notes, glossary consistency, design transport, and next route evidence,
- output is not a save-summary.

Failure examples:

- design proceeds without approved inputs,
- output omits one or more design views,
- output mutates downstream spell/sigil contracts,
- output creates work-pack tasks.

## LIVE-DEFINE-DESIGN-001: Live Codex Define To Design Loop

Goal: prove a real Codex execution can produce an inspectable define-to-design chain in one output.

Input:

- `example-prompts/invoke-define-design-live-pass.md`

Command:

```bash
arcanum/arcana/experiment-harness/scripts/loop-harness.sh arcanum/spells/invoke LIVE-DEFINE-DESIGN-001
```

Expected output:

- `example-outputs/invoke-define-design-live-pass.output.md`

Pass criteria:

- output contains `## Invoke Result`,
- output contains define and design phase sections,
- define section includes spec, glossary, and define transport evidence,
- design section includes approved source contract references, six views, glossary consistency, design transport, and next route,
- output states that design consumes define outputs instead of inventing approvals.

Failure examples:

- design output does not reference define artifacts,
- source contracts are invented or silently approved,
- output collapses the chain into a summary instead of real artifacts.

## LIVE-OBSERVABILITY-001: Live Observability Loop

Goal: prove the experiment harness can close the loop through telemetry and hook ledgers.

Input:

- latest loop report from one of the live regimes,
- repository observability package under `.arcanum/observability/`.

Command:

```bash
latest_report="$(find arcanum/spells/invoke/development/experiment-loops -name loop-report.md | sort | tail -n 1)"
arcanum/arcana/experiment-harness/scripts/observe-harness.sh arcanum/spells/invoke "$latest_report"
```

Pass criteria:

- capability telemetry includes `quality_bar_status`, `anti_pattern_hits`, `workflow_gaps`, and `reflection_trigger`,
- hook operation rows are recorded with `observe: false`,
- duplicate observer emissions are skipped,
- observer failures do not mutate generated outputs.
