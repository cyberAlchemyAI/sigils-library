# Implementation-Plan Template Family

Use this family when invoke needs to translate approved design or architecture into delivery slices, validation strategy, and execution-ready handoff.

## Selection Rules

1. Select `implementation-plan` after architecture or design intent is stable enough to plan delivery.
2. Compose the standalone companions instead of duplicating them: [../implementation-layering.md](../implementation-layering.md) and [../work-pack.md](../work-pack.md).
3. Use [../module-formulae/execution-pack.md](../module-formulae/execution-pack.md) when the plan needs wave execution packaging.

## Templates

| Template | Purpose |
| --- | --- |
| [implementation-plan.md](implementation-plan.md) | Implementation planning contract. |
| [examples/passing.md](examples/passing.md) | Minimal passing implementation-plan example. |
| [examples/missing-input.md](examples/missing-input.md) | Missing-input negative example. |

## Gates

- Block when required source design refs are missing.
- Block plan, full, and validate flows if required standalone layering or work-pack companions are absent without a recorded deferral.
- Flag delivery slices that lack validation strategy.

## Validation

```bash
./tools/check_markdown_links.sh arcanum/spells/invoke/templates/implementation-plan/README.md
./tools/check_markdown_links.sh arcanum/spells/invoke/templates/implementation-plan/implementation-plan.md
./tools/check_markdown_links.sh arcanum/spells/invoke/templates/implementation-plan/examples/passing.md
./tools/check_markdown_links.sh arcanum/spells/invoke/templates/implementation-plan/examples/missing-input.md
```