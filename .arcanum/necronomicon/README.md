# Necronomicon Repository Harness

This folder stores repository-local Necronomicon harness state: selected capabilities, session memory, route ledgers, decisions, handoffs, and capability update reports.

It is not a copied Arcanum definition store. Runtime command definitions live under .arcanum/runtimes/, and canonical Arcanum source remains upstream or embedded in generated command snapshots.

Expected contents:

- capabilities.json records selected local commands and fallback policy.
- sessions/ stores Necronomicon session memory and route history.
- capability-updates/ stores explicit add, remove, or refresh reports.

Do not place copied formulae, transmutations, arcana, spells, registries, or framework folders here.
