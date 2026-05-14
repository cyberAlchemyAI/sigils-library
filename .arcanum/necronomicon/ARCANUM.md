# Arcanum

**Arcanum** is a framework and registry for reusable agent capabilities.

The framework defines how sigils are designed, validated, composed, observed, and maintained. The registry catalogs the reusable sigils and spells that can be installed, adapted, or invoked in a consuming repository. Installed repositories route runtime lookup through Necronomicon, the local runtime book under `.arcanum/necronomicon/`.

Start with the [Sigil Registry](registry/SIGILS.md) when you know the kind of work you need. Start with the [Framework](framework/) when you are authoring, reviewing, or maintaining sigils. For workflows that combine multiple sigils, use the [Spell Registry](registry/SPELLS.md).

## Repository Shape

```text
arcanum/
	framework/       rules, lifecycle, templates, observability, and runtime contracts
	registry/        indexes of reusable sigils, spells, and future packs
	formulae/        deterministic operational sigils
	transmutations/  bounded cognitive synthesis sigils
	arcana/          autonomous orchestration sigils
	spells/          reusable workflow compositions
```

## Necronomicon Runtime Book

Necronomicon is generated during installation inside a consuming repository at `.arcanum/necronomicon/`.

It is the runtime control plane for installed Arcanum usage:

- registry lookup for installed sigils and spells,
- orchestration routes and alias resolution,
- installed sigil and spell definitions under `.arcanum/necronomicon/formulae/`, `.arcanum/necronomicon/transmutations/`, `.arcanum/necronomicon/arcana/`, and `.arcanum/necronomicon/spells/`,
- observability handoff into `.arcanum/observability/`.

Runtime adapters should read Necronomicon first. The installed definitions live inside Necronomicon; the upstream repository remains the canonical development source.

## Framework

The [framework](framework/) is the operating model for sigils.

It defines:

- the tier ontology,
- sigil authoring lifecycle,
- quality and failure boundaries,
- behavior contract shape,
- observability and reflection rules,
- spell composition rules,
- local runtime expectations such as `.arcanum/`.

Important framework references:

- [Quality Bar](framework/QUALITY-BAR.md) - observable criteria for successful execution.
- [Anti-Patterns](framework/ANTI-PATTERNS.md) - known misuse cases and failure modes to avoid.
- [Sigil Development Workflow](framework/SIGIL-DEVELOPMENT-WORKFLOW.md) - lifecycle from candidate capture through maintenance.
- [Sigil Template](framework/templates/sigil-template.md) - base structure for new `SKILL.md` files.
- [Observability](framework/observability/) - telemetry and reflection conventions for iterating sigils from usage evidence.
- [Repository Observability Package](framework/observability/REPOSITORY-PACKAGE.md) - portable local storage model for sigil telemetry in consuming repositories.
- [Sigil Observability Hook](framework/observability/SIGIL-OBSERVABILITY-HOOK.md) - post-run hook pattern for saving sigil invocation summaries as JSON telemetry.

## Registry

The [registry](registry/) is the catalog of reusable Arcanum artifacts.

- [Sigil Registry](registry/SIGILS.md) - quick-reference index of available sigils.
- [Spell Registry](registry/SPELLS.md) - quick-reference index of offered spell compositions.
- [Packs](registry/PACKS.md) - future grouping model for curated bundles.

## Ontology Of Sigils

Capabilities are categorized by epistemic nature: how an agent processes information and executes logic.

- [Formulae](formulae/) - deterministic operational sigils.
- [Transmutations](transmutations/) - bounded cognitive synthesis sigils.
- [Arcana](arcana/) - autonomous orchestration sigils.

Each tier has a concept file that expands the category and gives authors a placement rule.

### Formulae

Formulae are deterministic operational sigils: rule-based, stateless, and repeatable.

- Expanded concept: [formulae/README.md](formulae/README.md)
- Setup sigil: [observability-setup](formulae/observability-setup/)

### Transmutations

Transmutations are bounded cognitive synthesis sigils: interpretive transformations that reduce ambiguity while preserving source grounding.

- Expanded concept: [transmutations/README.md](transmutations/README.md)
- Example sigil: [implementation-layering](transmutations/implementation-layering/)

### Arcana

Arcana are autonomous orchestration sigils: recursive, multi-turn, or governance-heavy workflows that manage uncertainty across goals, evidence, roles, and decisions.

- Expanded concept: [arcana/README.md](arcana/README.md)
- Example sigil: [robot-talks](arcana/robot-talks/)
- Lifecycle sigil: [sigil-development](arcana/sigil-development/)

## Composition Layer: Spells

[Spells](spells/) sit above the tier ontology as composition recipes. They combine sigils into localized workflows with shared state, gates, handoffs, and observability.

- Concept: [spells/README.md](spells/README.md)
- Composer sigil: [spellcraft](arcana/spellcraft/)
- Registry: [registry/SPELLS.md](registry/SPELLS.md)

## Installing Arcanum Into Another Repository

Use the [Arcanum Bootstrap](spells/arcanum-bootstrap.md) spell or the bootstrap script to install Arcanum into a consuming repository:

```bash
curl -fsSL https://raw.githubusercontent.com/cyberAlchemyAI/arcanum/main/tools/install_arcanum.sh | bash -s -- --target . --sigils all --spells all --runtime github-copilot
```

When working from a local checkout, use the repository bootstrap script directly:

```bash
tools/bootstrap_arcanum.sh --target <repo> --sigils all --spells all --runtime github-copilot
```

Both paths install Arcanum under `.arcanum/`, with Necronomicon runtime files and installed definitions under `.arcanum/necronomicon/`, observability under `.arcanum/observability/`, and runtime adapters under `.arcanum/runtimes/`. GitHub Copilot, Claude, and Codex may still require tiny discovery bridges in their platform-specific folders, but canonical local runtime behavior lives inside `.arcanum/`. Use `--sigils <comma-separated-list>` and `--spells <comma-separated-list>` for selected installs.

When a runtime is selected, bootstrap installs both the general `arcanum-orchestrate` adapter and individual adapters for every installed sigil and spell. Individual adapter names use `arcanum-sigil-<id>` and `arcanum-spell-<id>`.

## Research And Proofs

[Research](research/) contains small proof runs and framework experiments.

- [Ontology Vault Branching Proof](research/proofs/ontology-vault-branching/) demonstrates business ontology, system ontology, bridge edges, traceability, and drift reporting with a neutral sample vault.

## Sigil Folder Model

Each sigil lives in its own folder under the tier that best matches its epistemic nature.

Every sigil folder should include:

- `README.md` - a human-facing explanation of what the sigil is, the problem it solves, when to use it, when not to use it, and how it fits the tier.
- `SKILL.md` - the executable agent instruction contract, including trigger conditions, process, quality bar, anti-patterns, and output contract.
- `templates/` - optional reusable artifacts used by the sigil.

Spell files live under [spells](spells/) for reusable Arcanum compositions or `.arcanum/spells/` for repository-local adaptations. A spell references sigils and defines orchestration; it should not copy the internals of the sigils it composes.

## Contribution And Governance

To add a new sigil:

1. Follow the [Sigil Development Workflow](framework/SIGIL-DEVELOPMENT-WORKFLOW.md).
2. Draft from the [Sigil Template](framework/templates/sigil-template.md).
3. Assign the sigil to `formulae/`, `transmutations/`, or `arcana/` based on epistemic nature.
4. Include a [Quality Bar](framework/QUALITY-BAR.md) and [Anti-Patterns](framework/ANTI-PATTERNS.md).
5. Register promoted sigils in [registry/SIGILS.md](registry/SIGILS.md).

## License

Copyright © 2026 Cyber Alchemy AI.
