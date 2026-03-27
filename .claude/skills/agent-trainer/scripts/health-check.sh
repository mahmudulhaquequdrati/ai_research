#!/bin/bash
# Health check for all agent and skill definitions
# Checks structure, required fields, and common issues

CLAUDE_DIR="${1:-.claude}"
ERRORS=0
WARNINGS=0

echo "=== Agent & Skill Health Check ==="
echo ""

# Check agents
echo "--- Agents ---"
for agent_dir in "$CLAUDE_DIR"/agents/*/; do
  if [ -d "$agent_dir" ]; then
    agent_name=$(basename "$agent_dir")
    agent_file="$agent_dir/$agent_name.md"

    if [ ! -f "$agent_file" ]; then
      echo "  FAIL: $agent_name — Missing agent .md file"
      ERRORS=$((ERRORS + 1))
      continue
    fi

    # Check for frontmatter
    if ! head -1 "$agent_file" | grep -q "^---"; then
      echo "  FAIL: $agent_name — Missing frontmatter"
      ERRORS=$((ERRORS + 1))
    fi

    # Check for required fields
    if ! grep -q "^name:" "$agent_file"; then
      echo "  WARN: $agent_name — Missing name field"
      WARNINGS=$((WARNINGS + 1))
    fi

    if ! grep -q "^description:" "$agent_file"; then
      echo "  FAIL: $agent_name — Missing description field"
      ERRORS=$((ERRORS + 1))
    fi

    echo "  OK: $agent_name"
  fi
done

# Check skills
echo ""
echo "--- Skills ---"
for skill_dir in "$CLAUDE_DIR"/skills/*/; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    skill_file="$skill_dir/SKILL.md"

    if [ ! -f "$skill_file" ]; then
      echo "  FAIL: $skill_name — Missing SKILL.md"
      ERRORS=$((ERRORS + 1))
      continue
    fi

    # Check for frontmatter
    if ! head -1 "$skill_file" | grep -q "^---"; then
      echo "  FAIL: $skill_name — Missing frontmatter"
      ERRORS=$((ERRORS + 1))
    fi

    # Check for reference.md
    if [ ! -f "$skill_dir/reference.md" ]; then
      echo "  WARN: $skill_name — Missing reference.md"
      WARNINGS=$((WARNINGS + 1))
    fi

    # Check for evals
    if [ ! -d "$skill_dir/evals" ] || [ -z "$(ls -A "$skill_dir/evals" 2>/dev/null)" ]; then
      echo "  WARN: $skill_name — No eval files"
      WARNINGS=$((WARNINGS + 1))
    fi

    echo "  OK: $skill_name"
  fi
done

echo ""
echo "=== Results ==="
echo "Errors: $ERRORS | Warnings: $WARNINGS"

if [ $ERRORS -gt 0 ]; then
  echo "STATUS: ISSUES FOUND"
  exit 1
else
  echo "STATUS: HEALTHY"
  exit 0
fi
