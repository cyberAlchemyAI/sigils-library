# Context Builder

Context Builder is a Transmutation sigil for creating a compact task-ready context pack from existing project evidence.

It selects only the source excerpts needed to execute a task, maps each excerpt to a concrete obligation, and rejects context that is merely interesting. The result is a smaller, more useful bundle for agents, reviewers, or implementation sessions.

## Problem It Solves

Large repositories often bury the relevant facts under too much background material. Agents can waste time reading whole files, miss the exact obligation, or carry unrelated context into the task.

Context Builder solves this by using link-first retrieval, selector-level evidence, obligation coverage, and noise limits.

## Use When

- a task needs a focused evidence pack before execution,
- requirements, architecture notes, code snippets, tests, and decisions are scattered,
- a later agent or reviewer should not reread the whole repository,
- the task has explicit obligations or completion criteria,
- context size must stay bounded.

## Do Not Use When

- the task is simple enough to execute directly,
- no source material exists,
- the user wants a broad codebase map rather than task context,
- the work requires autonomous orchestration rather than bounded synthesis,
- selected excerpts cannot be linked to concrete obligations.

## Output

The sigil produces a context pack with:

- target task,
- obligation matrix,
- selected excerpts,
- selectors or anchors,
- obligation coverage,
- excluded candidates,
- unresolved gaps,
- optional machine-readable index.

## Why This Is A Transmutation

Context Builder transforms scattered project material into a bounded, evidence-linked artifact. It requires judgment, but the output is a concrete context package rather than a long-running orchestration loop.