# Necronomicon Session

## Identity

- Canonical ID: `necronomicon-session`
- Primary alias: `Necronomicon Session`
- Aliases: `Repository Harness Session`, `Ontology Session`
- Scope: library

## Purpose

Necronomicon Session creates or resumes a repository-local harness session that keeps durable working memory, selected Arcanum capabilities, routing history, decisions, and handoff artifacts together.

The spell makes Necronomicon the operational harness for a repository without turning `.arcanum/necronomicon/` back into a copied sigil or spell definition store. Runtime commands remain the local execution surface. Necronomicon session state records what was selected, why a route was chosen, which fallback candidates were offered, and what memory should survive between agent turns or future sessions.

## Trigger Conditions

- A user asks to start, create, resume, close, or maintain a Necronomicon session.
- Repository work needs durable memory across repeated agent interactions.
- A request should route first through selected repository-local sigils or spells.
- A selected capability is missing and the user wants fallback suggestions from Arcanum.
- Repeated route misses suggest that the repository harness should add, remove, or refresh capabilities.

## Required Sigils And Spells

| Artifact | Role In Spell | Required Mode |
| -------- | ------------- | ------------- |
| `ontology-harness` | Provide the Necronomicon ontology, session distillation, premise review, branch mapping, and bridge validation contract. | direct or delegated |
| `inventory` | Track repository knowledge entries and capability evidence when inventory exists. | lookup, ingest, validate |
| `context-builder` | Build compact context packs for session resume, routing, and evidence retrieval. | lean, standard, or deep |

## Recommended Capabilities

| Capability | Use When | Notes |
| ---------- | -------- | ----- |
| `task-session` | A routed request resolves to one bounded implementation or documentation task. | Use for scoped execution with decisions and gates. |
| `decision-gate` | Capability updates, ontology promotions, or route ambiguity require user choice. | Ask only consequential questions. |
| `observability-setup` | Repository-local telemetry paths need initialization or verification. | Keep runtime telemetry under `.arcanum/observability/`. |
| `sigil-runtime-installer` | Selected capabilities need generated runtime command adapters. | Use for add, remove, or refresh operations. |

## Optional Capabilities

| Capability | Use When | Notes |
| ---------- | -------- | ----- |
| `ontology-vault` | Session memory needs ontology distillation, premise review, confidence promotion, or bridge validation. | Usually present through `ontology-harness`. |
| `architecture-pattern-inventory` | Routing or ontology branches depend on repository structure. | Useful for system/runtime branches. |
| `feature-glossary` | The session needs plain-language concept summaries. | Explanatory, not authoritative. |
| `signal-observer` | Route misses or session outcomes should become maintenance signals. | Use after meaningful runs. |
| `workflow-reflect` | Accumulated signals should propose capability improvements. | Use after several sessions. |
| `spellcraft` | A repeated session pattern should become a reusable spell. | Use for composition design. |
| `sigil-development` | A missing behavior should become a reusable sigil. | Use for new capability authoring. |

## Modes

| Mode | Purpose | Primary Outputs |
| ---- | ------- | --------------- |
| `start` | Create a new repository harness session. | session folder, memory seed, capability manifest reference |
| `resume` | Continue from existing memory, decisions, and route history. | refreshed context summary, next action |
| `route` | Route a user request through selected Necronomicon capabilities. | selected command, route record, result summary |
| `update-capabilities` | Add, remove, or refresh selected sigils and spells. | capability update report, regenerated runtime command plan |
| `fallback-discover` | Offer Arcanum registry candidates when no selected capability matches. | candidate list, user decision, optional update path |
| `close` | Write final memory, decisions, route summary, and handoff. | handoff artifact, observability summary |

## Prerequisites

- Repository root is known.
- Arcanum runtime support is installed or the user approves installation.
- `.arcanum/observability/` exists or can be initialized.
- The active runtime command surface is known when command execution is requested.

## Shared State

| State | Owner | Updated By | Consumed By |
| ----- | ----- | ---------- | ----------- |
| `.arcanum/necronomicon/README.md` | repository | bootstrap or session spell | user, local agents |
| `.arcanum/necronomicon/capabilities.json` | repository | bootstrap, capability update flow | session router |
| `.arcanum/necronomicon/sessions/<session-id>/SESSION.md` | session | session spell | user, resume flow |
| `.arcanum/necronomicon/sessions/<session-id>/memory.md` | session | session spell, close flow | resume flow, router |
| `.arcanum/necronomicon/sessions/<session-id>/routes.jsonl` | session | route flow | resume flow, signal observer |
| `.arcanum/necronomicon/sessions/<session-id>/decisions.md` | session | decision gate, session spell | resume flow, user |
| `.arcanum/necronomicon/sessions/<session-id>/handoff.md` | session | close flow | future sessions |
| `.arcanum/necronomicon/capability-updates/` | repository | update-capabilities flow | bootstrap, sigil-runtime-installer |
| `.arcanum/observability/` | repository | session spell and routed commands | reflection workflows |

## Execution Phases

| Phase | Capability | Input | Output | Gate | Failure Policy |
| ----- | ---------- | ----- | ------ | ---- | -------------- |
| 1 | session setup | repository root, requested mode | active session ID | one session resolved | ask if multiple active sessions exist |
| 2 | capability load | `capabilities.json`, runtime folders | selected command surface | selected capabilities are readable | flag stale entries |
| 3 | memory load | `memory.md`, `decisions.md`, recent routes | compact session context | memory source cited | start fresh if no prior memory exists |
| 4 | request classification | user request, session context | route candidates | explicit route wins | ask on tied medium/high confidence routes |
| 5 | selected routing | selected capabilities | chosen local command | command adapter exists | fallback discover when no selected match exists |
| 6 | fallback discover | Arcanum registry or embedded command surface | 2-5 candidate capabilities | user accepts before expansion | return block when no candidate is credible |
| 7 | execution handoff | chosen command | routed result | chosen command contract followed | report partial if command cannot run |
| 8 | route ledger | route result | `routes.jsonl` entry | JSON line is valid | flag if telemetry cannot be written |
| 9 | memory update | result, decisions, outputs | updated `memory.md` and `decisions.md` | durable changes summarized | defer if user requests no mutation |
| 10 | close or continue | session status | handoff or next action | blockers named | leave session resumable |

## Routing Rules

1. Load the active session memory, decisions, route history, and capability manifest before routing.
2. Prefer explicit runtime command names, exact spell IDs, exact sigil IDs, and exact aliases.
3. Route start, create, resume, close, memory, handoff, capability update, or fallback discovery requests to this spell.
4. Route ontology, vault, premise, confidence, convention, branch map, session distillation, and bridge validation requests to `ontology-harness` or `arcanum-necronomicon`.
5. Route one bounded task with done criteria to `task-session` when selected.
6. Route compact evidence or context pack requests to `context-builder` when selected.
7. If no selected route matches, inspect installed command surfaces and canonical Arcanum registries when available.
8. Offer 2-5 fallback sigils or spells with the reason each candidate may fit.
9. Ask before adding fallback candidates to the Necronomicon capability manifest.
10. Record every route attempt in `routes.jsonl` with request summary, candidates, selected route, confidence, fallback use, result, validation, and follow-up.

## Route Confidence

| Confidence | Meaning |
| ---------- | ------- |
| high | Explicit command name, exact canonical ID, or exact alias. |
| medium | Selected capability trigger, description, or mode strongly matches the request. |
| low | Fallback registry candidate may fit but is not selected in the session. |
| block | No credible selected or fallback route exists. |

Ask one focused clarification when multiple medium or high routes tie.

## Capability Update Flow

1. Read `.arcanum/necronomicon/capabilities.json` and the installed runtime command folders.
2. Identify stale selected entries, missing adapters, new available Arcanum registry entries, and repeated route misses.
3. Present add, remove, refresh, or author options.
4. Use `sigil-runtime-installer` or bootstrap to regenerate runtime commands when installation changes are approved.
5. Use `spellcraft` or `sigil-development` when the needed behavior does not exist yet.
6. Write a report under `.arcanum/necronomicon/capability-updates/`.
7. Update session memory and route future matching through the new capability set.

## Local Customization

- Harness root: `.arcanum/necronomicon/`
- Session root: `.arcanum/necronomicon/sessions/`
- Capability manifest: `.arcanum/necronomicon/capabilities.json`
- Runtime adapter root: `.arcanum/runtimes/`
- Observability root: `.arcanum/observability/`
- Default memory strictness: standard
- Default fallback policy: ask-before-add
- Default session ID format: timestamp plus slug, for example `2026-05-14-sonar-loop-routing`

## Guardrails

- Do not copy canonical sigil or spell definition folders into `.arcanum/necronomicon/`.
- Do not make session memory authoritative over source documents, registries, or implementation evidence.
- Do not add fallback capabilities silently.
- Do not mark a route successful if the selected command was unavailable or its validation failed.
- Keep durable memory concise and resumable; avoid storing raw full chat transcripts unless the user explicitly requests that.
- Preserve unrelated local runtime commands and discovery bridges.

## Observability

Record session-level telemetry when `.arcanum/observability/` exists:

- spell name,
- mode,
- session ID,
- selected capability count,
- request classification,
- route confidence,
- selected command,
- fallback candidates offered,
- capability updates proposed or applied,
- files changed,
- validation result,
- blockers,
- follow-up actions.

## Output Contract

Return:

```markdown
## Spell Result

- Spell: Necronomicon Session
- Canonical ID: necronomicon-session
- Mode: start | resume | route | update-capabilities | fallback-discover | close
- Repository: <path>
- Session ID: <id>
- Capabilities loaded: <count>
- Route: <selected command or none>
- Confidence: high | medium | low | block
- Fallback offered: yes | no
- Files updated: <paths or none>
- Validation: <checks>
- Follow-up: <items or none>
```