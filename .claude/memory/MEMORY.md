# AI Skills Memory Index

## User Profile
- [user_profile.md](user_profile.md) — Owner identity, expertise, work style, and preferences

## Business Context
- [business_pristren.md](business_pristren.md) — Pristren agency: real clients, projects, strengths, weaknesses, growth gaps
- [business_model.md](business_model.md) — AI Skills company structure, revenue streams, and positioning
- [brand_identity.md](brand_identity.md) — Brand voice, values, visual identity, and market positioning

## Technical Context
- [tech_stack.md](tech_stack.md) — Preferred technologies, frameworks, and infrastructure
- [architecture_patterns.md](architecture_patterns.md) — Design patterns and architectural decisions

## Agent Performance
- [agent_performance_log.md](agent_performance_log.md) — Training history, scores, and improvements for all agents

## Project History
- [active_projects.md](active_projects.md) — Current projects, status, and context

## Feedback & Learnings
- [feedback_log.md](feedback_log.md) — User corrections, preferences, and validated approaches
- [feedback_treat_as_analyst.md](feedback_treat_as_analyst.md) — Treat as business partner, not robot; honest strategic analysis
- [feedback_video_quality.md](feedback_video_quality.md) — Zero-cost only. AI-generated videos must use free tools. No paid APIs.

## Video Content Production
- [video_reference_style.md](video_reference_style.md) — Ali Abdaal-inspired editing: pattern interrupts, peaks/valleys, PIP avatar
- [content_video_pipeline.md](content_video_pipeline.md) — Video engine v2: edge-tts + SadTalker + Pillow + MoviePy. Zero cost, 2-3 min videos.
- [video_production_workflow.md](video_production_workflow.md) — 100% AI pipeline: script → voice → avatar → graphics → compose. No human editors.

## Quick Reference: System Capabilities
- **10 Agents**: project-orchestrator, software-engineer, qa-evaluator, researcher, brand-strategist, automation-architect, content-creator, social-media-manager, video-producer, video-editor
- **11 Skills**: code-review, market-research, agent-trainer, content-strategy, context-loader, deploy-checklist, project-kickoff, self-eval, video-pipeline, video-editing, social-repurpose
- **7 Commands**: /bootstrap (init), /context, /kickoff, /review, /eval, /train, /health
- **Video Workflow**: Write script.json → `python generate.py --script script.json` → `/social-repurpose`
- **General Workflow**: `/bootstrap` → `/kickoff [project]` → work → `/review` → `/eval` → `/train` (if needed)
