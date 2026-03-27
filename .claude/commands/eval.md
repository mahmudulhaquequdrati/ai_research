---
name: eval
description: Self-evaluate the most recent completed work using the autoresearch improvement loop.
allowed-tools: Read, Grep, Glob, Write, Edit
---

Run the self-eval skill on the most recent completed work.

1. Audit task completion (count requested vs delivered)
2. Score all 5 quality dimensions
3. Calculate weighted overall score
4. Root cause analysis for any issues
5. Update `.claude/memory/agent_performance_log.md` with results
6. If score < 8, identify and apply improvements to the responsible agent/skill
