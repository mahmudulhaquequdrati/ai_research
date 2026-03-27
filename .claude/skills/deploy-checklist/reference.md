# Deployment Reference

## Environment Checklist

### Staging
- [ ] ENV=staging
- [ ] DB connection points to staging database
- [ ] API keys are staging keys (not production)
- [ ] Email sends are sandboxed
- [ ] Payment processing in test mode

### Production
- [ ] ENV=production
- [ ] DB connection points to production database
- [ ] API keys are production keys
- [ ] SSL certificates valid and not expiring soon
- [ ] CDN configured and caching properly
- [ ] Error tracking (Sentry/similar) configured
- [ ] Analytics tracking active

## Smoke Test Suite

After each deployment, verify:
1. **Health endpoint** returns 200
2. **Homepage** loads correctly
3. **Auth flow** works (login/logout)
4. **Core feature** functions (the main thing the app does)
5. **API** responds to basic requests
6. **Database** reads and writes work

## Rollback Procedures

### Quick Rollback (< 5 minutes)
```bash
# Revert to previous deployment
git revert HEAD
git push origin main
# OR use platform-specific rollback
vercel rollback  # Vercel
aws deploy stop-deployment  # AWS
heroku rollback  # Heroku
```

### Database Rollback
1. Do NOT rollback if migration was destructive (dropped columns/tables)
2. For additive migrations: apply reverse migration script
3. For data migrations: restore from backup point

## Incident Severity

| Level | Definition | Response Time | Example |
|-------|-----------|--------------|---------|
| P0 | Service down, data loss risk | < 15 min | Complete outage, auth broken |
| P1 | Major feature broken, workaround exists | < 1 hour | Payments failing, data corruption |
| P2 | Minor feature broken, most users unaffected | < 4 hours | UI glitch, slow page |
| P3 | Cosmetic or low-impact | Next deploy | Typo, minor style issue |
