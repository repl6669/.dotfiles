---
name: feature
description: Implement a feature then review it
steps:
  - agent: laravel-worker
    task: "{task}"
  - agent: laravel-reviewer
    task: |
      Review the changes just implemented. Be adversarial.

      Worker summary:
      {previous}
---
