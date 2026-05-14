# Arcanum Registry

The Arcanum registry catalogs reusable sigils and spells.

Use it when you want to choose a capability, install a composition, or review what the framework currently offers.

## Catalogs

- [Sigils](SIGILS.md) - available sigils by tier and use case.
- [Spells](SPELLS.md) - reusable compositions of multiple sigils.
- [Packs](PACKS.md) - future curated bundles of related sigils and spells.

## Registry Rules

A registry entry should be stable enough for another repository to reference it by name.

Register a sigil only when it has:

- a folder under `formulae/`, `transmutations/`, or `arcana/`,
- a human-facing `README.md`,
- an executable `SKILL.md`,
- a clear output contract,
- quality and anti-pattern guidance,
- observability or reflection guidance when reuse is expected.

Register a spell only when it names the sigils it composes, phase order, shared state, gates, handoffs, observability, and output contract.

## Framework Boundary

The registry lists reusable artifacts. The [framework](../framework/) defines how those artifacts are authored, reviewed, observed, and maintained.