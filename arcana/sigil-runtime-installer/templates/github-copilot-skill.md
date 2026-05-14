---
name: {command}
description: Route Arcanum requests to the canonical sigil and spell registry.
argument-hint: "<natural-language-arcanum-request>"
allowed-tools: Read, Glob, Grep, AskQuestions, Task
---

# Arcanum Orchestrate

<objective>
Route a user request to the appropriate Arcanum sigil or spell by reading the canonical registry and following the selected artifact's instructions.
</objective>

<process>
1. Resolve the repository root and Arcanum registry path.
2. Read the Sigil Registry and Spell Registry.
3. Classify the request as sigil usage, spell usage, install/setup, authoring, validation, or help.
4. Read the selected canonical `README.md` and `SKILL.md` or spell file.
5. Follow the selected artifact's process without copying unrelated sigil internals.
6. Return the selected route, files used, validation result, and next action.
</process>