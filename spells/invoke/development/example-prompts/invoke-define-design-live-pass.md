# Invoke Example Prompt: invoke-define-design-live-pass

## Invocation

```text
arcanum-spell-invoke define and design a Mars habitat supply request module
```

## Codex Prompt

Use the Codex command adapter at `.codex/commands/arcanum-spell-invoke.md`.

Run `invoke` for this required full-revalidation live example:

- Task ID: `invoke-define-design-live-pass`
- Regime: `LIVE-DEFINE-DESIGN-001`
- Mode: define then design
- User request: Define and design a Mars habitat supply request module. Operators need to create supply requests, classify item categories, mark urgency, record approval status, preserve operator notes, and surface unresolved planning questions. Treat the define output as the only source of design authority and do not invent source contracts.
- Expected invoke use: Produce one inspectable user-facing output containing define evidence, design evidence, and the handoff relationship between them.

Return the standard `Invoke Result` shape from the canonical invoke contract.

The output must include:

- `## Invoke Result`
- a define phase section,
- a design phase section,
- `Mode: define`
- `Mode: design`
- `Phase status: pass`
- spec evidence,
- glossary evidence,
- define transport evidence,
- source contract evidence that explicitly comes from the define output,
- all six design views,
- glossary consistency,
- design transport evidence,
- next route evidence.

Also include the primary user-facing define and design artifact bodies after the `Invoke Result`. Do not collapse the artifacts into one summary line.

Important capture rule:

- Do not edit or save files yourself.
- Return only the full markdown output that should be saved.
- The outer runner will save your final response to the output path.
- Do not respond with a summary like "Saved the output to ...".

## Expected Capture Path

The outer runner saves the final response as:

```text
arcanum/spells/invoke/development/example-outputs/invoke-define-design-live-pass.output.md
```
