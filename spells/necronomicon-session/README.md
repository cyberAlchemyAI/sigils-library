# Necronomicon Session

## Identity

- Canonical ID: `necronomicon-session`
- Primary alias: `Necronomicon Session`
- Aliases: `Repository Harness Session`, `Ontology Session`
- Scope: library

## Purpose

Necronomicon Session creates, resumes, and maintains a repository-local harness session with explicit setup profiles, durable working memory, routing history, checkpoints, bounded research workflows (repository and web), and maintenance recommendations.

The spell makes Necronomicon the project harness shell for a repository without turning `.arcanum/necronomicon/` into a copied canonical definition store. Runtime adapters remain the first-pass execution surface. Session state records what was selected, why a route was chosen, which fallback candidates were offered, what unresolved gaps remain, and what should persist between turns and sessions.

## Trigger Conditions

- A user asks to start, create, resume, close, or maintain a Necronomicon session.
- A user asks to run setup, checkpoint, research, or implementation-research through the harness.
- Repository work needs durable memory across repeated agent interactions.
- A request should route first through selected repository-local sigils or spells.
- A selected capability is missing and the user wants fallback suggestions from Arcanum.
- Repeated route misses suggest that the repository harness should add, remove, or refresh capabilities.

## Setup Profiles

| Profile                   | Primary Intent                                                          | Default Outcome                                              |
| ------------------------- | ----------------------------------------------------------------------- | ------------------------------------------------------------ |
| `basic-inventory`         | Lightweight harness for reusable repository memory and routing.         | Enables inventory-first setup with route/memory baseline.    |
| `ontology-harness`        | Harness with ontology governance and business/system bridge validation. | Adds ontology-vault flows and related dependencies.          |
| `research`                | Bounded evidence gathering with synthesis checkpoints.                  | Enables research policy and optional robot-talks escalation. |
| `implementation-research` | Discovery-first implementation planning before execution.               | Enables project-scoped implementation-research handoffs.     |
| `custom`                  | User-shaped capability mix with explicit trade-off decisions.           | Enables selective capabilities with dependency auto-adds.    |

Profiles are composable. Treat `basic-inventory` or `ontology-harness` as the base profile, then layer `research` and/or `implementation-research` as overlays when needed.

| Composition                                             | Expected Behavior                                                                               |
| ------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `basic-inventory + research`                            | Inventory-first bounded research with optional web escalation.                                  |
| `ontology-harness + research`                           | Ontology-grounded bounded research using inventory, ontology outputs, and optional web sources. |
| `basic-inventory + implementation-research`             | Implementation discovery handoff using inventory/context and invoke lifecycle routing.          |
| `ontology-harness + implementation-research`            | Implementation discovery handoff with ontology constraints and invoke lifecycle routing.        |
| `ontology-harness + research + implementation-research` | Full discovery stack with ontology-grounded research and implementation handoff readiness.      |

## Dependency Rules

1. Selecting `necronomicon-session` for human-gated setup, checkpoint review, research clarification, or maintenance decisions requires `structured-interview-kits`.
2. Selecting `ontology-vault` auto-adds `inventory` and `context-builder`.
3. Selecting `ontology-harness` auto-adds `ontology-vault`, `inventory`, and `context-builder`.
4. `research` may recommend `robot-talks` only as escalation for cross-layer contradictions.
5. `implementation-research` requires a research project scope and handoff target before execution routing.
6. Any auto-added dependency must be written into capability update records and setup decisions.
7. `observability-setup`, `signal-observer`, and `workflow-reflect` are required for Necronomicon telemetry, signal capture, and maintenance reflection.
8. `spellcraft` and `sigil-development` are required authoring paths for approved maintenance outcomes.
9. `invoke` is the required lifecycle authoring spell for implementation-research handoffs and define/design/plan/full/validate requests when installed.
10. `research` and `implementation-research` are composable overlays and are not mutually exclusive with `basic-inventory` or `ontology-harness`.
11. When `implementation-research` is selected without `research`, Necronomicon should request missing research scope inputs and continue with a constrained implementation-research handoff.
12. When `ontology-harness` is active, research and implementation-research flows must use ontology outputs before relying on external web sources.
13. `maintain` mode must aggregate signals from all selected sigils and spells, not only route-level telemetry.
14. `sigil-maintenance-loop` is required for cross-sigil maintenance synthesis when available in the installed spell surface.

## Required Sigils And Spells

| Artifact                    | Role In Spell                                                                                                            | Required Mode                                                                             |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- |
| `ontology-harness`          | Provide the Necronomicon ontology, session distillation, premise review, branch mapping, and bridge validation contract. | direct or delegated                                                                       |
| `inventory`                 | Track repository knowledge entries and capability evidence when inventory exists.                                        | lookup, ingest, validate                                                                  |
| `context-builder`           | Build compact context packs for session resume, routing, and evidence retrieval.                                         | lean, standard, or deep                                                                   |
| `structured-interview-kits` | Provide one-question setup and decision interview modes for human-gated Necronomicon flows.                              | setup-profile, gap-check, checkpoint-review, research-clarification, maintenance-decision |
| `observability-setup`       | Initialize and validate repository-local telemetry paths used by Necronomicon.                                           | setup, validate, maintain                                                                 |
| `signal-observer`           | Capture route misses, outcomes, and quality gaps as structured maintenance signals.                                      | post-route, maintain                                                                      |
| `workflow-reflect`          | Analyze accumulated signals into evidence-backed maintenance recommendations.                                            | maintain, closeout                                                                        |
| `spellcraft`                | Author or revise local and reusable spells from approved maintenance recommendations.                                    | maintain, compose                                                                         |
| `sigil-development`         | Author or revise local and reusable sigils from approved maintenance recommendations.                                    | maintain, author                                                                          |
| `sigil-maintenance-loop`    | Consolidate and prioritize cross-sigil maintenance actions from accumulated signal evidence.                             | maintain, reflect                                                                         |
| `invoke`                    | Provide unified define/design/plan/full/validate lifecycle authoring and implementation-research handoff execution.      | route, implementation-research, maintain                                                  |

## Recommended Capabilities

| Capability                | Use When                                                                         | Notes                                              |
| ------------------------- | -------------------------------------------------------------------------------- | -------------------------------------------------- |
| `task-session`            | A routed request resolves to one bounded implementation or documentation task.   | Use for scoped execution with decisions and gates. |
| `decision-gate`           | Capability updates, ontology promotions, or route ambiguity require user choice. | Ask only consequential questions.                  |
| `sigil-runtime-installer` | Selected capabilities need generated runtime command adapters.                   | Use for add, remove, or refresh operations.        |

## Interview Modes

Necronomicon uses `structured-interview-kits` for human-gated flows.

| Interview Mode           | Use When                                                | Expected Outcome                                      |
| ------------------------ | ------------------------------------------------------- | ----------------------------------------------------- |
| `setup-profile`          | First run, profile change, or missing setup decisions.  | Selected setup profile and persisted setup rationale. |
| `gap-check`              | Route misses, contradictions, or unresolved scope.      | Gap entries and next recommended route.               |
| `checkpoint-review`      | Checkpoint candidates need user confirmation or triage. | Candidate routing decisions and updated gap ledger.   |
| `research-clarification` | Research question or scope is underspecified.           | Bounded research brief inputs.                        |
| `maintenance-decision`   | Maintenance mode proposes route/capability changes.     | Approved, deferred, or rejected maintenance actions.  |

## Optional Capabilities

| Capability                       | Use When                                                                                                | Notes                                       |
| -------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| `ontology-vault`                 | Session memory needs ontology distillation, premise review, confidence promotion, or bridge validation. | Usually present through `ontology-harness`. |
| `architecture-pattern-inventory` | Routing or ontology branches depend on repository structure.                                            | Useful for system/runtime branches.         |
| `feature-glossary`               | The session needs plain-language concept summaries.                                                     | Explanatory, not authoritative.             |

## Modes

| Mode                      | Purpose                                                                                                  | Primary Outputs                                            |
| ------------------------- | -------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| `setup`                   | Establish or revise setup profile, policies, and capability baseline.                                    | setup decisions, profile summary, manifest updates         |
| `start`                   | Create a new repository harness session.                                                                 | session folder, memory seed, capability manifest reference |
| `resume`                  | Continue from existing memory, decisions, and route history.                                             | refreshed context summary, next action                     |
| `route`                   | Route a user request through selected Necronomicon capabilities.                                         | selected command, route record, result summary             |
| `checkpoint`              | Distill session state into gated candidate and gap artifacts.                                            | checkpoint artifact, candidate list, route recommendations |
| `research`                | Run bounded repository and web research with source trail and synthesis gate.                            | research brief, contradictions, post-research options      |
| `implementation-research` | Run project-scoped implementation discovery before execution as a composable overlay with base profiles. | implementation handoff, invoke route recommendation        |
| `update-capabilities`     | Add, remove, or refresh selected sigils and spells.                                                      | capability update report, regenerated runtime command plan |
| `fallback-discover`       | Offer Arcanum registry candidates when no selected capability matches.                                   | candidate list, user decision, optional update path        |
| `maintain`                | Propose harness improvements from telemetry, misses, and repeated gaps.                                  | maintenance report, approved update actions                |
| `close`                   | Write final memory, decisions, route summary, and handoff.                                               | handoff artifact, observability summary                    |

## Prerequisites

- Repository root is known.
- Arcanum runtime support is installed or the user approves installation.
- `.arcanum/observability/` exists or can be initialized.
- `invoke` should be installed for lifecycle authoring and implementation-research handoff routing; if missing, installation approval is required.
- The active runtime command surface is known when command execution is requested.

## Shared State

| State                                                      | Owner      | Updated By                           | Consumed By                            |
| ---------------------------------------------------------- | ---------- | ------------------------------------ | -------------------------------------- |
| `.arcanum/necronomicon/README.md`                          | repository | bootstrap or session spell           | user, local agents                     |
| `.arcanum/necronomicon/capabilities.json`                  | repository | bootstrap, capability update flow    | session router                         |
| `.arcanum/necronomicon/setup-decisions.md`                 | repository | setup mode, profile updates          | setup, resume, maintain                |
| `.arcanum/necronomicon/gaps.json`                          | repository | checkpoint, research, maintain       | setup, route, maintain                 |
| `.arcanum/necronomicon/routes/common-routes.json`          | repository | setup, maintain, update-capabilities | route, maintain                        |
| `.arcanum/necronomicon/sessions/<session-id>/SESSION.md`   | session    | session spell                        | user, resume flow                      |
| `.arcanum/necronomicon/sessions/<session-id>/memory.md`    | session    | session spell, close flow            | resume flow, router                    |
| `.arcanum/necronomicon/sessions/<session-id>/routes.jsonl` | session    | route flow                           | resume flow, signal observer           |
| `.arcanum/necronomicon/sessions/<session-id>/decisions.md` | session    | decision gate, session spell         | resume flow, user                      |
| `.arcanum/necronomicon/sessions/<session-id>/checkpoints/` | session    | checkpoint mode, close flow          | resume, route, maintenance             |
| `.arcanum/necronomicon/research/<project-id>/`             | repository | implementation-research mode         | implementation-readiness, task-session |
| `.arcanum/necronomicon/maintenance/<date>-report.md`       | repository | maintain mode                        | capability updates, local authors      |
| `.arcanum/necronomicon/sessions/<session-id>/handoff.md`   | session    | close flow                           | future sessions                        |
| `.arcanum/necronomicon/capability-updates/`                | repository | update-capabilities flow             | bootstrap, sigil-runtime-installer     |
| `.arcanum/observability/`                                  | repository | session spell and routed commands    | reflection workflows                   |

## Runtime UX Contract

1. Setup is interview-driven: ask one question at a time using `setup-profile` mode.
2. Profile selection and profile changes use option cards with:
   - what the profile enables,
   - what it costs,
   - what state it creates,
   - recommended default,
   - when to avoid it.
3. When a later answer implies profile or capability mutation, require a gated confirmation card before writing state.
4. Confirmation cards must include current value, proposed value, reason, auto-added dependencies, consequences, rejected alternatives, and target update path.
5. Ask only unanswered setup questions when setup decisions already exist.
6. Generated state must redact or omit secret values.

## Checkpoint And Memory Policy

1. Checkpoint triggers include user request, before close, before capability updates, after major research synthesis, after repeated route misses, and before implementation transitions.
2. Checkpoints write to `.arcanum/necronomicon/sessions/<session-id>/checkpoints/<timestamp>.md`.
3. Checkpoint content separates source-backed facts, inferred claims, decisions, contradictions, unresolved questions, route patterns, capability gaps, and promotion candidates.
4. Promotion candidates remain candidate-only and must route through owning flows (`inventory`, `ontology-vault`, `decision-gate`).
5. Memory classes tracked by Necronomicon are project memory, session memory, route memory, user instruction memory, and ontology candidate memory.
6. Gap-related unresolved items from checkpoints are written to `.arcanum/necronomicon/gaps.json`.
7. Checkpoint and memory artifacts must apply state privacy redaction before persistence.

## Research Scope Policy

1. Research mode uses a bounded source order: session memory and checkpoints, inventory, ontology outputs, repository docs, code, then web sources.
2. Web research is allowed when the active runtime and tool surface support external fetch/search operations.
3. If web access is unavailable, run repository-only research and return a `web-unavailable` note in the result.
4. Web findings must include source URL, retrieval timestamp, and confidence or quality notes before durable synthesis.
5. Contradictions between local and web sources must be captured in the research brief and gap ledger before promotion.
6. When `ontology-harness` is active, ontology outputs are required local sources before web escalation.

## Maintenance Loop

1. `maintain` mode reads route misses, corrections, repeated tasks, capability updates, quality gaps, output drift, and all selected sigil/spell signals from local observability telemetry.
2. Maintenance must read the gap ledger before proposing actions.
3. Use `signal-observer`, `workflow-reflect`, and `sigil-maintenance-loop` to produce evidence-backed recommendations.
4. Maintenance should flag selected capabilities with missing or stale signal coverage as explicit maintenance gaps.
5. Recommendation classes include route preset updates, capability updates, setup profile revisions, local spell proposals, reusable spell proposals, local sigil proposals, reusable sigil proposals, and defer.
6. Route spell creation through `spellcraft` and sigil creation through `sigil-development`.
7. Require explicit user approval before creating or promoting reusable artifacts.

## Execution Phases

| Phase | Capability             | Input                                                 | Output                             | Gate                               | Failure Policy                                   |
| ----- | ---------------------- | ----------------------------------------------------- | ---------------------------------- | ---------------------------------- | ------------------------------------------------ |
| 1     | setup resolver         | repository root, mode, existing decisions             | selected profile and policy draft  | required setup decisions exist     | run `setup-profile` interview mode               |
| 2     | capability load        | `capabilities.json`, setup decisions, runtime folders | selected command surface           | selected capabilities are readable | flag stale entries                               |
| 3     | memory and gap load    | memory, decisions, checkpoints, `gaps.json`           | compact session + open-gap context | source context is explicit         | start fresh session memory if missing            |
| 4     | request classification | user request, profile, route presets                  | route candidates and confidence    | explicit route wins                | ask one clarification on tied medium/high routes |
| 5     | selected routing       | selected capabilities and policy gates                | chosen local command               | command adapter exists             | fallback discover when no selected match exists  |
| 6     | bounded execution      | chosen command and mode contract                      | routed result                      | mode-specific gate satisfied       | report partial and next safest route             |
| 7     | checkpoint handling    | route result and checkpoint policy                    | checkpoint artifact and candidates | candidate-only promotions enforced | defer promotions to owning flows                 |
| 8     | gap ledger update      | unresolved items, contradictions, misses              | updated `gaps.json` entries        | JSON remains valid                 | flag when ledger write fails                     |
| 9     | maintenance evaluation | route history and observability signals               | maintenance recommendations        | evidence cited for recommendations | defer unsupported recommendations                |
| 10    | close or continue      | session status and next action                        | handoff or resumable continuation  | blockers named                     | leave session resumable                          |

## Routing Rules

1. Load the active session memory, decisions, route history, and capability manifest before routing.
2. Prefer explicit runtime command names, exact spell IDs, exact sigil IDs, and exact aliases.
3. Route setup, start, create, resume, close, memory, handoff, checkpoint, research, implementation-research, maintenance, capability update, or fallback discovery requests to this spell.
4. Route ontology, vault, premise, confidence, convention, branch map, session distillation, and bridge validation requests to `ontology-harness` or `arcanum-necronomicon`.
5. Route one bounded task with done criteria to `task-session` when selected.
6. Route compact evidence or context pack requests to `context-builder` when selected.
7. If no selected route matches, inspect installed command surfaces and canonical Arcanum registries when available.
8. Offer 2-5 fallback sigils or spells with the reason each candidate may fit.
9. Ask before adding fallback candidates to the Necronomicon capability manifest.
10. Record every route attempt in `routes.jsonl` with request summary, candidates, selected route, confidence, fallback use, result, validation, and follow-up.
11. Route ontology promotion candidates through `ontology-vault` flows, inventory candidates through inventory flows, and consequential unresolved choices through `decision-gate`.
12. In `research` mode, include web sources when runtime support is available and preserve bounded stop conditions.
13. Route lifecycle authoring requests (`define`, `design`, `plan`, `full`, `validate`) and implementation-research handoffs to `arcanum-spell-invoke` when installed.
14. If `invoke` is unavailable for those routes, report a capability gap and route to `update-capabilities` for install approval.
15. Route cross-sigil maintenance synthesis to `arcanum-spell-sigil-maintenance-loop` when installed, and report a maintenance capability gap when it is missing.

## Route Confidence

| Confidence | Meaning                                                                         |
| ---------- | ------------------------------------------------------------------------------- |
| high       | Explicit command name, exact canonical ID, or exact alias.                      |
| medium     | Selected capability trigger, description, or mode strongly matches the request. |
| low        | Fallback registry candidate may fit but is not selected in the session.         |
| block      | No credible selected or fallback route exists.                                  |

Ask one focused clarification when multiple medium or high routes tie.

## Capability Update Flow

1. Read `.arcanum/necronomicon/capabilities.json` and the installed runtime command folders.
2. Identify stale selected entries, missing adapters (including missing `invoke` lifecycle route coverage), new available Arcanum registry entries, and repeated route misses.
3. Identify missing or stale signal coverage for selected sigils/spells and prioritize maintenance-loop remediation.
4. Present add, remove, refresh, or author options.
5. Use `sigil-runtime-installer` or bootstrap to regenerate runtime commands when installation changes are approved.
6. Use `spellcraft` or `sigil-development` when the needed behavior does not exist yet.
7. Write a report under `.arcanum/necronomicon/capability-updates/`.
8. Update session memory and route future matching through the new capability set.

## Local Customization

- Harness root: `.arcanum/necronomicon/`
- Session root: `.arcanum/necronomicon/sessions/`
- Capability manifest: `.arcanum/necronomicon/capabilities.json`
- Runtime adapter root: `.arcanum/runtimes/`
- Observability root: `.arcanum/observability/`
- Default memory strictness: standard
- Default fallback policy: ask-before-add
- Default session ID format: timestamp plus slug, for example `2026-05-14-sonar-loop-routing`
- Default checkpoint policy: standard
- Default profile when unspecified: `basic-inventory`

## Guardrails

- Do not copy canonical sigil or spell definition folders into `.arcanum/necronomicon/`.
- Do not make session memory authoritative over source documents, registries, or implementation evidence.
- Do not add fallback capabilities silently.
- Do not mark a route successful if the selected command was unavailable or its validation failed.
- Keep durable memory concise and resumable; avoid storing raw full chat transcripts unless the user explicitly requests that.
- Preserve unrelated local runtime commands and discovery bridges.
- Do not persist credentials, passwords, API keys, private keys, or secret values in Necronomicon state.
- Do not auto-create reusable spells or sigils from maintenance suggestions without explicit user approval.

## Observability

Record session-level telemetry when `.arcanum/observability/` exists:

- spell name,
- mode,
- session ID,
- selected capability count,
- request classification,
- route confidence,
- selected command,
- selected profile,
- checkpoint trigger and artifact path,
- research mode budget and stop condition,
- web source usage and web-unavailable fallback status,
- implementation-research handoff status,
- per-sigil signal coverage and stale-signal flags,
- maintenance recommendation classes,
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
- Mode: setup | start | resume | route | checkpoint | research | implementation-research | update-capabilities | fallback-discover | maintain | close
- Profile: basic-inventory | ontology-harness | research | implementation-research | custom
- Repository: <path>
- Session ID: <id>
- Capabilities loaded: <count>
- Route: <selected command or none>
- Route preset used: <id or none>
- Confidence: high | medium | low | block
- Fallback offered: yes | no
- Checkpoint: written | skipped | n/a
- Research brief: path or none
- Implementation handoff: path or none
- Invoke route: used | missing | n/a
- Gap ledger updates: <count or none>
- Maintenance recommendations: <count or none>
- Files updated: <paths or none>
- Validation: <checks>
- Follow-up: <items or none>
```
