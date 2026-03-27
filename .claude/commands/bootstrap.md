---
description: Initialize AI Skills agent system for a new project. Run this first after copying .claude/ to any project.
allowed-tools: Read, Grep, Glob, Write, Edit, Bash
---

## Bootstrap Protocol

You are initializing the AI Skills agent system for a new project.

### Step 1: Detect Project
- Read package.json, pyproject.toml, Cargo.toml, go.mod, or any project manifest
- Identify: language, framework, dependencies, project name
- If no manifest found, ask what type of project this is

### Step 2: Update Memory for This Project
- Read .claude/memory/active_projects.md
- Update it with this project's name, type, goal, and tech stack
- Read .claude/memory/tech_stack.md and verify it matches this project's stack
- Add any new technologies not already listed

### Step 3: Verify CLAUDE.md
- Check if CLAUDE.md exists in project root
- If not, create one with project-specific instructions referencing the .claude/ system
- If yes, verify it references the .claude/ agent system

### Step 4: Health Check
- Run the health check: `bash .claude/skills/agent-trainer/scripts/health-check.sh .claude`
- Verify all agents and skills are intact
- Report any issues found

### Step 5: Context Test
- Load context using context-loader skill
- Verify memory files are readable and relevant
- Report what context was loaded

### Output
Report:
- Project detected: [name, type, stack]
- Memory updated: [yes/no]
- CLAUDE.md: [created/verified]
- Health check: [pass/fail with details]
- System status: READY / NEEDS ATTENTION

The project is now ready for `/kickoff [project-description]`.
