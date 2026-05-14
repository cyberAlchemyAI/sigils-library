---
name: inventory
description: "Use when: installing or maintaining a repository-local compiled knowledge inventory that lets agents ingest once, index, tag, query, lint, and reuse context across sigils."
argument-hint: "<install|ingest|lookup|query|lint|validate|backfill|sync> [--path <repo-root>] [--root <inventory-root>] [--source <path>] [--type <entry-type>] [--query <text>] [--dry-run]"
tier: arcana
domain: knowledge-inventory
version: 0.1.0
origin: generalized from recurring inventory and compiled-wiki maintenance practice
allowed-tools: Read, Write, Glob, Grep, Bash, AskQuestions, Task
---

# Sigil: Inventory

<objective>
Install and maintain a repository-local compiled knowledge layer that keeps raw sources immutable, generated inventory pages current, and reusable context available to other sigils.
</objective>

<logic-type>
Arcana: long-lived knowledge maintenance, local schema governance, ingestion, linting, and cross-sigil integration.
</logic-type>

<core-promise>
Inventorize once, reuse many times.
</core-promise>

<modes>
- `install`: create or adapt the local inventory package.
- `ingest`: process raw sources into generated inventory pages.
- `lookup`: return matching entries and selectors for another sigil.
- `query`: answer from inventory pages and optionally file the answer as a synthesis page.
- `lint`: health-check contradictions, staleness, orphans, missing links, tags, and source coverage.
- `validate`: check package structure, index coverage, log parseability, tag consistency, and evidence links.
- `backfill`: build inventory entries from existing repository artifacts.
- `sync`: update inventory files after schema or convention changes.
</modes>

<default-package>
Use `.arcanum/inventory/` unless the user chooses an existing docs, wiki, or knowledge-base location.

Default layout:

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
</default-package>

<install-process>
1. Detect existing repository knowledge systems before asking questions:
   - docs folders,
   - wiki or notes folders,
   - architecture packages,
   - existing indexes,
   - generated context packs,
   - decision records,
   - observability packages.
2. Ask only unanswered setup questions:
   - inventory root path,
   - raw source location,
   - generated wiki or entry location,
   - whether existing docs should be adopted or left separate,
   - tagging style,
   - frontmatter preference,
   - wiki-link preference,
   - source immutability policy,
   - observability integration preference.
3. Create or adapt the inventory package from templates.
4. Record the local schema and selected conventions.
5. Append an install entry to the log.
6. Return the package path, selected conventions, and next recommended ingest.
</install-process>

<ingest-process>
1. Resolve source path or source set.
2. Confirm raw sources are read-only inputs.
3. Read each source and extract reusable knowledge:
   - source summary,
   - entities,
   - concepts,
   - decisions,
   - workflows,
   - architecture layers,
   - implementation patterns,
   - interfaces,
   - dependency rules,
   - test patterns,
   - observability signals,
   - contradictions,
   - open questions.
4. Create or update generated inventory pages.
5. Link related entries and update backlinks when the local schema uses them.
6. Flag contradictions and stale claims instead of silently overwriting them.
7. Update `index.md`, `tags.md`, and `log.md`.
8. Emit observability signals when the observability package exists.
</ingest-process>

<lookup-process>
1. Read `index.md` first.
2. Search entries by type, tag, source, title, summary, and query text.
3. Return selector-level matches suitable for downstream sigils.
4. Include why each match is relevant and which task or obligation it can satisfy.
5. Report gaps when inventory does not cover the requested topic.
</lookup-process>

<query-process>
1. Resolve the question and search the inventory index first.
2. Read relevant generated pages and their source references.
3. Synthesize an answer with citations to inventory pages and raw source references when available.
4. Ask whether the answer should be filed as a synthesis page when it has durable value.
5. If filed, update index, tags, and log.
</query-process>

<lint-process>
Check for:

- contradictions between pages,
- stale claims superseded by newer sources,
- orphan pages with no incoming or outgoing links,
- important concepts mentioned but lacking pages,
- missing cross-references,
- untagged pages,
- invalid frontmatter when frontmatter is enabled,
- raw sources not yet inventoried,
- generated pages without source coverage,
- log entries that do not match the configured heading pattern.
</lint-process>

<entry-types>
Default entry types:

- `source`,
- `entity`,
- `concept`,
- `architecture-layer`,
- `implementation-pattern`,
- `decision`,
- `capability`,
- `workflow`,
- `interface`,
- `dependency-rule`,
- `test-pattern`,
- `observability-signal`,
- `question`,
- `contradiction`,
- `synthesis`.

Repositories may add custom entry types in `schema.md` when they define required fields, evidence rules, tag rules, and update behavior.
</entry-types>

<integration-contract>
For `context-builder`, lookup output should include:

- inventory page path,
- selector or heading,
- summary,
- tags,
- confidence,
- source references,
- task obligation fit,
- unresolved gaps.

For `architecture-pattern-inventory`, inventory output should support entries for:

- architecture layers,
- implementation patterns,
- dependency rules,
- test patterns,
- observability signals,
- relationship notes.
</integration-contract>

<authority-rule>
Raw sources are read-only inputs. Generated inventory pages may evolve, but every material claim should point back to source evidence or be marked as inference, synthesis, or open question.
</authority-rule>

<observability>
When `.arcanum/observability/` exists, emit post-run signals for:

- mode,
- install decisions,
- source count,
- entries created,
- entries updated,
- contradictions found,
- lint gaps,
- validation result,
- downstream sigil lookups,
- filed query syntheses.
</observability>

<quality-bar>
A successful execution must:

- preserve raw source immutability,
- create or respect a local schema,
- maintain both `index.md` and `log.md`,
- tag generated pages consistently,
- link generated knowledge to source evidence,
- flag contradictions instead of hiding them,
- expose lookup results that other sigils can consume,
- avoid creating a competing system when a repository already has a usable wiki or inventory.
</quality-bar>

<anti-patterns>
Avoid:

- editing raw sources during ingest,
- making generated pages the sole authority for source facts,
- dumping source summaries without updating related pages,
- creating tags ad hoc without recording them,
- answering queries from raw files while ignoring the inventory,
- overwriting contradictions instead of recording them,
- installing a new package when existing repository conventions can be adapted,
- letting inventory maintenance replace human source curation.
</anti-patterns>

<output-contract>
Return:

```markdown
## Inventory Result

- Mode: install | ingest | lookup | query | lint | validate | backfill | sync
- Repository: <path>
- Inventory root: <path>
- Files changed: <paths or none>
- Sources processed: <count>
- Entries created: <count>
- Entries updated: <count>
- Index updated: yes | no
- Log updated: yes | no
- Contradictions flagged: <count>
- Lint gaps: <count>
- Validation: pass | fail | not run
- Downstream lookup output: <summary or none>
- Next action: <action>
```
</output-contract>