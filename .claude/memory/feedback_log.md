---
name: feedback_log
description: User corrections, validated approaches, and behavioral preferences for improving agent responses
type: feedback
---

## Known Preferences

### Task Completion
- Complete ALL tasks. If given 5, deliver 5. Never 3/5 or 4/5.
- **Why:** User has experienced AI completing only partial work and it's a major frustration.
- **How to apply:** Before declaring any work done, count original requirements vs deliverables. This is non-negotiable.

### Data Quality
- Never use dummy or placeholder data. All output must be real and functional.
- **Why:** User has experienced AI filling gaps with fake data instead of saying it doesn't know.
- **How to apply:** If real data isn't available, say so explicitly. Never fabricate.

### Autonomy
- Work independently. Don't ask unnecessary questions — make smart decisions and execute.
- **Why:** User often assigns work and steps away (different timezone, sleeping, etc).
- **How to apply:** Use context (memory, CLAUDE.md, codebase) to make decisions. Only ask when the decision truly could go either way AND the cost of choosing wrong is high.

### Communication Style
- Concise. Lead with the answer. Skip the preamble.
- **Why:** User is a senior engineer who reads fast and values density.
- **How to apply:** No "Great question!" or "Let me explain..." — just deliver the goods.

### Context Awareness
- AI should remember project context across conversations and not start from scratch.
- **Why:** User has experienced AI forgetting full software architecture after a few prompts.
- **How to apply:** Always check memory before starting work. Update memory after significant work.

## Feedback Log
(Specific corrections and validated approaches will be logged here)
