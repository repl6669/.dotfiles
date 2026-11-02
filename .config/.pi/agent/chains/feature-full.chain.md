---
name: feature-full
description: Full feature cycle — implement, review, then write tests
steps:
  - agent: laravel-worker
    task: "{task}"
    output: implementation-summary.md
  - agent: laravel-reviewer
    task: |
      Review the implementation. Be adversarial — look for bugs, missing auth,
      N+1s, and test gaps.

      Worker summary:
      {previous}
    output: review.md
  - agent: test-writer
    task: |
      Write Pest tests covering the implemented feature. Pay attention to any test
      gaps flagged in the review. Run git diff to see exactly what was implemented.

      Review findings:
      {previous}
---
