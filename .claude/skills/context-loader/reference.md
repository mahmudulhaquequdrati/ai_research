# Context Loading Reference

## Memory File Index

| File | Contents | Load When |
|------|----------|-----------|
| user_profile.md | Owner identity, expertise, preferences | Always relevant |
| business_model.md | Revenue streams, target markets, competitive advantage | Business, strategy, content tasks |
| brand_identity.md | Voice, values, visual identity | Content, social, marketing tasks |
| tech_stack.md | Preferred technologies and frameworks | Software, automation tasks |
| architecture_patterns.md | Design patterns and decisions | Software architecture tasks |
| agent_performance_log.md | Agent scores and improvements | Training, evaluation tasks |
| active_projects.md | Current projects and context | Any project-specific task |
| feedback_log.md | User corrections and preferences | All tasks (check for relevant feedback) |

## Loading Priority

1. **Always load**: CLAUDE.md (auto), MEMORY.md index
2. **Almost always**: feedback_log.md (contains behavior corrections)
3. **Task-dependent**: See matrix above
4. **Rarely needed**: agent_performance_log.md (only during training)

## Token Estimation

| File | Approximate Tokens |
|------|--------------------|
| CLAUDE.md | ~800 |
| MEMORY.md | ~200 |
| user_profile.md | ~300 |
| business_model.md | ~400 |
| brand_identity.md | ~400 |
| tech_stack.md | ~350 |
| architecture_patterns.md | ~500 |
| feedback_log.md | ~400 |
| active_projects.md | ~300 (grows) |

## Anti-Patterns
- Don't load all memory files for every task
- Don't load tech_stack for a content writing task
- Don't load brand_identity for a pure coding task
- Don't skip feedback_log — it contains critical corrections
