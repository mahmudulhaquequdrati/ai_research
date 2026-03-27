#!/bin/bash
# Validates code review output format
# Exit 0 = valid, Exit 1 = invalid

INPUT=$(cat)
ERRORS=0

# Check for summary
if ! echo "$INPUT" | grep -qE "#{2,3} Summary"; then
  echo "FAIL: Missing summary section" >&2
  ERRORS=$((ERRORS + 1))
fi

# Check for severity labels
if ! echo "$INPUT" | grep -qE "(CRITICAL|HIGH|MEDIUM|LOW)"; then
  echo "WARN: No severity labels found (might be clean code)" >&2
fi

# Check for score
if ! echo "$INPUT" | grep -qE "Score:.*[0-9]+/10"; then
  echo "FAIL: Missing score (X/10)" >&2
  ERRORS=$((ERRORS + 1))
fi

# Check for verdict
if ! echo "$INPUT" | grep -qE "(APPROVE|REQUEST CHANGES|BLOCK)"; then
  echo "FAIL: Missing verdict" >&2
  ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -gt 0 ]; then
  echo "VALIDATION FAILED: $ERRORS errors" >&2
  exit 1
fi

echo "VALIDATION PASSED"
exit 0
