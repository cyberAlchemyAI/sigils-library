# Invoke Spell Wave Plan

## Purpose

Define an implementation-ready plan for one reusable Arcanum library spell: `invoke`.

`invoke` should convert vague development intent into governed artifacts through one unified flow:

1. intent to spec and glossary,
2. spec/glossary to architecture/design bundle,
3. approved spec/design to executable work-pack.

## Scope

- Build one reusable library spell under `arcanum/spells/invoke.md`.
- Register `invoke` in `arcanum/registry/SPELLS.md` after validation.
- Keep DomainSpec feature-spec authorship in DomainSpec commands.
- Allow Necronomicon route presets to call `invoke` after release.
- Maintain an `invoke`-owned glossary used as the system and business ontology for generated artifacts.
- Apply Necronomicon-first linking for glossary terms: always try to link to already defined Necronomicon concepts before creating new terms.
- After each approved `invoke` stage, transport approved definitions and context deltas into Necronomicon context.

## Non-Goals

- No direct code implementation.
- No full local CLI runtime in the first pass.
- No replacement of DomainSpec specialist commands.

## Design Principles

1. Keep wording generic and plain-language.
2. Do not require specialized graph vocabulary.
3. Ask one focused interview question at a time when context is missing.
4. Prefer local repository templates as canonical.
5. Keep each stage auditable with explicit outputs and gates.
6. Do not silently edit upstream artifacts.
7. Reuse existing Necronomicon concepts before introducing new glossary concepts.
8. After each approved stage, complement Necronomicon context with approved outputs.

## Decided Outcomes

1. Template set is broad and generic:
   - `generic`, `sigil`, `spell`, `ux-plan`, `research`, `architecture`, `implementation-plan`, `work-pack`.
    - Module Formulae composable starter bundle is implemented at `arcanum/templates/module-formulae/` with:
     - `module-spec.md`,
     - `glossary-ontology.md`,
     - `concept-model.md`,
     - `operations.md`,
     - `flows-policies.md`,
     - `interfaces.md`,
       - `research-brief.md`,
       - `architecture-bundle.md`,
       - `implementation-plan.md`,
     - `observability.md`,
     - `execution-pack.md`,
       - `bundle-profile.md`,
     - `vocabulary-map.md`.
    - composable profile routing is defined by `bundle-profile.md` across discovery, architecture, implementation, and full profiles.
2. Template authority is local-first:
   - active canonical templates live in local inventory,
   - library templates are starters/examples.
3. No-model behavior:
   - `invoke` runs structured interview,
   - proposes artifact bundle options,
   - requires approval,
   - creates local template candidate,
   - candidate remains non-canonical until promoted.
4. Architecture gate:
   - prefer approved spec,
   - allow discovery mode for vague goals,
   - route missing spec needs back into define stage.
5. Plan mode output:
   - low complexity: single-file work-pack,
   - medium/high complexity: split work-pack.
6. Mutation governance:
   - downstream stages emit patch requests,
   - direct upstream edits require explicit approval.
7. Required architecture views:
   - context,
   - high-level structure,
   - low-level components,
   - workflow/process,
   - decision flow,
   - dependency/interface map.
8. Glossary ownership:
   - `invoke` maintains its own glossary,
   - glossary terms are used as the system and business ontology baseline,
   - spec, design, and work-pack outputs must align to glossary terminology,
   - glossary creation follows Necronomicon-first concept linking.
9. Stage-to-Necronomicon transport:
   - after any approved stage (`define`, `design`, `plan`), `invoke` transports approved definitions into Necronomicon context,
   - transport should append or complement existing Necronomicon context by default,
   - transport actions should emit per-stage reports.

## Spell Overview

| Spell | Core Outcome | Primary Inputs | Primary Outputs |
| ----- | ------------ | -------------- | --------------- |
| `invoke` | Produce spec + glossary + design + work-pack through one governed flow | goal, constraints, evidence, optional existing artifacts, selected mode | spec artifact, glossary artifact, design bundle, work-pack, decisions, unresolved gaps, Necronomicon context updates |

## Compose Map

### Required Capabilities

- `structured-interview-kits`
- `inventory`
- `context-builder`
- `decision-gate`
- `implementation-readiness`

### Conditional Capabilities

- `architecture-pattern-inventory` when design bundle is requested.
- `task-session` when handoff needs bounded execution planning.

## Shared Artifact Contracts

### 1. Spec Contract

Every generated spec should include:

- objective,
- scope,
- out-of-scope,
- actors,
- core workflows,
- constraints,
- acceptance criteria,
- assumptions,
- unresolved questions,
- evidence references,
- decision snapshots.

### 2. Template Entry Contract (Local Inventory)

Each template entry should include:

- `template_id`,
- `template_type`,
- `applies_to`,
- `required_inputs`,
- `optional_inputs`,
- `output_files`,
- `version`,
- `status` (`candidate` or `canonical`),
- `authority_level`,
- `examples`,
- `validation_rules`,
- `created_at`,
- `updated_at`.

### 3. Glossary Contract (System and Business Ontology)

The glossary should include:

- `term`,
- `category` (`business`, `system`, or `shared`),
- `definition`,
- `source_or_rationale`,
- `linked_necronomicon_concepts`,
- `link_status` (`linked`, `partial`, or `no-match`),
- `no_match_reason` (required when `link_status = no-match`),
- `usage_references` (spec/design/work-pack sections),
- `status` (`candidate` or `canonical`),
- `created_at`,
- `updated_at`.

Glossary linking order should be deterministic:

1. Try to match already defined concepts inside Necronomicon first.
2. If a match exists, link and reuse that concept language.
3. If no match exists, create a candidate term and record `no_match_reason`.

### 4. Architecture Bundle Contract

Every design bundle should include:

- required view set,
- assumptions,
- open design risks,
- unresolved decisions,
- downstream planning notes.

### 5. Work-Pack Contract

Every work-pack should include:

- objective,
- complexity,
- selected output mode,
- tasks and/or waves,
- traceability links,
- gate checks,
- blockers,
- closure strategy.

### 6. Necronomicon Context Transport Contract

Every approved stage transport should include:

- `stage_id`,
- `approval_reference`,
- `definitions_transported`,
- `context_paths_updated`,
- `merge_mode` (`append` or `complement`),
- `transport_status`,
- `transport_timestamp`,
- `unresolved_transport_gaps`.

## Invoke Contract

## Identity

- Canonical ID: `invoke`
- Scope: library spell
- Purpose: unify define, design, and planning workflows behind one generic contract.

## Trigger Conditions

- User has something to build but needs structure before implementation.
- Existing artifacts are incomplete, inconsistent, or missing.

## Modes

- `define`: produce or update spec artifact.
- `design`: produce architecture/design bundle.
- `plan`: produce executable work-pack.
- `full`: run `define`, `design`, and `plan` in sequence with gates.
- `validate`: validate existing artifacts and report gaps.

## Input Contract

`invoke` accepts:

- goal,
- optional mode,
- optional existing artifacts,
- constraints,
- required output depth,
- approval preferences.

## Phase Contract

### Phase 0 - Baseline Check

- detect existing local templates,
- detect existing spec/glossary/design/work-pack artifacts,
- load existing Necronomicon concept sources for term matching,
- detect missing mandatory inputs for selected mode.

### Phase 1 - Clarify Intent

- if context is missing, run one-question-at-a-time interview,
- generate recommended artifact bundle,
- capture approval decision.

### Phase 2 - Define (Spec)

- select local canonical template or create candidate,
- generate spec artifact,
- generate or update glossary artifact,
- for each glossary term, run Necronomicon-first concept linking,
- record assumptions and unresolved gaps,
- write template usage to inventory,
- after define-stage approval, transport approved spec and glossary definitions to Necronomicon context.

### Phase 3 - Design (Architecture)

- use approved spec when available,
- enforce glossary term consistency for system and business language,
- in discovery mode, produce design brief and spec gap requests,
- generate six required views,
- record architecture gaps,
- after design-stage approval, transport approved design context to Necronomicon.

### Phase 4 - Plan (Work-Pack)

- determine complexity,
- select single or split mode,
- use glossary terms for task naming and traceability labels,
- build tasks/waves and gate checks,
- route unresolved blockers to decision-gate,
- after plan-stage approval, transport approved work-pack context to Necronomicon.

### Phase 5 - Finalize

- publish outputs,
- write decision snapshots,
- write glossary candidate and conflict notes,
- write unresolved Necronomicon no-match terms for later promotion review,
- reconcile per-stage Necronomicon transport reports,
- write unresolved gap ledger,
- return next recommended route.

## Output Contract

`invoke` returns:

- artifact paths by mode,
- selected templates and status,
- glossary path and term updates,
- design views generated,
- work-pack mode and gate status,
- decisions recorded,
- Necronomicon transport report by stage,
- Necronomicon context paths updated,
- unresolved gaps,
- next route recommendation.

## Governance Rules

1. No silent upstream mutation.
2. Direct edits to upstream artifacts require explicit approval.
3. Candidate templates cannot auto-promote to canonical.
4. `full` mode stops on blocked gates and returns remediation guidance.
5. Glossary is the terminology source for system and business ontology in all `invoke` outputs.
6. Glossary terms must always attempt Necronomicon-first linking before creating new candidate concepts.
7. Any approved stage must transport approved definitions/context into Necronomicon.
8. Stage transport should append or complement existing Necronomicon context unless explicit overwrite approval is provided.

## Remaining Non-Blocker Gaps

1. Finalize local template promotion rules.
2. Define recommendation scoring for template selection.
3. Define exact complexity thresholds for plan mode switching.
4. Define validation examples for all initial templates.
5. Define Necronomicon route presets that invoke `invoke`.
6. Define glossary candidate promotion and conflict-resolution rules.
7. Define deterministic matching heuristics for Necronomicon-first concept linking.
8. Define default Necronomicon context paths and merge rules for stage transports.

## Implementation Waves

### Wave 0 - Baseline Audit

- inspect existing templates and work-pack examples,
- map overlaps with current capabilities.

### Wave 1 - Spell Contract Finalization

- finalize `invoke` identity, modes, phase contract, gates, and output contract.

### Wave 2 - Template and Spec Stage

- implement `define` stage contract,
- implement local template retrieval and candidate creation policy,
- validate Module Formulae starter bundle defaults under `arcanum/templates/module-formulae/`,
- validate composable profile mapping in `bundle-profile.md` for define/design/plan/full/validate modes,
- implement define-stage approved transport to Necronomicon.

### Wave 3 - Design Stage

- implement `design` stage contract,
- enforce six required architecture views,
- implement discovery-mode design brief behavior,
- implement design-stage approved transport to Necronomicon.

### Wave 4 - Plan Stage

- implement `plan` stage contract,
- implement adaptive output mode,
- implement blocker routing,
- implement plan-stage approved transport to Necronomicon.

### Wave 5 - Full and Validate Modes

- implement `full` orchestration,
- implement `validate` mode reporting,
- verify stage gates and stop conditions,
- verify per-stage transport reporting and merge behavior.

### Wave 6 - Registry and Examples

- register `invoke` in spell registry,
- add examples for each mode.

### Wave 7 - Validation

- run spell contract validation,
- run markdown link checks,
- run schema checks,
- execute representative scenarios.

## Validation Matrix

| Check | Expected Result |
| ----- | --------------- |
| `invoke define` from vague goal | interview runs, template selected or candidate created, governed spec emitted |
| Module Formulae template bundle availability | local inventory can resolve defaults from `arcanum/templates/module-formulae/` and map terms via `vocabulary-map.md` |
| Module Formulae composable profiles | `bundle-profile.md` maps invoke modes to discovery/architecture/implementation/full bundles with deterministic selection rules |
| `invoke define` glossary output | glossary is created/updated and includes business + system terms with status and references |
| Necronomicon-first glossary linking | each glossary term links to an existing Necronomicon concept when available; no-match terms include rationale |
| `invoke define` transport | after define approval, approved spec/glossary definitions are transported to Necronomicon context |
| `invoke design` from approved spec | six required views emitted, architecture gaps recorded |
| Glossary consistency in design | design bundle uses glossary terminology and reports term conflicts |
| `invoke design` transport | after design approval, approved design context is transported and complemented in Necronomicon |
| `invoke design` from vague goal | discovery brief emitted, spec gap requests recorded |
| `invoke plan` low complexity | single-file work-pack emitted |
| `invoke plan` medium/high complexity | split work-pack emitted with waves/tasks/shared context |
| Glossary consistency in work-pack | task labels and traceability names align with glossary terms |
| `invoke plan` transport | after plan approval, approved work-pack context is transported and complemented in Necronomicon |
| Transport merge policy | stage transports append/complement existing Necronomicon context and do not overwrite without explicit approval |
| `invoke full` with blocker | execution stops at gate and returns remediation guidance |
| Upstream mutation policy | no silent edits; explicit approval required for upstream changes |
| Local template authority | local inventory resolves canonical active templates |

## Acceptance Criteria

1. One spell (`invoke`) covers define/design/plan lifecycle with explicit modes.
2. Generic contract avoids specialized graph-vocabulary dependencies.
3. Shared artifact schemas are documented and testable.
4. Stage handoffs are deterministic and auditable.
5. No direct implementation mutation occurs.
6. Glossary is generated and used as system/business ontology across outputs.
7. Necronomicon-first linking is enforced for glossary terms, with explicit no-match rationale when needed.
8. Any approved `invoke` stage transports approved definitions/context into Necronomicon with per-stage reports.
9. Module Formulae starter template bundle is available and resolvable for default `invoke` template selection.
10. Research, architecture, implementation, and execution templates are integrated through Module Formulae composable profiles.
11. Registry entry is added only after validation passes.
