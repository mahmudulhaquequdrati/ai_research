---
name: train
description: Train and improve an agent or skill based on performance data. Runs the autoresearch improvement loop.
allowed-tools: Read, Grep, Glob, Write, Edit
---

Run the agent-trainer skill to improve: $ARGUMENTS

1. Read the target agent/skill definition
2. Check `.claude/memory/agent_performance_log.md` for recent scores
3. Diagnose issues using the diagnosis matrix
4. Make targeted improvements
5. Log changes in memory

If no specific target given, review all agents and train the weakest performer.
