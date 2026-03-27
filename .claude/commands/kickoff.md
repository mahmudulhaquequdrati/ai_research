---
name: kickoff
description: Start a new project with structured decomposition, agent assignment, and execution plan.
allowed-tools: Read, Grep, Glob, Bash, Agent, TodoWrite
---

Run the project-kickoff skill to decompose and plan this project.

Before starting:
1. Read CLAUDE.md for business context
2. Check `.claude/memory/MEMORY.md` for relevant project history
3. Load `.claude/memory/feedback_log.md` for behavior preferences

Execute the full project-kickoff skill and present the plan before starting implementation.

Project: $ARGUMENTS
