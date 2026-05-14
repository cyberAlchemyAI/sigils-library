# Inventory

Inventory is an Arcana sigil for installing and maintaining a repository-local compiled knowledge layer.

It is inspired by the wiki pattern: raw sources remain immutable, while an LLM-maintained markdown inventory accumulates summaries, entity pages, concept pages, architecture notes, pattern entries, contradictions, tags, indexes, and logs. The repository stops treating knowledge as something to rediscover from raw documents every time and starts treating it as a maintained asset.

## Problem It Solves

Retrieval from raw files is useful, but it does not compound. Every question asks the agent to rediscover and resynthesize knowledge from scattered sources.

Inventory solves this by creating a maintained intermediate layer between raw sources and task execution. New sources are ingested once, integrated into existing pages, cross-linked, tagged, and logged. Later sigils can query the inventory before searching the whole repository.

## Use When

- a repository accumulates knowledge across many files, docs, conversations, or source captures,
- agents repeatedly rediscover the same architecture, terminology, decisions, or patterns,
- `context-builder` needs better selector-level evidence,
- `architecture-pattern-inventory` needs a broader knowledge substrate,
- a team wants a local markdown wiki that an LLM maintains,
- raw sources should stay immutable while generated summaries evolve.

## Do Not Use When

- the repository is too small to need a maintained knowledge layer,
- raw sources are not available or cannot be cited,
- the user wants one temporary answer rather than reusable inventory,
- the repository already has a maintained inventory and only needs a narrow lookup,
- the workflow cannot tolerate generated markdown updates.

## Architecture

Inventory uses three layers:

1. Raw sources: user-curated source material that the sigil reads but does not modify.
2. Inventory wiki: generated markdown pages the sigil creates and updates.
3. Schema: local conventions that tell future agents how to ingest, tag, query, lint, and maintain the inventory.

## Default Package

The recommended install root is:

```text
.arcanum/inventory/
```

The default package contains:

```text
.arcanum/inventory/
  README.md
  schema.md
  index.md
  log.md
  tags.md
  raw/
  wiki/
  entries/
  queries/
  lint/
```

Install mode may adapt to an existing docs, wiki, notes, or architecture package instead of creating a competing structure.

## Operations

- `install`: detect existing knowledge systems, ask setup questions, and create or adapt the inventory package.
- `ingest`: read raw sources, create source summaries, update related entries, flag contradictions, and append the log.
- `lookup`: return relevant inventory pages and selectors for another sigil.
- `query`: answer against the inventory and optionally file the answer as a synthesis page.
- `lint`: find contradictions, stale claims, orphan pages, missing backlinks, untagged pages, and source coverage gaps.
- `validate`: check package structure, index coverage, log parseability, tag consistency, and evidence links.
- `backfill`: build entries from existing docs, architecture packages, context packs, decisions, or generated artifacts.
- `sync`: update package conventions after schema changes.

## Integration

[context-builder](../../transmutations/context-builder/) should consume inventory lookups before broad source search when building a task context pack.

[architecture-pattern-inventory](../architecture-pattern-inventory/) can read the inventory before mapping architecture and can contribute entries such as architecture layers, implementation patterns, dependency rules, test patterns, and observability signals.

Use the [repository observability package](../../framework/observability/REPOSITORY-PACKAGE.md) when available to record install decisions, ingests, contradictions, lint gaps, and validation results.

## Why This Is Arcana

Inventory coordinates installation, local schema design, source ingestion, cross-page maintenance, lookup contracts, linting, and integration with other sigils. It is a long-lived repository knowledge system, not a one-time synthesis artifact.