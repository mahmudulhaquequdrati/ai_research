---
name: deploy-checklist
description: Pre-deployment verification gate. Ensures code is tested, reviewed, secure, and production-ready before any deployment. Use before deploying to staging or production.
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash
model: sonnet
effort: medium
---

# Deployment Checklist Skill

Pre-deploy verification for current changes.

## Automated Checks

Run via [scripts/pre-deploy-check.sh](scripts/pre-deploy-check.sh):

!`bash ${CLAUDE_SKILL_DIR}/scripts/pre-deploy-check.sh 2>/dev/null || echo "Script not available — running manual checks"`

## Manual Verification

### Code Quality
- [ ] All tests passing
- [ ] Code review completed and approved
- [ ] No console.log / debug statements
- [ ] No TODO comments in changed files
- [ ] No hardcoded environment-specific values

### Security
- [ ] No secrets in code or config
- [ ] Environment variables configured
- [ ] Input validation in place
- [ ] Auth/authz working
- [ ] CORS configured correctly

### Performance
- [ ] No N+1 queries
- [ ] Assets optimized
- [ ] Caching appropriate
- [ ] DB indexes for new queries

### Infrastructure
- [ ] Env vars set in target environment
- [ ] DB migrations ready
- [ ] Rollback plan documented
- [ ] Health checks configured
- [ ] Monitoring/alerting in place

### Documentation
- [ ] API changes documented
- [ ] README updated if needed
- [ ] Changelog entry added
- [ ] Breaking changes communicated

## Deploy Process
1. Merge to deploy branch
2. Verify CI/CD passes
3. Deploy to staging → smoke test
4. Deploy to production → verify health
5. Monitor 30 minutes post-deploy

## Rollback
- **P0** (critical): Immediate rollback, investigate after
- **P1** (high): Hotfix attempt, rollback if not fixed in 15 min
- **P2** (medium): Fix forward in next deploy

See [reference.md](reference.md) for detailed procedures.

## Rules
- Never deploy with failing tests
- Never deploy with CRITICAL security issues
- Never skip the rollback plan
- Never deploy without someone available to monitor
- Always check `.claude/memory/active_projects.md` for deployment context
