# Proof Inventory Index

## Indexed Entries

| Entry | Type | Branch | Summary | Path |
| ----- | ---- | ------ | ------- | ---- |
| Ontology Vault Branching | synthesis | bridge | Proof package covering business/system branch mapping, bridge validation, traceability, drift, and context retrieval. | [entries/ontology-vault-branching.md](entries/ontology-vault-branching.md) |
| Business Intent Source | source | business | Business capability, rules, value claims, and premises for quote eligibility. | [../../source-vault/business-intent.md](../../source-vault/business-intent.md) |
| System Runtime Source | source | system | Components, tests, observability signals, and constraints for quote eligibility implementation. | [../../source-vault/system-runtime.md](../../source-vault/system-runtime.md) |
| Business Ontology Map | ontology-map | business | Business concepts, rules, confidence, outcomes, value measures, and open questions. | [../../outputs/business-ontology-map.md](../../outputs/business-ontology-map.md) |
| System Ontology Map | ontology-map | system | System artifacts, flows, tests, observability, constraints, and open questions. | [../../outputs/system-ontology-map.md](../../outputs/system-ontology-map.md) |
| Business System Bridge | bridge-map | bridge | Cross-branch bridge edges, alignment claims, bridge gaps, and decisions needed. | [../../outputs/business-system-bridge.md](../../outputs/business-system-bridge.md) |
| Traceability Matrix | bridge-map | bridge | Matrix linking business claims to system artifacts, tests, observability, and status. | [../../outputs/traceability-matrix.md](../../outputs/traceability-matrix.md) |
| Ontology Drift Report | drift-report | bridge | Drift and evidence gaps that prevent overclaiming implementation alignment. | [../../outputs/ontology-drift-report.md](../../outputs/ontology-drift-report.md) |
| Context Retrieval Proof | context-proof | bridge | Lean context pack proving future retrieval over the proof artifacts. | [../../outputs/context-retrieval-proof.md](../../outputs/context-retrieval-proof.md) |

## Retrieval Tasks

| Task | Start With | Then Read |
| ---- | ---------- | --------- |
| Map business branch | Business Intent Source | Business Ontology Map |
| Map system branch | System Runtime Source | System Ontology Map |
| Validate bridge | Business System Bridge | Traceability Matrix, Ontology Drift Report |
| Reuse as template | Context Retrieval Proof | Ontology Harness Run Report |