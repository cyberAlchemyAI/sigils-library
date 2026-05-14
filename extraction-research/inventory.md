# Extraction Research Note: inventory

## Reusable Core

- Maintain a persistent repository-local knowledge inventory so later agents do not rediscover the same facts every run.
- Keep raw sources immutable and separate from generated inventory pages.
- Compile source knowledge into markdown pages with links, tags, evidence, contradictions, and update history.
- Maintain an index for content lookup and a log for chronological operations.
- Support install, ingest, lookup, query, lint, validate, backfill, and sync workflows.
- Let other sigils consume the inventory as a structured knowledge layer.

## Private Coupling Risk

- Source inventory workflows can assume fixed project documents, command routes, experiment structures, or private taxonomy.
- Capability and architecture rows can overfit to a single repository's execution pipeline.
- Research inventory patterns can overfit to paper/source catalogs instead of any repository context.

## Neutral Rewrite Strategy

- Express the sigil as a generic compiled wiki and inventory layer for any repository.
- Make install mode detect existing docs, wikis, indexes, architecture packages, and observability packages before creating new files.
- Use configurable local schema and entry types rather than fixed private artifact names.
- Make raw sources read-only by policy and generated inventory pages LLM-maintained.
- Define inventory lookup outputs that `context-builder` and `architecture-pattern-inventory` can consume without owning inventory maintenance.

## Proposed Tier

- arcana

## Extraction Decision

- Decision: rewrite
- Rationale: the reusable behavior is valuable, but it must be reframed as a portable repository-local knowledge harness rather than a specialized internal inventory.

## Minimum Safe Sigil

- An `inventory` sigil that installs or adapts a local `.arcanum/inventory/` package, ingests immutable sources into generated markdown pages, maintains index and log files, supports tagging and linting, and exposes lookup results for other sigils.