---
name: migration
description: Author a Laravel migration then write Pest tests for it
steps:
  - agent: migrator
    task: "{task}"
    output: migration-summary.md
  - agent: test-writer
    task: |
      Write Pest tests covering the migration and any related model or factory changes
      described below. Run git diff to see exactly what was added.

      Migration summary:
      {previous}
---
