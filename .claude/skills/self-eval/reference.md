# Self-Evaluation Reference

## Scoring Calibration

### 10/10 — Exceptional
- Exceeds all requirements
- Elegant, maintainable solution
- Zero issues found
- Client would be delighted without changes

### 8-9/10 — Professional
- Meets all requirements completely
- Minor improvements possible but not necessary
- Production-ready as-is
- Would pass senior engineer review

### 6-7/10 — Acceptable
- Meets most requirements
- Some gaps or rough edges
- Needs minor fixes before shipping
- Would need revision in review

### 4-5/10 — Below Standard
- Partially complete
- Notable issues or missing pieces
- Needs significant rework
- Would be rejected in review

### 1-3/10 — Failed
- Major issues or fundamentally flawed
- Incomplete to the point of being unusable
- Requires complete redo

## 5-Whys Method

For each issue, ask "why" recursively:
1. Why did this fail? → [direct cause]
2. Why did [direct cause] happen? → [deeper cause]
3. Why did [deeper cause] happen? → [systemic cause]
4. Why did [systemic cause] exist? → [root cause]
5. Why was [root cause] not prevented? → [prevention gap]

The fix should address the deepest cause you can act on.

## Common Failure Patterns

| Pattern | Root Cause | Prevention |
|---------|-----------|------------|
| Tasks dropped | Didn't count requirements | Always count before and after |
| Dummy data | Didn't verify data sources | Check every data point is real |
| Context lost | Didn't load memory | Always check MEMORY.md first |
| Wrong approach | Didn't read existing code | Read before write, always |
| Over-engineered | Solved future problems | Solve only the stated problem |
| Incomplete tests | Wrote tests last | Write tests alongside code |
