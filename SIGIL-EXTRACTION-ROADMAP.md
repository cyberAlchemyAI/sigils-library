# Sigil Extraction Roadmap

This roadmap turns reusable internal skill patterns into standalone Arcanum sigils without carrying private vocabulary, internal taxonomy, or project-specific workflow mechanics into the public registry.

The plan is intentionally target-sigil first. Source skill names and source-system terms stay out of this document. Each todo represents one candidate sigil to import, rewrite, research, or reject.

## Extraction Rules

- Use target sigil names only in public artifacts.
- Do not copy source wording directly unless it is already project-neutral.
- Remove private taxonomy, workflow names, document names, routing rules, and orchestration vocabulary.
- Preserve the reusable behavior, not the internal system that originally hosted it.
- Every extracted sigil must include `README.md`, `SKILL.md`, Quality Bar, Anti-Patterns, output contract, and observability guidance when reused.
- Run one todo at a time: extract, validate, register, observe, then move to the next todo.
- When extraction risk is high, create a research note before writing the sigil.

## Wave Model

| Wave | Goal                                                                  | Extraction Mode                                        | Gate                                                             |
| ---- | --------------------------------------------------------------------- | ------------------------------------------------------ | ---------------------------------------------------------------- |
| W0   | Stabilize foundation sigils and package conventions.                  | Active foundation hardening.                           | Registry, links, JSON templates, and neutral wording pass.       |
| W1   | Extract low-risk general-purpose workflow sigils.                     | Direct rewrite with light redaction.                   | Sigil has no private vocabulary and passes trial review.         |
| W2   | Extract architecture, context, decision, and interview sigils.        | Controlled rewrite with focused research where needed. | Behavior is reusable without exposing source workflow mechanics. |
| W3   | Extract implementation, readiness, and observability delivery sigils. | Rewrite from first principles using generic contracts. | Inputs and outputs are generic artifacts, not private docs.      |
| W4   | Extract research and evidence-management sigils.                      | Research-first rewrite.                                | Method is reusable and schema-neutral.                           |
| W5   | Investigate high-redaction candidates.                                | Research plan before extraction.                       | Explicit keep/rewrite/reject decision.                           |

## Current Foundation Status

| Sigil                          | Tier           | Status | Notes                                                                                         |
| ------------------------------ | -------------- | ------ | --------------------------------------------------------------------------------------------- |
| implementation-layering        | Transmutations | Done   | Already generalized.                                                                          |
| observability-setup            | Formulae       | Done   | Package setup sigil, framework observability docs, hook docs, and JSON templates are present. |
| architecture-pattern-inventory | Arcana         | Done   | Architecture mapping sigil and generic architecture package templates are present.            |
| sigil-development              | Arcana         | Done   | Lifecycle, telemetry, and reflection pattern created.                                         |
| robot-talks                    | Arcana         | Done   | Multi-agent tension discovery generalized.                                                    |

## Implementation Audit - 2026-05-14

This pass compares the roadmap against implemented Arcanum folders that contain `SKILL.md` and registry entries in [registry/SIGILS.md](registry/SIGILS.md).

| Implemented Sigil              | Tier           | Roadmap Source | Registry Status |
| ------------------------------ | -------------- | -------------- | --------------- |
| observability-setup            | Formulae       | W0.2           | Registered      |
| implementation-layering        | Transmutations | Foundation     | Registered      |
| architecture-pattern-inventory | Arcana         | W0.3           | Registered      |
| sigil-development              | Arcana         | Foundation     | Registered      |
| robot-talks                    | Arcana         | Foundation     | Registered      |
| decision-gate                  | Arcana         | W1.1           | Registered      |
| task-session                   | Arcana         | W1.2           | Registered      |
| signal-observer                | Arcana         | W1.3           | Registered      |
| workflow-reflect               | Arcana         | W1.4           | Registered      |
| context-builder                | Transmutations | W2.1           | Registered      |
| structured-interview-kits      | Arcana         | W2.2           | Registered      |
| scope-interview                | Arcana         | W2.3           | Registered      |
| feature-glossary               | Transmutations | W2.4           | Registered      |
| definitions-governance         | Arcana         | W2.5           | Registered      |
| inventory                      | Arcana         | INV.1          | Registered      |
| spellcraft                     | Arcana         | SPL.2          | Registered      |
| residuality-spec               | Arcana         | RES.1          | Registered      |
| ontology-vault                 | Arcana         | ONT.1          | Registered      |
| skill-transcriptor             | Arcana         | AUTH.1         | Registered      |
| skill-decomposer               | Arcana         | AUTH.2         | Registered      |
| sigil-runtime-installer        | Arcana         | RUNTIME.1      | Registered      |

Summary:

- Implemented sigils with `SKILL.md`: 21.
- Registered implemented sigils: 21.
- Implemented spells: 6 first-party spell files plus spell templates.
- W0, W1, W2, Inventory Extension, Spell Composition Layer, and Resilience Specification Extension are implemented.
- W3, W4, and W5 candidates remain unimplemented or research-needed unless a later pass adds their folders.

## Wave 0 - Foundation Stabilization

Wave 0 prepares the library so later extraction work can proceed one sigil at a time without reworking the package conventions.

| Todo | Task                                                          | Output                                                                               | Status                                                     |
| ---- | ------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| W0.1 | Confirm existing foundation sigils are registered and linked. | Registry and README point to all completed foundation sigils.                        | Done                                                       |
| W0.2 | Finish repository-local observability package setup.          | `observability-setup` sigil, repository package docs, hook docs, and JSON templates. | Done                                                       |
| W0.3 | Finish architecture pattern inventory package.                | `architecture-pattern-inventory` sigil and generic architecture package templates.   | Done                                                       |
| W0.4 | Validate foundation package quality gates.                    | Markdown links pass, JSON templates parse, and neutral wording scan is clean.        | Done                                                       |
| W0.5 | Commit and push foundation batch.                             | Foundation stabilization changes are committed to the sigils repository.             | Deferred - commits are not required at each wave boundary. |
| W0.6 | Open Wave 1 by selecting the first extraction todo.           | First W1 todo is selected and marked active.                                         | Done                                                       |

### W0 Iteration Order

Execute W0 one task at a time:

1. Complete W0.2 observability package setup.
2. Complete W0.3 architecture pattern inventory package.
3. Run W0.4 validation gates.
4. Defer W0.5 unless the user explicitly asks for a commit.
5. Select W0.6 next extraction target from Wave 1.

W0 is complete enough to proceed. Continue with W1.1 as the active extraction task.

## Wave 1 - Low-Risk Direct Extraction

These candidates should be extractable with light rewriting and no research note unless implementation reveals hidden coupling.

| Todo | Target Sigil     | Tier   | Extraction Step                                                                       | Status |
| ---- | ---------------- | ------ | ------------------------------------------------------------------------------------- | ------ |
| W1.1 | decision-gate    | Arcana | Rewrite multi-option decision resolution as a generic pre-mutation gate.              | Done   |
| W1.2 | task-session     | Arcana | Rewrite guided single-task execution with trade-offs, gates, and completion criteria. | Done   |
| W1.3 | signal-observer  | Arcana | Align post-session signal derivation with the sigil observability package.            | Done   |
| W1.4 | workflow-reflect | Arcana | Generalize accumulated-signal reflection into a reusable improvement loop.            | Done   |

W1 extraction and validation are complete.

## Wave 2 - Context, Interview, And Architecture Extraction

These candidates are broadly reusable but need careful wording to avoid carrying private artifact assumptions.

| Todo | Target Sigil              | Tier           | Extraction Step                                                                          | Status |
| ---- | ------------------------- | -------------- | ---------------------------------------------------------------------------------------- | ------ |
| W2.1 | context-builder           | Transmutations | Create minimal task-context pack builder with generic selectors and relevance gates.     | Done   |
| W2.2 | structured-interview-kits | Arcana         | Create one-question-at-a-time interview modes without private doc patching rules.        | Done   |
| W2.3 | scope-interview           | Arcana         | Research whether scope discovery can be generic without leaking source output structure. | Done   |
| W2.4 | feature-glossary          | Transmutations | Research a neutral glossary builder independent of private concept tables.               | Done   |
| W2.5 | definitions-governance    | Arcana         | Research a first-principles definitions governance sigil.                                | Done   |

W2 extraction and validation are complete.

## Inventory Extension - Compiled Knowledge Layer

This extension creates a repository-local inventory sigil inspired by compiled wiki maintenance: immutable raw sources, generated markdown entries, indexes, tags, logs, linting, and lookup contracts for other sigils.

| Todo  | Target Sigil | Tier   | Extraction Step                                                                               | Status |
| ----- | ------------ | ------ | --------------------------------------------------------------------------------------------- | ------ |
| INV.1 | inventory    | Arcana | Create installable compiled knowledge inventory that context and architecture sigils can use. | Done   |

Inventory extraction and validation are complete.

## Spell Composition Layer

This extension creates spells as localized workflow compositions that reference multiple sigils, define shared state, gates, handoffs, and observability, and can be installed into consuming repositories.

| Todo  | Target          | Kind              | Step                                                                              | Status |
| ----- | --------------- | ----------------- | --------------------------------------------------------------------------------- | ------ |
| SPL.1 | spells category | Composition docs  | Add top-level spells concept, registry, and templates.                            | Done   |
| SPL.2 | spellcraft      | Arcana            | Create the sigil that designs, installs, validates, observes, and revises spells. | Done   |
| SPL.3 | offered spells  | Composition files | Add first-party reusable spell compositions.                                      | Done   |

Spell composition extraction and validation are complete.

## Resilience Specification Extension

This extension creates a Residuality-inspired sigil for defining resilient specifications through stressor analysis, desired residue, degradation behavior, attractor discovery, and decision capture.

| Todo  | Target Sigil     | Tier   | Extraction Step                                                    | Status |
| ----- | ---------------- | ------ | ------------------------------------------------------------------ | ------ |
| RES.1 | residuality-spec | Arcana | Create stressor and residue analysis workflow for spec definition. | Done   |

Residuality spec extraction and validation are complete.

## Ontology Vault Extension

This extension creates a governed ontology-vault sigil and a harness spell for repositories with sessions, discoveries, premises, conventions, confidence rules, and delegated evidence that need traceable promotion and validation.

| Todo  | Target                             | Kind            | Step                                                                                                                                                                             | Status |
| ----- | ---------------------------------- | --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| ONT.1 | ontology-vault                     | Arcana          | Create neutral ontology governance sigil with mapping, session distillation, premise review, confidence promotion, convention changes, delegated evidence, and validation modes. | Done   |
| ONT.2 | ontology-harness                   | Spell           | Compose inventory, ontology-vault, and context-builder into a reusable vault governance workflow.                                                                                | Done   |
| ONT.3 | repository-harness ontology branch | Spell extension | Add optional ontology-vault branch to the Ontology Harness without making ontology governance mandatory.                                                                         | Done   |

Ontology vault extraction and validation are complete.

## Branch-Aware Ontology Extension

This extension adds optional business/system ontology branches to Ontology Vault. Business ontology owns intent and meaning, system ontology owns implementation and runtime evidence, and the bridge layer owns traceability, realization, tests, observability, constraints, evidence gaps, and drift.

| Todo     | Target                            | Kind            | Step                                                                                                                       | Status |
| -------- | --------------------------------- | --------------- | -------------------------------------------------------------------------------------------------------------------------- | ------ |
| ONT-BR.1 | ontology-vault branch model       | Arcana update   | Add business, system, and bridge concepts, starter role catalogs, branch-aware mode arguments, and validation rules.       | Done   |
| ONT-BR.2 | branch templates                  | Templates       | Add business map, system map, bridge map, drift report, and traceability matrix templates.                                 | Done   |
| ONT-BR.3 | ontology-harness branch path      | Spell update    | Add optional branch-aware phases and cross-branch context proof.                                                           | Done   |
| ONT-BR.4 | repository-harness branch trigger | Spell extension | Let the Necronomicon/Ontology Harness alias activate branch-aware ontology when intent-to-system traceability is in scope. | Done   |

Branch-aware ontology extension validation is complete.

## Sigil Authoring Extension

This extension adds two specialized authoring helpers that integrate with `sigil-development`: one for converting coherent sources into sigils, and one for decomposing broad or tangled sources into boundary-safe candidates before conversion.

| Todo   | Target             | Kind   | Step                                                                                                          | Status |
| ------ | ------------------ | ------ | ------------------------------------------------------------------------------------------------------------- | ------ |
| AUTH.1 | skill-transcriptor | Arcana | Convert a complete coherent skill, prompt, command, or workflow into an Arcanum-compliant sigil package plan. | Done   |
| AUTH.2 | skill-decomposer   | Arcana | Extract one reusable capability from a broad or tangled source and prepare a handoff to conversion.           | Done   |

Sigil authoring extension validation is complete.

## Runtime Adapter Installation Extension

This extension adds an installer sigil for exposing Arcanum sigils through agent-specific command surfaces while keeping canonical behavior in the Arcanum registry and sigil files.

| Todo      | Target                         | Kind             | Step                                                                                                                                                             | Status |
| --------- | ------------------------------ | ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| RUNTIME.1 | sigil-runtime-installer        | Arcana           | Install thin adapters for GitHub Copilot, Claude, or Codex by selected target runtime.                                                                           | Done   |
| RUNTIME.2 | github-copilot arcanum install | Adapter install  | Install `arcanum-orchestrate` for GitHub Copilot in the Arcanum repo and the parent workspace.                                                                   | Done   |
| RUNTIME.3 | arcanum-bootstrap              | Spell and script | Export Arcanum into consuming repositories with all or selected sigils, selected spells, observability folders, and optional runtime adapters under `.arcanum/`. | Done   |

Runtime adapter installation validation is complete.

## Wave 3 - Delivery And Readiness Extraction

These candidates are useful, but must be rewritten around generic contracts such as requirements, design artifacts, tests, telemetry, and deployment config.

| Todo | Target Sigil           | Tier           | Extraction Step                                                                        | Status      |
| ---- | ---------------------- | -------------- | -------------------------------------------------------------------------------------- | ----------- |
| W3.1 | test-spec-generator    | Transmutations | Generate tests from generic requirements and behavior artifacts.                       | Not started |
| W3.2 | readiness-gate         | Arcana         | Create profile-based readiness review for pilot, release candidate, and production.    | Not started |
| W3.3 | infra-architecture     | Arcana         | Detect infrastructure, ask minimal questions, and generate neutral infra architecture. | Not started |
| W3.4 | infra-deploy-artifacts | Transmutations | Generate deploy artifacts from neutral infra and observability contracts.              | Not started |
| W3.5 | ui-architecture        | Arcana         | Detect frontend stack and create neutral UI architecture guidance.                     | Not started |
| W3.6 | ui-implement           | Transmutations | Implement UI from a generic design and behavior contract.                              | Not started |

## Wave 4 - Observability And Research Extraction

These candidates should connect to the repository-local observability package and avoid source-specific research program structure.

| Todo | Target Sigil                   | Tier           | Extraction Step                                                          | Status          |
| ---- | ------------------------------ | -------------- | ------------------------------------------------------------------------ | --------------- |
| W4.1 | otel-instrumentation           | Transmutations | Instrument backend code from generic observability requirements.         | Not started     |
| W4.2 | otel-coverage-verify           | Arcana         | Verify instrumentation coverage and produce generic change requests.     | Not started     |
| W4.3 | source-catalog                 | Transmutations | Catalog external sources with neutral diversity and feasibility scoring. | Not started     |
| W4.4 | knowledge-inventory            | Transmutations | Extract and maintain structured knowledge entries from sources.          | Not started     |
| W4.5 | empirical-data-analysis        | Arcana         | Analyze JSONL or tabular evidence through a generic empirical pipeline.  | Research needed |
| W4.6 | reference-authority-governance | Arcana         | Govern pinned references, waivers, ledgers, and authority drift.         | Research needed |

## Wave 5 - Research-First High-Redaction Candidates

Do not directly extract these. Each needs a short research note and an explicit decision before sigil authoring.

| Todo  | Target Sigil                  | Tier           | Research Question                                                                                                    | Status          |
| ----- | ----------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------- | --------------- |
| W5.1  | capability-inventory          | Arcana         | Can capability inventories be useful without internal command-agent route contracts?                                 | Research needed |
| W5.2  | feature-architecture          | Transmutations | Can feature-level architecture be generic without private spec semantics?                                            | Research needed |
| W5.3  | ui-delivery-pipeline          | Arcana         | Is a full UI pipeline reusable without leaking internal phase choreography?                                          | Research needed |
| W5.4  | pilot-readiness               | Arcana         | Can pilot readiness stand alone without private project-doc sync assumptions?                                        | Research needed |
| W5.5  | brownfield-translation        | Arcana         | Can brownfield translation be reframed as generic system understanding without exposing private artifact generation? | Research needed |
| W5.6  | knowledge-stack-normalization | Arcana         | Can knowledge-stack normalization be generic without source research-stack contracts?                                | Research needed |
| W5.7  | experiment-completion-gate    | Arcana         | Can experiment completion gates be expressed without private gate labels or claim propagation rules?                 | Research needed |
| W5.8  | research-foundations          | Arcana         | Can research foundations be a generic package without private methodology scaffolding?                               | Research needed |
| W5.9  | research-interview            | Arcana         | Can research interview flow be reusable without private project-baseline outputs?                                    | Research needed |
| W5.10 | experiment-index              | Transmutations | Can experiment index maintenance be schema-neutral and package-agnostic?                                             | Research needed |

## Research Note Template

Use this template before extracting any Wave 5 candidate or any candidate that shows hidden coupling during extraction.

```markdown
# Extraction Research Note: {target-sigil}

## Reusable Core

- {What behavior appears generally useful?}

## Private Coupling Risk

- {What source vocabulary, taxonomy, artifact shape, or workflow mechanic must not be copied?}

## Neutral Rewrite Strategy

- {How to express the behavior from first principles?}

## Proposed Tier

- {formulae | transmutations | arcana}

## Extraction Decision

- Decision: keep | rewrite | defer | reject
- Rationale: {reason}

## Minimum Safe Sigil

- {Smallest standalone sigil that preserves value without leakage.}
```

## Iteration Protocol

For each todo:

1. Open only the source skill needed for that todo.
2. Identify reusable behavior and private coupling risk.
3. If risk is low, write the target sigil folder directly.
4. If risk is medium or high, write a research note first.
5. Add or update templates only when they reduce ambiguity.
6. Add the sigil to the registry only after its folder is complete.
7. Run markdown link validation, JSON validation when applicable, and neutral wording scan.
8. Update this roadmap status.

## Neutral Wording Gate

Before a todo is complete, scan the new sigil for private source terms and old source labels. A completed sigil should read as if it was designed for any repository from the beginning.
