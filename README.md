# AI Skills

Autonomous, self-improving AI agent system for a million-dollar digital business. Built for Claude Code using the autoresearch methodology.

## What This Is

A `.claude` workspace that turns Claude Code into a coordinated team of 8 specialized AI agents with 8 skills, persistent memory, and a self-improvement loop. Every agent has:
- Proper frontmatter (name, description, tools, model, memory, maxTurns, skills)
- Deep domain instructions with numbered steps
- Guardrails (explicit "never do" rules)
- Context-loader integration for smart memory access
- Connection to the eval/training loop

## Architecture

```
ai_skills/
  CLAUDE.md                                    # Master brain (auto-read by Claude)
  README.md                                    # This file
  .claude/
    agents/                                    # 8 agents (folder per agent)
      project-orchestrator/                    # Coordinates multi-agent work
        project-orchestrator.md                # tools: Read,Grep,Glob,Bash,Agent,Write,Edit,TodoWrite
      software-engineer/                       # Full-stack production code
        software-engineer.md                   # tools: Read,Grep,Glob,Bash,Write,Edit
      researcher/                              # Deep research & analysis
        researcher.md                          # tools: Read,Grep,Glob,Bash,WebSearch,WebFetch
      social-media-manager/                    # Multi-platform social strategy
        social-media-manager.md                # tools: Read,Grep,Glob,Write,Edit
      brand-strategist/                        # Business & growth strategy
        brand-strategist.md                    # tools: Read,Grep,Glob,WebSearch,WebFetch
      automation-architect/                    # Workflows & integrations
        automation-architect.md                # tools: Read,Grep,Glob,Bash,Write,Edit
      qa-evaluator/                            # Quality gate (read-only)
        qa-evaluator.md                        # tools: Read,Grep,Glob,Bash (no Write/Edit)
      content-creator/                         # All written content
        content-creator.md                     # tools: Read,Grep,Glob,Write,Edit
    skills/                                    # 8 skills (folder per skill)
      code-review/
        SKILL.md                               # Main instructions + frontmatter
        reference.md                           # Detailed standards & rubrics
        evals/eval-invoke.json                 # Invocation tests
        evals/eval-quality.json                # Output quality tests
        scripts/validate-output.sh             # Automated output validation
      project-kickoff/
        SKILL.md, reference.md, evals/
      self-eval/
        SKILL.md, reference.md, evals/
        scripts/calculate-score.sh             # Weighted score calculator
      context-loader/
        SKILL.md, reference.md, evals/
      market-research/
        SKILL.md, reference.md, evals/
      content-strategy/
        SKILL.md, reference.md, evals/
      deploy-checklist/
        SKILL.md, reference.md, evals/
        scripts/pre-deploy-check.sh            # Automated pre-deploy checks
      agent-trainer/
        SKILL.md, reference.md, evals/
        scripts/health-check.sh                # System health check
    memory/                                    # Persistent knowledge base (9 files)
      MEMORY.md                                # Index — always check first
      user_profile.md                          # Owner identity & preferences
      business_model.md                        # Revenue streams & positioning
      brand_identity.md                        # Voice, values, visual identity
      tech_stack.md                            # Preferred technologies
      architecture_patterns.md                 # Design patterns & decisions
      agent_performance_log.md                 # Training history & scores
      active_projects.md                       # Current project context
      feedback_log.md                          # Corrections & validated approaches
    commands/                                  # 6 slash commands
      kickoff.md                               # /kickoff — New project setup
      review.md                                # /review — Code review
      eval.md                                  # /eval — Self-evaluate work
      train.md                                 # /train — Improve agents/skills
      context.md                               # /context — Load smart context
      health.md                                # /health — System health check
```

**55 total files** | 8 agents | 8 skills | 9 evals | 4 scripts | 9 memory files | 6 commands

## The Self-Improvement Loop (Autoresearch Method)

```
Plan → Execute → Evaluate → Improve → Repeat
```

1. **Plan** — `/kickoff` decomposes project, assigns agents, identifies dependencies
2. **Execute** — Agents work in parallel (independent tasks) or sequential (dependencies)
3. **Evaluate** — `/eval` scores output on 5 dimensions (completeness, correctness, quality, efficiency, innovation)
4. **Improve** — `/train` diagnoses issues, makes targeted fixes to agent/skill definitions
5. **Repeat** — Each cycle makes the system measurably smarter

Scores are tracked in `agent_performance_log.md`. If score increases after a change, we keep it and push to git. If not, we revert and try a different approach.

## Commands

| Command | Purpose |
|---------|---------|
| `/kickoff [description]` | Decompose and plan a new project |
| `/review [file]` | Systematic code review |
| `/eval` | Self-evaluate most recent work |
| `/train [agent/skill]` | Improve underperforming components |
| `/context [task]` | Load relevant context efficiently |
| `/health` | Run system health check |

## Design Principles

1. **Complete execution** — If given 5 tasks, deliver 5. Count before and after.
2. **No dummy data** — Everything real and functional. If unavailable, say so.
3. **Self-improving** — Every run feeds the eval loop, making next run better.
4. **Token efficient** — Context-loader loads only what matters per task type.
5. **Business-first** — Every decision considers ROI, brand, scalability.
6. **Autonomous** — Works independently without constant human guidance.

## Business Domains

- Software development (full-stack, AI/ML, mobile, cloud)
- Automation and workflow design
- Social media strategy and content
- Brand positioning and marketing
- Market research and competitive intelligence
- Digital product development
- Quality assurance and code review
- Content creation (blog, email, docs, marketing)
