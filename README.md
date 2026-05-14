# Sigils Library — Cyber Alchemy AI

The **Sigils Library** is the authoritative registry of agentic capabilities for the **Cyber Alchemy AI** ecosystem. It serves as a repository of codified patterns of intent—combining system instructions, tool definitions, and reasoning constraints—that allow agents to interact with complex systems.

Start with the [Sigils Registry](REGISTRY.md) for a concise summary of each sigil and a direct link to its folder.

## 🏛️ Ontology of Sigils

Capabilities are categorized by their **Epistemic Nature**, defining how an agent processes information and executes logic.

Each tier has a concept file that expands the category and gives authors a clearer placement rule:

- [Formulae](formulae/) - deterministic operational sigils.
- [Transmutations](transmutations/) - bounded cognitive synthesis sigils.
- [Arcana](arcana/) - autonomous orchestration sigils.

Two cross-tier authoring concepts apply to every sigil:

- [Sigils Registry](REGISTRY.md) - quick-reference index of available sigils.
- [Quality Bar](QUALITY-BAR.md) - observable criteria for successful execution.
- [Anti-Patterns](ANTI-PATTERNS.md) - known misuse cases and failure modes to avoid.
- [Sigil Development Workflow](SIGIL-DEVELOPMENT-WORKFLOW.md) - the lifecycle for designing, validating, observing, reflecting on, and maintaining sigils.
- [Observability](observability/) - telemetry and reflection conventions for iterating sigils from usage evidence.

### 1. Formulae (Operational Layer)

**Deterministic Skills**  
Strictly defined procedures where the outcome is a direct result of the inputs.

- **Nature:** Rule-based, stateless, and non-probabilistic.
- **Purpose:** Data validation, structural formatting, API interactions, and technical constraints.
- **Success Metric:** 100% reliability and repeatability.
- **Expanded Concept:** [formulae/README.md](formulae/README.md)

### 2. Transmutations (Synthetic Layer)

**Cognitive Skills**  
Capabilities that leverage LLM reasoning to alter the state, format, or semantic value of information.

- **Nature:** Probabilistic, interpretive, and context-aware.
- **Purpose:** Summarization, structured extraction, "lead-to-gold" data refining, and cross-domain translation.
- **Success Metric:** Semantic accuracy and entropy reduction.
- **Expanded Concept:** [transmutations/README.md](transmutations/README.md)
- **Example Sigil:** [implementation-layering](transmutations/implementation-layering/)

### 3. Arcana (Sovereign Layer)

**Autonomous Behaviors**  
High-level reasoning frameworks that allow agents to manage their own goal-seeking and multi-agent orchestration.

- **Nature:** Recursive, multi-turn, and strategic.
- **Purpose:** Tension discovery (`robot-talks`), system auditing, and long-term research orchestration.
- **Success Metric:** Emergent insight and alignment with organizational governance.
- **Expanded Concept:** [arcana/README.md](arcana/README.md)
- **Example Sigil:** [robot-talks](arcana/robot-talks/)
- **Lifecycle Sigil:** [sigil-development](arcana/sigil-development/)

---

## 📁 Skill Folder Model

Each sigil lives in its own folder under the tier that best matches its epistemic nature.

Every skill folder should include:

- `README.md` - a human-facing explanation of what the sigil is, the problem it solves, when to use it, when not to use it, and how it fits the tier.
- `SKILL.md` - the executable agent instruction contract, including trigger conditions, process, quality bar, anti-patterns, and output contract.
- `templates/` - optional reusable artifacts used by the sigil.

The folder README explains intent. The skill file defines behavior. Templates provide repeatable output shapes.

---

## 🛠️ Contribution & Governance

To add a new Sigil to the vault, follow the **Initiation Path**:

1.  **Workflow:** Follow the [Sigil Development Workflow](SIGIL-DEVELOPMENT-WORKFLOW.md) from candidate capture through maintenance.
2.  **Drafting:** Utilize the standard [sigil-template.md](sigil-template.md) located at the library root.
3.  **Tiering:** Assign the Sigil to `formulae/`, `transmutations/`, or `arcana/` based on its epistemic nature.
4.  **Verification:** Every Sigil must include a [Quality Bar](QUALITY-BAR.md) and an [Anti-Patterns](ANTI-PATTERNS.md) section to ensure reliability.
5.  **Origin:** All Sigils should include a short origin note or rationale explaining why the capability belongs in the library.

---

## ⚖️ License

Copyright © 2026 Cyber Alchemy AI.
