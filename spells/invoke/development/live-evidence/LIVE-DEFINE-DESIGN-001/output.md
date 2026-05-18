## Invoke Result

- Task ID: `invoke-define-design-live-pass`
- Regime: `LIVE-DEFINE-DESIGN-001`
- Spell: invoke
- Canonical ID: invoke
- Scope: library
- Phase status: pass
- Mode sequence: define then design
- Mode contract: `arcanum/spells/invoke/define.md`, `arcanum/spells/invoke/design.md`
- Outputs: `mars-habitat-supply-request.spec.md`, `mars-habitat-supply-request.glossary.md`, `mars-habitat-supply-request.define-transport.md`, `mars-habitat-supply-request.architecture-bundle.md`, `mars-habitat-supply-request.glossary-consistency.md`, `mars-habitat-supply-request.design-transport.md`
- Design views: context | high-level structure | low-level components | workflow process | decision flow | dependency interface
- Glossary consistency: pass
- Implementation layering: seed emitted
- Work-pack: n/a
- Template or recipe selection: Module Formulae baseline selected for define; Module Formulae architecture profile selected for design
- Decisions: create a supply request module for Mars habitat operators; preserve operator notes; classify categories; mark urgency; record approval status; surface unresolved planning questions
- Unresolved gaps: non-blocking planning questions remain captured in the artifact; no blocker ambiguity
- Next route: deferred

### Define Phase

- Mode: define
- Spell: invoke
- Canonical ID: invoke
- Scope: library
- Phase status: pass
- Mode contract: `arcanum/spells/invoke/define.md`
- Outputs: `mars-habitat-supply-request.spec.md`, `mars-habitat-supply-request.glossary.md`, `mars-habitat-supply-request.define-transport.md`
- Template selection: Module Formulae baseline
- Template evidence: request targets a bounded module with domain concepts, user workflow, governed outputs, and downstream design needs
- Spec evidence: approved define artifact specifies supply request creation, category classification, urgency marking, approval status recording, note preservation, and unresolved planning question surfacing
- Glossary evidence: define glossary establishes authoritative meanings for Supply Request, Operator, Item Category, Urgency, Approval Status, Operator Notes, and Planning Question
- Define transport evidence: define output records source intent, selected template, generated artifacts, unresolved gaps, and next route to design
- Decisions: supply request is the primary aggregate; category, urgency, and approval status are structured fields; notes are preserved as operator-authored context; unresolved planning questions remain visible rather than hidden
- Unresolved gaps: approval authority, category taxonomy ownership, urgency SLA thresholds, inventory integration, and retention policy require later confirmation
- Next route: deferred

### Design Phase

- Mode: design
- Spell: invoke
- Canonical ID: invoke
- Scope: library
- Phase status: pass
- Mode contract: `arcanum/spells/invoke/design.md`
- Outputs: `mars-habitat-supply-request.architecture-bundle.md`, `mars-habitat-supply-request.glossary-consistency.md`, `mars-habitat-supply-request.design-transport.md`
- Template/profile selection: Module Formulae architecture profile
- Source contract evidence: design uses only the define output as authority: supply request creation, item category classification, urgency marking, approval status recording, operator note preservation, unresolved planning question surfacing, and the define glossary terms
- Design views: context | high-level structure | low-level components | workflow process | decision flow | dependency interface
- Glossary consistency: pass
- Design transport evidence: design output records source contracts, six-view coverage, glossary consistency, dependency/interface map, risks, unresolved gaps, and next route
- Decisions: use a single module boundary around supply request intake and review state; keep planning questions as first-class visible records; avoid inventing external inventory, authentication, or approval contracts not present in define output
- Unresolved gaps: external actor identity, inventory source, approval policy, category governance, urgency thresholds, notification rules, and audit retention are captured as planning questions
- Next route: deferred

### Handoff Relationship

- Define-to-design authority: design consumes the define artifact as the only source of functional authority.
- Source contract boundary: no external source contracts are invented beyond the define output.
- Glossary handoff: design terms must match the define glossary exactly or record a consistency issue.
- Gap handoff: unresolved define gaps are preserved in design as planning questions and risks.
- Transport handoff: define transport routes to design; design transport routes to deferred follow-up because plan mode is not requested.

## Primary Define Artifact Body

# Mars Habitat Supply Request Module Specification

## Purpose

The Mars habitat supply request module lets habitat operators create and track supply requests. It provides a governed baseline for recording what is needed, classifying requested items, marking urgency, recording approval status, preserving operator notes, and making unresolved planning questions visible for later resolution.

## Scope

In scope:

- Create a supply request.
- Record requested item details at the level needed by operators.
- Classify requested items by item category.
- Mark request urgency.
- Record approval status.
- Preserve operator notes.
- Surface unresolved planning questions.

Out of scope for this define baseline:

- Inventory reservation behavior.
- Procurement execution.
- Shipment scheduling.
- Authentication and role enforcement.
- Notification delivery.
- SLA calculation.
- Audit retention policy.
- External system integration contracts.

These out-of-scope areas may be designed only when approved source contracts are available.

## Actors

### Operator

An operator is the person using the module to create or maintain a supply request for the Mars habitat.

### Reviewer

A reviewer may update approval status, but the define output does not specify reviewer identity, authority, or workflow rules.

## Functional Requirements

### Supply Request Creation

The module must allow an operator to create a supply request.

A supply request must preserve:

- request title or short description,
- requested item description,
- item category,
- urgency,
- approval status,
- operator notes,
- unresolved planning questions when known.

### Item Category Classification

The module must classify requested items using a structured item category field.

Initial category values are not finalized by this define output. The module must support category assignment without hard-coding a permanent taxonomy.

Candidate examples for later confirmation:

- life support,
- medical,
- food and water,
- maintenance,
- science,
- communications,
- habitat operations.

These examples are not approved source contracts.

### Urgency Marking

The module must allow urgency to be marked on each supply request.

The define output authorizes an urgency field but does not define SLA thresholds, escalation timing, or operational consequences.

Minimum urgency states for design consideration:

- routine,
- important,
- critical.

The exact operational semantics remain unresolved.

### Approval Status Recording

The module must record approval status for each supply request.

Minimum approval states for design consideration:

- draft,
- submitted,
- approved,
- rejected,
- needs clarification.

The define output does not define approval authority, reviewer identity, or transition permissions.

### Operator Notes

The module must preserve operator notes as operator-authored context.

Operator notes must not be silently discarded when request status, category, or urgency changes.

The define output does not specify rich text support, attachment handling, or note retention duration.

### Unresolved Planning Questions

The module must surface unresolved planning questions related to a supply request or to the module baseline.

Planning questions must remain visible as unresolved until answered by an approved follow-up artifact or explicit decision.

## Data Baseline

### Supply Request

Required fields:

- request identifier,
- title or short description,
- requested item description,
- item category,
- urgency,
- approval status,
- operator notes,
- unresolved planning questions,
- created timestamp,
- updated timestamp.

Optional fields for later confirmation:

- requested quantity,
- preferred delivery window,
- habitat zone,
- mission phase,
- linked inventory item,
- reviewer notes,
- external reference.

Optional fields are not source contracts for design unless explicitly marked as unresolved planning questions.

## Decisions

- The module centers on the supply request as the primary record.
- Item category, urgency, and approval status are structured fields.
- Operator notes are preserved as part of the request record.
- Unresolved planning questions are visible module outputs, not private implementation notes.
- External system contracts are not invented in define mode.

## Unresolved Planning Questions

- Who is authorized to approve or reject a supply request?
- What category taxonomy is authoritative?
- What urgency levels are operationally binding?
- Do urgency levels imply escalation, notification, or SLA behavior?
- Should supply requests link to inventory records?
- Should supply requests support quantities and units?
- Should operator notes be append-only or editable?
- Is reviewer commentary separate from operator notes?
- What retention or audit requirements apply?
- Are requests scoped to habitat zones, mission phases, or crew roles?

## Define Glossary

### Supply Request

A structured record created by an operator to request an item or supply-related need for the Mars habitat.

Status: linked to specification.

### Operator

A module user who creates or updates supply request information.

Status: linked to specification.

### Item Category

A structured classification assigned to a requested item.

Status: linked to specification.

### Urgency

A structured marker indicating the relative priority of a supply request.

Status: linked to specification.

### Approval Status

A structured marker representing the review state of a supply request.

Status: linked to specification.

### Operator Notes

Operator-authored text preserved with the supply request.

Status: linked to specification.

### Planning Question

An unresolved question that must remain visible for future decision or design follow-up.

Status: linked to specification.

## Define Transport Report

- Source request: Define and design a Mars habitat supply request module.
- Define mode selected because the authoring baseline was required before design.
- Template selected: Module Formulae baseline.
- Spec artifact emitted: yes.
- Glossary artifact emitted: yes.
- Implementation layering: seed emitted.
- Upstream mutation: none.
- Candidate promotion: none.
- Blockers: none.
- Non-blocking gaps: approval authority, category taxonomy, urgency semantics, inventory integration, note policy, audit retention.
- Recommended next route: design.

## Primary Design Artifact Body

# Mars Habitat Supply Request Module Architecture Bundle

## Source Contracts

The design source contracts come explicitly from the define output.

Authoritative define requirements:

- Operators need to create supply requests.
- Supply requests classify item categories.
- Supply requests mark urgency.
- Supply requests record approval status.
- Supply requests preserve operator notes.
- Supply requests surface unresolved planning questions.
- The supply request is the primary record.
- Item category, urgency, and approval status are structured fields.
- External inventory, procurement, shipment, authentication, notification, SLA, and audit contracts are not defined.

Authoritative define glossary terms:

- Supply Request.
- Operator.
- Item Category.
- Urgency.
- Approval Status.
- Operator Notes.
- Planning Question.

No additional source contracts are introduced by design.

## View 1: Context View

The module sits inside a Mars habitat operations environment as a supply request intake and tracking capability.

Primary interaction:

- Operator creates or updates a supply request.
- Reviewer may update approval status only as an unresolved authority boundary from define.
- The module stores request fields, notes, status, and planning questions.
- The module exposes unresolved planning questions to operators and downstream planning work.

External systems are treated as unknown:

- inventory system,
- procurement system,
- notification system,
- identity system,
- audit system.

Because define did not approve contracts for these systems, design must represent them as future integration points only.

## View 2: High-Level Structure View

The module is organized into five design areas:

### Request Intake Surface

Responsible for capturing operator-entered supply request information.

Inputs:

- title or short description,
- item description,
- item category,
- urgency,
- operator notes,
- planning questions.

### Request Record Model

Responsible for preserving the supply request as a structured record.

Core fields:

- request identifier,
- title or short description,
- requested item description,
- item category,
- urgency,
- approval status,
- operator notes,
- unresolved planning questions,
- created timestamp,
- updated timestamp.

### Classification Controls

Responsible for item category and urgency selection.

This area must remain taxonomy-flexible because define did not approve a final category set or urgency semantics.

### Approval Status Controls

Responsible for recording approval status.

This area must avoid encoding authority or transition rules that define did not authorize.

### Planning Question Surface

Responsible for displaying unresolved planning questions and keeping them attached to the relevant request or module baseline.

## View 3: Low-Level Components View

### SupplyRequest

Represents the primary module record.

Fields:

- id,
- title,
- itemDescription,
- itemCategory,
- urgency,
- approvalStatus,
- operatorNotes,
- planningQuestions,
- createdAt,
- updatedAt.

### ItemCategoryField

A structured field for classifying requested items.

Design rule:

- must support configurable category values;
- must not assume final taxonomy authority.

### UrgencyField

A structured field for marking priority.

Design rule:

- may support routine, important, and critical as candidate display values;
- must not attach SLA, escalation, or notification behavior without a later source contract.

### ApprovalStatusField

A structured field for review state.

Design rule:

- may support draft, submitted, approved, rejected, and needs clarification as candidate display values;
- must not enforce transition policy without approval authority source contracts.

### OperatorNotes

A preserved text field or note collection.

Design rule:

- notes must remain available after request edits;
- deletion, append-only behavior, and retention are unresolved.

### PlanningQuestion

A visible unresolved question.

Fields:

- question text,
- scope,
- status,
- related request identifier when applicable.

Allowed status:

- unresolved,
- answered.

Answering policy is deferred until an approved follow-up contract exists.

## View 4: Workflow Process View

1. Operator starts a supply request.
2. Operator enters requested item information.
3. Operator assigns an item category.
4. Operator marks urgency.
5. Module records an initial approval status.
6. Operator adds notes.
7. Operator records any unresolved planning questions.
8. Module preserves the request record.
9. Operator or reviewer views request state and unresolved questions.
10. Later approved workflows may update approval status or answer planning questions.

Workflow constraints:

- The module must not silently remove operator notes.
- The module must not hide unresolved planning questions.
- The module must not imply inventory reservation, procurement, shipment, notification, or SLA behavior.

## View 5: Decision Flow View

### Creating a Request

Decision: Is required request information present?

- If yes, create the request record.
- If no, keep the request in draft or incomplete state.

Source status:

- Draft behavior is supported as a candidate approval status from define evidence.
- Required-field strictness is unresolved.

### Classifying Category

Decision: Is the selected category available in the configured category set?

- If yes, store category.
- If no, surface a planning question or taxonomy gap.

Source status:

- Category classification is required.
- Final taxonomy is unresolved.

### Marking Urgency

Decision: Has the operator selected urgency?

- If yes, store urgency.
- If no, surface incomplete request state.

Source status:

- Urgency marking is required.
- Operational consequences are unresolved.

### Recording Approval Status

Decision: Is an approval status update being recorded?

- If yes, store status value.
- If no, retain current status.

Source status:

- Approval status recording is required.
- Authority and transition rules are unresolved.

### Preserving Notes

Decision: Are notes changed?

- If yes, preserve the latest note state according to the eventual note policy.
- If no, retain existing notes.

Source status:

- Preservation is required.
- Append-only versus editable behavior is unresolved.

### Surfacing Planning Questions

Decision: Does a planning question exist?

- If yes, show it as unresolved.
- If answered by a later approved artifact, mark it answered.
- If no, no planning question is displayed.

Source status:

- Surfacing unresolved questions is required.
- Answering authority is unresolved.

## View 6: Dependency Interface View

### Internal Interfaces

Request intake writes to the request record model.

Classification controls read configured category and urgency options and write selected values to the request record.

Approval status controls write approval status values to the request record.

Planning question surface reads and writes planning question records attached to requests or the module baseline.

### External Interfaces

No external interface is authorized as a source contract by the define output.

Deferred interface candidates:

- identity provider,
- inventory catalog,
- notification service,
- audit log,
- procurement workflow,
- mission planning system.

Each candidate requires a later approved source contract before implementation planning can treat it as real.

## Glossary Consistency Report

- Supply Request: pass; design uses the term as the primary structured record.
- Operator: pass; design uses the term for the module user creating or updating request information.
- Item Category: pass; design uses the term as a structured classification field.
- Urgency: pass; design uses the term as a priority marker without invented SLA behavior.
- Approval Status: pass; design uses the term as a recorded review state without invented authority rules.
- Operator Notes: pass; design preserves notes as operator-authored context.
- Planning Question: pass; design keeps unresolved questions visible for future decision.

No glossary conflicts found.

## Design Decisions

- Keep the module boundary focused on supply request intake and status visibility.
- Treat the define output as the only design authority.
- Preserve unresolved questions as first-class records.
- Keep category and urgency values configurable because final governance is unresolved.
- Record approval status without inventing approval authority.
- Represent external systems as deferred integration candidates only.

## Risks

- Approval workflows may need redesign if authority rules are complex.
- Category taxonomy may affect data model validation.
- Urgency semantics may introduce SLA, notification, or escalation requirements.
- Inventory linkage may require external identifiers not present in the define output.
- Notes retention may require audit or compliance behavior.
- Planning question ownership may affect who can mark questions answered.

## Design Transport Report

- Source define artifact consumed: `mars-habitat-supply-request.spec.md`.
- Source glossary consumed: `mars-habitat-supply-request.glossary.md`.
- Source contract policy: define output only.
- Template/profile selected: Module Formulae architecture profile.
- Six design views present: yes.
- Glossary consistency: pass.
- Upstream mutation: none.
- Candidate promotion: none.
- Work-pack emitted: no.
- Implementation-ready tasks emitted: no.
- Blockers: none.
- Non-blocking gaps: approval authority, category taxonomy, urgency thresholds, inventory integration, notification behavior, audit retention, note edit policy.
- Recommended next route: deferred.