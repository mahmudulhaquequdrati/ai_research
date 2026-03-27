---
name: context-loader
description: Smart context loading for any task. Determines which memory files, project context, and docs to load — maximizing relevance while minimizing token cost. Use at the start of every significant work session.
user-invocable: true
allowed-tools: Read, Grep, Glob
model: haiku
effort: low
---

# Context Loader Skill

Load context for: `$ARGUMENTS`

## Process

### 1. Classify Task Type
- `software` — Building, fixing, or reviewing code
- `research` — Gathering information or analysis
- `content` — Writing or creating content
- `business` — Strategy, planning, decisions
- `social` — Social media related
- `automation` — Building workflows / integrations
- `mixed` — Multiple types

### 2. Load Core (Always)
- Read `CLAUDE.md` (auto-loaded)
- Read `.claude/memory/MEMORY.md` for relevant pointers

### 3. Load Task-Specific Memory
See [reference.md](reference.md) for the loading matrix.

| Task Type | Load |
|-----------|------|
| software | tech_stack, architecture_patterns |
| research | business_model, active_projects |
| content | brand_identity, business_model |
| business | business_model, brand_identity, active_projects |
| social | brand_identity, business_model |
| automation | tech_stack, architecture_patterns |

### 4. Load Project Context (if applicable)
- Check memory for project-specific entries
- Read relevant source files (only what's needed)
- Check recent git history if code-related

### 5. Prune
- Remove anything not relevant to THIS specific task
- Keep total loaded context lean

### 6. Progressive Mode (for Chunked Execution)
When loading context for a multi-step task:
- Step 1: Load ONLY core context (CLAUDE.md + MEMORY.md + feedback_log.md)
- Step N: Load ONLY the files/context needed for that specific step
- Between steps: release context no longer needed (don't carry forward)
- Never pre-load context "in case it's needed later"

| Chunk Type | Load | Skip |
|------------|------|------|
| Writing a function | The file being edited, its imports | Unrelated project files |
| Writing content | Brand voice, section outline | Full content plan |
| Research finding | Current question, sources | Previous findings |
| Planning a phase | Phase requirements, dependencies | Other phases |

## Token Budgets
- Simple task: < 2000 tokens of context
- Medium task: < 5000 tokens
- Complex task: < 10000 tokens
- Never load everything "just in case"

## Output
> Loaded context for [task type]. Relevant: [key facts]. Ready to proceed.

## Rules
- Never load all memory files for every task
- Never skip feedback_log.md — it contains critical behavior corrections
- Never load tech_stack.md for pure content tasks
- Never load brand_identity.md for pure coding tasks
- Always prune before proceeding — quality over quantity
