---
name: self-eval
description: Self-evaluation and improvement loop based on autoresearch methodology. Evaluates completed work, scores quality, identifies improvements, and feeds learnings back into memory. Use after completing significant work.
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash, Write, Edit
model: opus
effort: high
---

# Self-Evaluation Skill (Autoresearch Loop)

Evaluate the most recent completed work.

## The Loop: Execute > Evaluate > Learn > Improve

### 1. Task Audit
- **Requested**: Quote the original ask verbatim
- **Delivered**: List every deliverable produced
- **Count match**: [X requested] vs [Y delivered] — PASS/FAIL
- **Gaps**: List anything missing (be brutally honest)

### 2. Quality Scoring
Rate each dimension 1-10:

| Dimension | Weight | Score | Notes |
|-----------|--------|-------|-------|
| Completeness | 30% | ?/10 | All tasks done? |
| Correctness | 30% | ?/10 | Does it actually work? |
| Quality | 20% | ?/10 | Production-grade? |
| Efficiency | 10% | ?/10 | Optimal approach? |
| Innovation | 10% | ?/10 | Smart value beyond ask? |
| **Overall** | 100% | ?/10 | Weighted average |

See [reference.md](reference.md) for scoring calibration.

### 3. Root Cause Analysis (for issues)
For each gap or score < 8:
1. What went wrong?
2. Why? (apply 5-whys)
3. How to prevent next time? (specific, actionable)

### 4. Learning Capture
Write to `.claude/memory/agent_performance_log.md`:
```
Date: [today]
Task: [description]
Score: X/10
What worked: [list]
What failed: [list]
Improvement: [specific action to take]
```

### 5. System Update
If overall score < 8/10:
1. Identify which agent/skill underperformed
2. Read that agent/skill's definition file
3. Draft specific improvements to its instructions
4. Apply the edit
5. Log the change

If overall score >= 8/10:
- Log as validated approach in feedback_log.md
- Note what made it successful for future reference

## Rules
- Never give 10/10 unless it truly exceeds all requirements
- Never skip counting deliverables vs requirements
- Never skip root cause analysis for scores < 8
- Always update memory with learnings — future runs depend on it
- Be brutally honest — inflated scores poison the improvement loop
