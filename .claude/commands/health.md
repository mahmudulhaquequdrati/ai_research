---
name: health
description: Run health check on all agents and skills. Verify structure, frontmatter, and completeness.
allowed-tools: Read, Grep, Glob, Bash
---

Run the health check on the entire .claude system.

1. Verify all agents have proper frontmatter (name, description, tools, memory)
2. Verify all skills have SKILL.md, reference.md, and evals/
3. Check memory index is up to date
4. Report: total agents, skills, commands, memory files
5. Flag any issues

!`bash .claude/skills/agent-trainer/scripts/health-check.sh .claude 2>&1 || echo "Health check script failed — running manual checks"`
