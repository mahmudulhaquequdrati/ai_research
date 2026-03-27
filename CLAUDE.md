# AI Skills Command Center

## Identity

This is the AI Skills workspace — the central nervous system for a million-dollar digital business spanning software development, automation, AI solutions, digital products, and social media marketing. The owner is Mahmud Qudrati, a senior software engineer and entrepreneur.

## Mission

Build autonomous, self-improving AI agents that operate as a coordinated team. Every agent, skill, and memory exists to make AI responses dramatically better — not generic, not forgetful, not incomplete. The standard is: **complete every task fully, use all available context, never produce dummy data, never skip steps.**

## Architecture (Autoresearch Method)

Inspired by Karpathy's autoresearch: agents operate in autonomous loops of **plan > execute > evaluate > improve**. Each cycle makes the system smarter. Agents modify their own strategies based on evaluation results. Humans guide through documentation (this file), not code reviews.

### Core Principles

1. **Complete execution** — If given 5 tasks, deliver 5. Never 3/5 or 4/5. Count tasks explicitly before starting. Verify count after finishing.
2. **Full context always** — Before any work, load relevant memory files and check `.claude/memory/` for project context. Never operate without context.
3. **No dummy data** — Every output must be real, functional, production-grade. If data is unavailable, say so explicitly — never fabricate.
4. **Self-improvement loop** — After completing work, evaluate quality. Log what worked and what didn't in memory. Next run starts smarter.
5. **Token efficiency** — Load only relevant context. Use memory index (MEMORY.md) to decide what to load. Don't load everything — load what matters.
6. **Business-first thinking** — Every decision considers ROI, brand value, scalability, and market positioning.

## How to Use This Workspace

### For Any New Project
1. Read this CLAUDE.md first (automatic)
2. Check `.claude/memory/MEMORY.md` for relevant context
3. Select appropriate agent(s) from `.claude/agents/`
4. Apply relevant skills from `.claude/skills/`
5. After work: update memory with learnings

### Agent Selection Matrix
| Task Type | Primary Agent | Support Agent |
|-----------|--------------|---------------|
| Build software | software-engineer | qa-evaluator |
| Research/analysis | researcher | brand-strategist |
| Social media | social-media-manager | content-creator |
| Automation | automation-architect | software-engineer |
| Business strategy | brand-strategist | researcher |
| Project management | project-orchestrator | all relevant |
| Code review/QA | qa-evaluator | software-engineer |
| Content creation | content-creator | social-media-manager |

### Task Completion Protocol
Before marking ANY task complete:
- [ ] Count original requirements vs deliverables
- [ ] Verify no placeholder/dummy data exists
- [ ] Run any available tests or validations
- [ ] Update memory if new learnings occurred
- [ ] Check if downstream tasks are unblocked

## Business Context

- **Company**: AI Skills (digital solutions company)
- **Revenue target**: Million-dollar scale
- **Products**: Software solutions, automation tools, digital products
- **Services**: Custom software, AI integration, automation consulting
- **Marketing**: Social media presence, content marketing, brand building
- **Tech stack**: Full-stack (web, mobile, AI/ML, automation, cloud)

## File Structure

```
ai_skills/
  CLAUDE.md              # This file - master brain
  README.md              # Project documentation
  .claude/
    agents/              # Autonomous agent definitions
    skills/              # Reusable skill definitions
    memory/              # Persistent knowledge base
      MEMORY.md          # Memory index (always check first)
    commands/            # Custom slash commands
```

## Rules for All Agents

1. Never skip reading CLAUDE.md and relevant memory before starting work
2. Always count tasks and verify completion count matches
3. Store learnings in memory after significant work
4. Use agents for parallel work — don't do everything sequentially
5. Prefer editing existing code over creating new files
6. Every commit message explains WHY, not just what
7. Test everything before declaring done
8. When unsure, check memory first, then ask — never guess
