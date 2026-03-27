---
name: code-review
description: Systematic code review for correctness, security, performance, and completeness. Use when reviewing PRs, auditing code, or checking implementations before deployment.
argument-hint: "[file-or-directory]"
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash
model: sonnet
---

# Code Review Skill

Review code at `$ARGUMENTS` (or current changes if no argument).

## Process

### 1. Gather Context
- Read the target file(s) or run `git diff` for current changes
- Understand the purpose of the code from comments, commit messages, or surrounding code
- Check [reference.md](reference.md) for review standards

### 2. Correctness
- Does the code do what it claims?
- All code paths handled (happy path + errors)?
- Edge cases covered (null, empty, boundary, concurrency)?

### 3. Security (OWASP Top 10)
- Input validation at system boundaries
- No injection vectors (SQL, XSS, command)
- No hardcoded secrets or credentials
- Auth/authz checks in place
- Safe data handling

### 4. Performance
- No N+1 queries
- No unnecessary loops/recomputations
- Appropriate data structures
- Resource cleanup (connections, handles)

### 5. Maintainability
- Follows existing codebase patterns
- Clear naming
- No unnecessary complexity or over-engineering
- Would a new team member understand this?

### 6. Completeness
- All requirements addressed (count them)
- Tests for new logic paths
- No leftover TODOs or debug code
- Documentation updated if needed

## Output Format

```markdown
## Code Review: [component/file]

### Summary
[1-2 sentence overview]

### Issues
1. **[CRITICAL/HIGH/MEDIUM/LOW]** [description] — `file:line`
   Fix: [specific suggestion]

### Score: X/10
### Verdict: APPROVE / REQUEST CHANGES / BLOCK
```

## Rules
- Never approve without reading ALL changed code
- Never give APPROVE with CRITICAL or HIGH issues unresolved
- Never skip the completeness check (count requirements)
- Always reference specific file:line for issues
- Check `.claude/memory/tech_stack.md` for codebase context if unfamiliar
