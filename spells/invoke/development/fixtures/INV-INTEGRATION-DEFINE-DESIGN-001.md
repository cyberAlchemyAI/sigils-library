# INV-INTEGRATION-DEFINE-DESIGN-001

## Scenario

End-to-end define-to-design handoff for one realistic user request.

## User Request

Use `invoke` to define and then design a Mars rover maintenance log module. The module must capture daily inspection notes, component status, operator decisions, unresolved repair questions, and a plan-ready architecture handoff.

## Stage 1: Define Inputs

- Mode: `define`
- Core goal: present
- Scope hints: daily inspection notes, component status, operator decisions, unresolved repair questions
- Existing artifacts: absent
- Template inventory: present
- Necronomicon concept sources: available

## Stage 1: Expected Define Outputs

[INV-INTEGRATION-DEFINE-DESIGN-001.define.expected.md](INV-INTEGRATION-DEFINE-DESIGN-001.define.expected.md)

## Stage 2: Design Inputs

- Mode: `design`
- Approved spec: [INV-INTEGRATION-DEFINE-DESIGN-001.spec.md](INV-INTEGRATION-DEFINE-DESIGN-001.spec.md)
- Approved glossary: [INV-INTEGRATION-DEFINE-DESIGN-001.glossary.md](INV-INTEGRATION-DEFINE-DESIGN-001.glossary.md)
- Define transport report: [INV-INTEGRATION-DEFINE-DESIGN-001.define-transport.md](INV-INTEGRATION-DEFINE-DESIGN-001.define-transport.md)
- Source contracts: approved define outputs
- Design constraints: preserve glossary terms and produce plan-ready handoff notes

## Stage 2: Expected Design Outputs

[INV-INTEGRATION-DEFINE-DESIGN-001.design.expected.md](INV-INTEGRATION-DEFINE-DESIGN-001.design.expected.md)

Design artifacts:

- [INV-INTEGRATION-DEFINE-DESIGN-001.architecture.md](INV-INTEGRATION-DEFINE-DESIGN-001.architecture.md)
- [INV-INTEGRATION-DEFINE-DESIGN-001.glossary-consistency.md](INV-INTEGRATION-DEFINE-DESIGN-001.glossary-consistency.md)
- [INV-INTEGRATION-DEFINE-DESIGN-001.design-transport.md](INV-INTEGRATION-DEFINE-DESIGN-001.design-transport.md)

## Integration Assertions

- Define result emits spec, glossary, and define transport outputs.
- Design input references the define spec and glossary.
- Design result preserves define glossary terms.
- Design result includes all six required architecture views.
- Design artifact contains the actual six-view architecture content a user would inspect.
- Design result records a design transport output.
- Design result routes next to `plan`.
