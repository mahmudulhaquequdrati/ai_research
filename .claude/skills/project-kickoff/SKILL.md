---
name: project-kickoff
description: Structured project initialization. Decomposes any project into phases, tasks, and deliverables with agent assignments. Use when starting any new project, feature, or significant work.
argument-hint: "[project-description]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash, Agent
model: opus
effort: high
---

# Project Kickoff Skill

Initialize project: `$ARGUMENTS`

## Process

### 1. Requirements Extraction
1. Parse the full request carefully
2. List EVERY discrete deliverable — number them explicitly
3. Identify implicit requirements (testing, docs, deployment)
4. Check [reference.md](reference.md) for agent-to-task mapping

### 2. Architecture Decision
1. Simplest approach that fully solves the problem
2. Best-fit tech stack (check memory for preferences)
3. Existing code/tools to reuse
4. Technical risks and mitigations

### 3. Task Decomposition
For each deliverable:
- Break into implementable tasks (max 2 hours each)
- Identify dependencies (what blocks what)
- Assign to the right agent
- Estimate: S (< 30min) / M (30min-2hr) / L (2hr+)

### 4. Execution Plan
- Phase 1: Setup and scaffolding
- Phase 2: Core implementation (parallel where possible)
- Phase 3: Integration and testing
- Phase 4: Polish, docs, and deployment

### 5. Quality Gates
- After Phase 2: Code review via `code-review` skill
- After Phase 3: QA eval via `self-eval` skill
- After Phase 4: Final verification, count deliverables vs requirements

## Output Format

```markdown
## Project: [Name]

### Requirements ([X] total)
1. [requirement]
...

### Task Breakdown
| # | Task | Agent | Size | Depends On | Phase |
|---|------|-------|------|------------|-------|
| 1 | ... | software-engineer | M | — | 1 |

### Execution Order
Phase 1 (parallel): tasks [1, 2, 3]
Phase 2 (sequential): task [4] -> task [5]
...

### Risks
1. [risk] — Mitigation: [plan]

### Success Criteria
- [ ] All [X] requirements delivered
- [ ] Tests passing
- [ ] No dummy data
```

## Rules
- Always check `.claude/memory/active_projects.md` to avoid duplicate work
- Never skip counting total deliverables explicitly
- Never start implementation without presenting the plan first
- Never assign all tasks sequentially when parallelism is possible
- Never forget implicit requirements (tests, docs, deployment)
