# Invoke Example Prompt: research-low

## Invocation

```text
arcanum-spell-invoke Compare two payment tax API docs and identify which claims are verified.
```

## Codex Prompt

Use the Codex command adapter at `.codex/commands/arcanum-spell-invoke.md`.

Run `invoke` for this template validation example:

- Task ID: `research-low`
- Template target: `research`
- Complexity: `low`
- User request: Compare two payment tax API docs and identify which claims are verified.
- Expected invoke use: Emit research brief with evidence table and gaps.

Return the standard `Invoke Result` shape from the canonical invoke contract. If the requested mode is deferred, return the deferred gate and expected next action instead of pretending execution is implemented.

Also include the primary user-facing artifact body for the selected template target after the `Invoke Result`. Do not collapse the artifact into one summary line.

Template artifact requirements:

- For `architecture`, include an `## Architecture Plan` artifact with source contracts, View 1 through View 6, dependency/interface rules, decision log, risks, downstream planning notes, design transport notes, and gate result.
- For `research`, include a research brief with claims, evidence, conflicts, gaps, and gate result.
- For `spell`, include spellcraft handoff context with phases, gates, handoff artifacts, observability, and next route.
- For `sigil`, include sigil-development handoff context with inputs, outputs, quality bar, anti-patterns, observability, and next route.
- For `ux-plan`, include UX plan artifact with actors, flows, states, content/accessibility notes, risks, and handoff notes.
- For `implementation-plan`, `implementation-layering`, and `work-pack`, include the relevant planning artifact body, or clearly block/flag if the current invoke mode is deferred.

Important capture rule:

- Do not edit or save files yourself.
- Return only the full markdown output that should be saved.
- The outer runner will save your final response to the output path.
- Do not respond with a summary like "Saved the output to ...".

## Expected Capture Path

The outer runner saves the final response as:

```text
arcanum/spells/invoke/development/example-outputs/research-low.output.md
```
