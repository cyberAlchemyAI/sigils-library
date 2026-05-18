# INV-DEFINE-GLOSSARY-001

## Scenario

Glossary contains a new no-match term that must not be silently promoted.

## User Request

Define an experiment session notebook for Mars geology analysis. The notebook introduces a local term, "sol-thread", for observations grouped by Martian day and analyst discussion.

## Inputs

- Mode: `define`
- Core goal: present
- Scope hints: present
- Existing artifacts: absent
- Template inventory: present
- Candidate-template permission: not needed
- Necronomicon concept sources: available
- New glossary term: sol-thread

## Expected Result

- Phase status: `pass`
- Template selection: research or generic family
- Outputs: spec artifact, glossary artifact, define transport report
- Glossary linking: `sol-thread` is no-match with rationale and promotion gate
- Implementation layering: seed emitted or gap recorded
- Expected next route: `deferred`

## Expected Output

[INV-DEFINE-GLOSSARY-001.expected.md](INV-DEFINE-GLOSSARY-001.expected.md)
