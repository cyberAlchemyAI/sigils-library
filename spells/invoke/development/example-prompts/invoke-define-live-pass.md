# Invoke Example Prompt: invoke-define-live-pass

## Invocation

```text
arcanum-spell-invoke define a small Mars habitat supply request module before architecture work begins
```

## Codex Prompt

Use the Codex command adapter at `.codex/commands/arcanum-spell-invoke.md`.

Run `invoke` for this required full-revalidation live example:

- Task ID: `invoke-define-live-pass`
- Regime: `LIVE-DEFINE-001`
- Mode: `define`
- User request: Define a small Mars habitat supply request module before architecture work begins. Operators need to submit daily supply requests, identify item category and urgency, track approval status, and leave unresolved questions for later planning. Keep implementation work out of scope.
- Expected invoke use: Produce governed define output from vague but usable intent.

Return the standard `Invoke Result` shape from the canonical invoke contract.

The output must include:

- `## Invoke Result`
- `Mode: define`
- `Phase status: pass`
- spec artifact evidence,
- glossary artifact evidence,
- define transport evidence,
- decisions,
- unresolved gaps,
- next route evidence.

Also include the primary user-facing define artifact body after the `Invoke Result`. Do not collapse the artifact into one summary line.

Important capture rule:

- Do not edit or save files yourself.
- Return only the full markdown output that should be saved.
- The outer runner will save your final response to the output path.
- Do not respond with a summary like "Saved the output to ...".

## Expected Capture Path

The outer runner saves the final response as:

```text
arcanum/spells/invoke/development/example-outputs/invoke-define-live-pass.output.md
```
