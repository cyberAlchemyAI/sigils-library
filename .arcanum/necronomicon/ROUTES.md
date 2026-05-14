# Necronomicon Routes

## Purpose

Route user requests to installed Arcanum sigils or spells without making runtime adapters inspect library registries directly.

## Routing Process

1. Read [REGISTRY.md](REGISTRY.md).
2. Classify the request as sigil usage, spell usage, install/setup, authoring, validation, observability, or help.
3. Select one installed sigil or spell from the Necronomicon registry.
4. If multiple routes are plausible, ask one focused clarification.
5. Open the selected definition path from [REGISTRY.md](REGISTRY.md).
6. Follow the selected artifact's process, quality bar, anti-patterns, output contract, and validation gates.
7. Apply the observability handoff in [OBSERVABILITY.md](OBSERVABILITY.md) after meaningful execution.

## Route Hints

| Request Shape | Preferred Route |
| ------------- | --------------- |
| install Arcanum or runtime adapters | arcanum-bootstrap or sigil-runtime-installer |
| create, revise, observe, or reflect on sigils | sigil-development |
| convert a skill or workflow into a sigil | skill-transcriptor |
| decompose a broad source into sigil candidates | skill-decomposer |
| compose multiple sigils into a workflow | spellcraft |
| setup or verify telemetry | observability-setup |
| build compact task context | context-builder |
| map repository architecture | architecture-pattern-inventory |
| govern vault-like knowledge | ontology-vault or ontology-harness |
| repository knowledge harness | repository-harness |

## Guardrails

- Necronomicon is the runtime registry and orchestration layer.
- Files under formulae/, transmutations/, arcana/, and spells/ are installed definitions, not the runtime router.
- Runtime adapters should not bypass Necronomicon unless Necronomicon is missing or corrupted.
- Observability handoff belongs to Necronomicon, even though telemetry files live under ../observability/.
