---
name: agent-trainer
description: Meta-skill for training and improving agents and skills. Evaluates performance, identifies weaknesses, updates definitions, and tests improvements. Use when an agent underperforms or for periodic improvement cycles.
argument-hint: "[agent-or-skill-name]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Write, Edit, Bash
model: opus
effort: high
---

# Agent Trainer Skill (Self-Improvement Engine)

Train/improve: `$ARGUMENTS` (or all agents if no argument)

## The Training Loop (Autoresearch Method)

### 1. Observe
1. Read the target agent/skill definition
2. Read `.claude/memory/agent_performance_log.md` for recent scores
3. Identify patterns in failures or low scores
4. Collect specific examples of suboptimal outputs

### 2. Diagnose
For each issue, classify the root cause:

| Symptom | Root Cause | Fix |
|---------|-----------|-----|
| Wrong output format | Unclear instructions | Rewrite output format section with example |
| Missing context | No memory loading step | Add context-loading step to process |
| Incomplete work | No completion check | Add counting/verification step |
| Wrong tool usage | Tool list too broad | Restrict allowed-tools in frontmatter |
| Over-engineering | Scope not defined | Add "only do X, don't do Y" guardrails |

See [reference.md](reference.md) for the full diagnosis matrix.

### 3. Update
1. Draft specific changes to the agent/skill SKILL.md or agent .md
2. Changes must be targeted — don't rewrite entire files
3. Add guardrails for identified failure modes
4. Add examples of desired behavior if missing

### 4. Test
1. Design a test scenario that previously failed
2. Mentally simulate: would the updated instructions produce better output?
3. If yes: apply the edit
4. If unclear: try a different approach

### 5. Log
Update `.claude/memory/agent_performance_log.md`:
```
Date: [today]
Target: [agent/skill name]
Issue: [what was wrong]
Change: [what was updated]
Expected improvement: [what should get better]
```

## Improvement Priorities
1. **Completeness** (highest) — Finishes all tasks
2. **Correctness** — Output is accurate and functional
3. **Efficiency** — Uses minimal tokens/time
4. **Quality** — Output is polished and professional

## When to Train
- After any task scores < 7/10 on self-eval
- After user feedback indicates issues
- After completing a major project (retrospective)
- Periodically (weekly proactive review)

## Rules
- Never rewrite an entire agent/skill file — make targeted changes
- Never make changes without reading the performance log first
- Always explain WHY a change was made
- Always verify the change would improve the specific failure
- If a change doesn't help after testing, revert it
- One change at a time — easier to evaluate impact
