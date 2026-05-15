# Ontology Vault Branching Proof

This proof demonstrates that Arcanum's [ontology-vault](../../../arcana/ontology-vault/) sigil can model a small vault with three coordinated layers:

- business ontology for intent and meaning,
- system ontology for implementation and runtime facts,
- bridge ontology for traceability, tests, observability, constraints, and drift.

The proof uses a tiny neutral example instead of a project-specific repository so the branching pattern remains portable.

## Source Vault

- [business-intent.md](source-vault/business-intent.md) - domain intent, rules, outcomes, and value claims.
- [system-runtime.md](source-vault/system-runtime.md) - implementation artifacts, tests, telemetry, and constraints.

## Generated Branch Artifacts

- [business-ontology-map.md](outputs/business-ontology-map.md)
- [system-ontology-map.md](outputs/system-ontology-map.md)
- [business-system-bridge.md](outputs/business-system-bridge.md)
- [traceability-matrix.md](outputs/traceability-matrix.md)
- [ontology-drift-report.md](outputs/ontology-drift-report.md)

## Harness Setup

- [Ontology Harness Run Report](outputs/ontology-harness-run-report.md) - spell-level execution report for this proof.
- [Context Retrieval Proof](outputs/context-retrieval-proof.md) - compact context-builder proof that future tasks can retrieve the branch evidence.
- [Proof Inventory](.arcanum/inventory/index.md) - proof-local inventory index for source and generated artifacts.
- [Observability Package](.arcanum/observability/README.md) - proof-local sigil telemetry package and invocation event.

## Proof Result

See [proof-report.md](proof-report.md) for the pass/flag/block result and what the proof shows.
