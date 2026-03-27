# Code Review Standards Reference

## Severity Levels

| Level | Definition | Action |
|-------|-----------|--------|
| CRITICAL | Security vulnerability, data loss risk, or production crash | Must fix before merge |
| HIGH | Incorrect behavior, missing error handling, performance issue | Should fix before merge |
| MEDIUM | Code smell, maintainability concern, missing test | Fix recommended |
| LOW | Style issue, minor improvement, nitpick | Optional |

## OWASP Top 10 Checklist
1. Broken Access Control — Missing or incorrect authorization checks
2. Cryptographic Failures — Weak encryption, exposed secrets
3. Injection — SQL, NoSQL, OS command, LDAP injection
4. Insecure Design — Missing security controls in design
5. Security Misconfiguration — Default configs, unnecessary features
6. Vulnerable Components — Outdated dependencies with known CVEs
7. Authentication Failures — Weak passwords, missing MFA
8. Data Integrity Failures — Missing integrity checks
9. Logging Failures — Missing audit trails
10. SSRF — Server-side request forgery

## Code Quality Patterns

### Good Patterns
- Single responsibility per function
- Early returns for guard clauses
- Descriptive variable names (no single-letter in business logic)
- Constants for magic numbers
- Error messages that help debugging

### Anti-Patterns
- God functions (>50 lines)
- Deep nesting (>3 levels)
- Commented-out code
- Copy-paste duplication
- Boolean parameters (use named options)

## Scoring Rubric
- **10**: No issues, elegant solution
- **8-9**: Minor issues only, production-ready
- **6-7**: Some issues need addressing
- **4-5**: Significant issues, needs rework
- **1-3**: Fundamental problems
