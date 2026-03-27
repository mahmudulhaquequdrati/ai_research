#!/bin/bash
# Pre-deployment automated checks
# Run before any deployment to catch common issues

set -e
ERRORS=0
WARNINGS=0

echo "=== Pre-Deploy Check ==="
echo ""

# Check for debug statements
echo "Checking for debug statements..."
DEBUG_COUNT=$(grep -rn "console\.log\|debugger\|print(" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" --include="*.py" . 2>/dev/null | grep -v node_modules | grep -v ".claude" | wc -l | tr -d ' ')
if [ "$DEBUG_COUNT" -gt 0 ]; then
  echo "  WARN: Found $DEBUG_COUNT debug statements"
  WARNINGS=$((WARNINGS + 1))
else
  echo "  PASS: No debug statements"
fi

# Check for hardcoded secrets patterns
echo "Checking for potential secrets..."
SECRET_COUNT=$(grep -rn "password\s*=\s*['\"].\+['\"]" --include="*.ts" --include="*.js" --include="*.py" --include="*.env" . 2>/dev/null | grep -v node_modules | grep -v ".claude" | grep -v "example" | wc -l | tr -d ' ')
if [ "$SECRET_COUNT" -gt 0 ]; then
  echo "  FAIL: Found $SECRET_COUNT potential hardcoded secrets"
  ERRORS=$((ERRORS + 1))
else
  echo "  PASS: No hardcoded secrets detected"
fi

# Check for TODO comments
echo "Checking for TODO comments..."
TODO_COUNT=$(grep -rn "TODO\|FIXME\|HACK\|XXX" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.jsx" --include="*.py" . 2>/dev/null | grep -v node_modules | grep -v ".claude" | wc -l | tr -d ' ')
if [ "$TODO_COUNT" -gt 0 ]; then
  echo "  WARN: Found $TODO_COUNT TODO/FIXME comments"
  WARNINGS=$((WARNINGS + 1))
else
  echo "  PASS: No TODOs found"
fi

# Check for .env files being tracked
echo "Checking for tracked .env files..."
ENV_COUNT=$(git ls-files "*.env" "*.env.*" 2>/dev/null | grep -v ".example" | grep -v ".template" | wc -l | tr -d ' ')
if [ "$ENV_COUNT" -gt 0 ]; then
  echo "  FAIL: Found $ENV_COUNT .env files in git"
  ERRORS=$((ERRORS + 1))
else
  echo "  PASS: No .env files tracked"
fi

echo ""
echo "=== Results ==="
echo "Errors: $ERRORS | Warnings: $WARNINGS"

if [ $ERRORS -gt 0 ]; then
  echo "STATUS: BLOCKED — Fix errors before deploying"
  exit 1
else
  echo "STATUS: READY — Clear to deploy"
  exit 0
fi
