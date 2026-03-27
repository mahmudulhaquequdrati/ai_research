---
name: review
description: Run systematic code review on current changes or a specific file.
allowed-tools: Read, Grep, Glob, Bash
---

Run the code-review skill on current changes.

1. Run `git diff` to see all staged and unstaged changes
2. Apply the full code-review checklist from the code-review skill
3. Output structured review with issues, severity, scores, and verdict
4. If issues found, suggest specific fixes with file:line references

Target: $ARGUMENTS
