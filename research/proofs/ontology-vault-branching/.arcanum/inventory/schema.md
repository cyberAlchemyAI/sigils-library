# Proof Inventory Schema

## Entry Types

| Type | Purpose | Required Fields |
| ---- | ------- | --------------- |
| source | Raw proof source material. | source path, summary, branch |
| ontology-map | Generated branch ontology artifact. | output path, branch, source references |
| bridge-map | Cross-branch traceability artifact. | output path, edge types, gap policy |
| drift-report | Evidence gap and drift artifact. | output path, severity, follow-up |
| context-proof | Retrieval proof for future agents. | output path, obligations, selected evidence |

## Confidence Fields

- Evidence confidence: how much cited source material supports the claim.
- Commitment confidence: how strongly the proof should rely on the claim.
- Bridge confidence: whether business and system evidence support an alignment claim.

## Link Rule

Inventory entries must link to raw sources or generated outputs. They must not cite themselves as evidence.