# Sigils Registry

This registry is the quick-reference index for the sigils in this library.

Use it when you know the kind of work you need and want to find the right sigil folder quickly. Each entry summarizes what the sigil does, when to use it, its tier, and where its full instructions live.

## Registry Table

| Sigil | Tier | Summary | Use When | Folder |
| ----- | ---- | ------- | -------- | ------ |
| Implementation Layering | Transmutations | Turns an implementation goal into staged layers, starting with the smallest useful proof and progressing through evidence-based hardening. | You need to plan a feature, workflow, infrastructure change, or system improvement without overloading the first build step. | [transmutations/implementation-layering/](transmutations/implementation-layering/) |
| Robot-Talks | Arcana | Coordinates a multi-agent investigation to discover contradictions across system layers before implementation begins. | A problem spans multiple layers and misunderstanding the system is more expensive than a structured investigation. | [arcana/robot-talks/](arcana/robot-talks/) |
| Sigil Development | Arcana | Guides sigil creation, revision, observability, telemetry, reflection, and iteration through a governed lifecycle. | You are creating, improving, observing, reflecting on, or maintaining a sigil. | [arcana/sigil-development/](arcana/sigil-development/) |

## By Tier

### Formulae

No Formulae sigils are registered yet.

Formulae are deterministic operational sigils. See [formulae/](formulae/) for the tier concept.

### Transmutations

- [Implementation Layering](transmutations/implementation-layering/) - staged implementation planning from minimum proof to progressive hardening.

Transmutations are bounded cognitive synthesis sigils. See [transmutations/](transmutations/) for the tier concept.

### Arcana

- [Robot-Talks](arcana/robot-talks/) - multi-agent cross-layer tension discovery.
- [Sigil Development](arcana/sigil-development/) - governed sigil lifecycle with observability and reflection.

Arcana are autonomous orchestration sigils. See [arcana/](arcana/) for the tier concept.

## Entry Requirements

A sigil should be added to this registry when it has:

- a dedicated folder under the correct tier,
- a human-facing `README.md`,
- an executable `SKILL.md`,
- a clear Quality Bar,
- clear Anti-Patterns,
- an output contract,
- observability or reflection guidance when the sigil is expected to be reused.

## Maintenance Rule

Update this registry whenever a sigil is added, renamed, retired, moved between tiers, or materially changes its purpose.