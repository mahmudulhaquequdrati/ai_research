# Agent Trainer Reference

## Full Diagnosis Matrix

| Symptom | Possible Root Causes | Diagnostic Steps | Fix Approaches |
|---------|---------------------|-----------------|----------------|
| Drops tasks | No counting step, scope too large | Check if instructions mention counting | Add explicit count-and-verify step |
| Wrong format | Unclear output spec, no example | Compare output vs spec | Add output example in instructions |
| Uses dummy data | No data verification step | Check if instructions require real data | Add "verify all data is real" guardrail |
| Over-engineers | No scope boundaries | Check for "only do X" constraints | Add explicit scope limits |
| Ignores context | No memory-loading step | Check if instructions reference memory | Add "load context first" step |
| Wrong tool | Tool list too permissive | Check allowed-tools frontmatter | Restrict to needed tools only |
| Slow/expensive | Model too powerful for task | Check model setting | Use haiku/sonnet for simple tasks |
| Loses focus | Instructions too long | Measure instruction length | Compress, move details to reference.md |

## Agent Health Check Template

For each agent, verify:
1. **Frontmatter** — All required fields present and correct?
2. **Instructions** — Clear, actionable, no ambiguity?
3. **Process** — Numbered steps with clear completion criteria?
4. **Output format** — Specified with example?
5. **Guardrails** — Anti-patterns listed?
6. **Context loading** — References memory where needed?
7. **Evaluation** — Has evals defined?
8. **Reference file** — Supporting details separated from main instructions?

## Scoring an Agent Definition (not its output)

| Dimension | 10/10 | 5/10 | 1/10 |
|-----------|-------|------|------|
| Clarity | Every step is unambiguous | Some steps vague | Instructions are confusing |
| Completeness | All scenarios covered | Happy path only | Major gaps |
| Efficiency | Minimal token footprint | Some bloat | Massive, redundant |
| Testability | Clear evals exist | Partial evals | No way to test |
| Guardrails | All known failure modes addressed | Some addressed | No guardrails |

## Update Best Practices
- Make one change at a time (easier to evaluate impact)
- Always explain WHY the change was made (in commit or memory)
- Keep reference.md for details, SKILL.md for core instructions
- Test the change before moving to next improvement
- If a change doesn't help, revert it
