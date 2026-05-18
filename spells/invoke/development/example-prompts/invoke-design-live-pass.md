# Invoke Example Prompt: invoke-design-live-pass

## Invocation

```text
arcanum-spell-invoke design a Mars habitat supply request module from approved define outputs
```

## Codex Prompt

Use the Codex command adapter at `.codex/commands/arcanum-spell-invoke.md`.

Run `invoke` for this required full-revalidation live example:

- Task ID: `invoke-design-live-pass`
- Regime: `LIVE-DESIGN-001`
- Mode: `design`
- User request: Design a Mars habitat supply request module from approved define outputs. Use the approved terms supply request, item category, urgency, approval status, operator note, and unresolved planning question.
- Approved source contracts:
  - Spec: daily habitat operators submit supply requests with item category, urgency, approval status, and operator notes.
  - Glossary: supply request, item category, urgency, approval status, operator note, unresolved planning question.
  - Constraint: design mode must not create implementation tasks or mutate downstream spell/sigil contracts.
  - Transport: define outputs are approved for design consumption.
- Expected invoke use: Produce a governed design artifact with source contracts, six views, risks, dependency/interface notes, glossary consistency, design transport, and next route.

Return the standard `Invoke Result` shape from the canonical invoke contract.

The output must include:

- `## Invoke Result`
- `Mode: design`
- `Phase status: pass`
- source contracts,
- all six design views,
- dependency and interface notes,
- risks,
- glossary consistency,
- design transport evidence,
- next route evidence.

Also include the primary user-facing design artifact body after the `Invoke Result`. Do not collapse the artifact into one summary line.

Important capture rule:

- Do not edit or save files yourself.
- Return only the full markdown output that should be saved.
- The outer runner will save your final response to the output path.
- Do not respond with a summary like "Saved the output to ...".

## Expected Capture Path

The outer runner saves the final response as:

```text
arcanum/spells/invoke/development/example-outputs/invoke-design-live-pass.output.md
```
