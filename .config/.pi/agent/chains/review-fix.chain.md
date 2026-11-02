---
name: review-fix
description: Review the current diff then immediately fix all must-fix and should-fix findings
steps:
  - agent: laravel-reviewer
    task: "Review the current diff or the scope given. Task context: {task}"
    output: review.md
  - agent: laravel-worker
    task: |
      Apply the must-fix and should-fix items from this review. Do not expand scope
      beyond what is listed. Skip anything marked nice-to-have or deferred.

      Review findings:
      {previous}

      Original task context: {task}
---
