---
name: bug
description: Analyse a bug with tester then fix it with worker
steps:
  - agent: tester
    task: "Analyse this bug: {task}"
    output: bug-analysis.md
  - agent: laravel-worker
    task: |
      Fix the bug based on this analysis. Do not expand scope beyond the identified
      root cause and its immediate consequences.

      Bug analysis:
      {previous}
---
