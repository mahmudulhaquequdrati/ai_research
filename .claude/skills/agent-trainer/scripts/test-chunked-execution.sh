#!/bin/bash
# Test suite for Chunked Execution Protocol
# Validates that all agents, skills, and CLAUDE.md enforce chunked execution
# Exit 0 = all pass, Exit 1 = failures found

CLAUDE_DIR="${1:-.claude}"
ROOT_DIR="${2:-.}"
PASS=0
FAIL=0
WARN=0
TOTAL=0

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
nc='\033[0m'

pass() { echo -e "  ${green}PASS${nc}: $1"; PASS=$((PASS + 1)); TOTAL=$((TOTAL + 1)); }
fail() { echo -e "  ${red}FAIL${nc}: $1"; FAIL=$((FAIL + 1)); TOTAL=$((TOTAL + 1)); }
warn() { echo -e "  ${yellow}WARN${nc}: $1"; WARN=$((WARN + 1)); }

echo "=========================================="
echo "  Chunked Execution Protocol Test Suite"
echo "=========================================="
echo ""

# ============================================
# TEST 1: CLAUDE.md has Chunked Execution Protocol
# ============================================
echo "--- Test 1: CLAUDE.md Protocol ---"

CLAUDE_MD="$ROOT_DIR/CLAUDE.md"
if [ ! -f "$CLAUDE_MD" ]; then
  fail "CLAUDE.md not found at $CLAUDE_MD"
else
  if grep -q "Chunked Execution Protocol" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains Chunked Execution Protocol section"
  else
    fail "CLAUDE.md missing Chunked Execution Protocol section"
  fi

  if grep -q "500-line file max" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains 500-line file max rule"
  else
    fail "CLAUDE.md missing 500-line file max rule"
  fi

  if grep -q "One chunk at a time" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains one-chunk-at-a-time rule"
  else
    fail "CLAUDE.md missing one-chunk-at-a-time rule"
  fi

  if grep -q "Verify before advancing" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains verify-before-advancing rule"
  else
    fail "CLAUDE.md missing verify-before-advancing rule"
  fi

  if grep -q "Progressive context" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains progressive context rule"
  else
    fail "CLAUDE.md missing progressive context rule"
  fi

  if grep -q "Edit over Write" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains Edit-over-Write rule"
  else
    fail "CLAUDE.md missing Edit-over-Write rule"
  fi

  if grep -q "TodoWrite tracking" "$CLAUDE_MD"; then
    pass "CLAUDE.md contains TodoWrite tracking rule"
  else
    fail "CLAUDE.md missing TodoWrite tracking rule"
  fi

  # Check that Rules section references chunked execution
  if grep -q "Break large work into chunks" "$CLAUDE_MD"; then
    pass "CLAUDE.md Rules section references chunked execution"
  else
    fail "CLAUDE.md Rules section missing chunked execution reference"
  fi
fi

# ============================================
# TEST 2: All agents have chunking sections
# ============================================
echo ""
echo "--- Test 2: Agent Chunking Sections ---"

CHUNKING_KEYWORDS="Chunked|chunked|chunk at a time|one.*at a time|TodoWrite"

for agent_dir in "$CLAUDE_DIR"/agents/*/; do
  if [ -d "$agent_dir" ]; then
    agent_name=$(basename "$agent_dir")
    agent_file="$agent_dir/$agent_name.md"

    if [ ! -f "$agent_file" ]; then
      fail "$agent_name — agent file not found"
      continue
    fi

    # Check for chunking section
    if grep -qE "(## Chunked|### .* \(Chunked\)|### .* \(Checkpointed\)|### .* \(Atomic\)|### .* \(Per Chunk\))" "$agent_file"; then
      pass "$agent_name — has chunking section"
    else
      fail "$agent_name — missing chunking section (expected ## Chunked* or ###*(Chunked))"
    fi

    # Check for TodoWrite reference
    if grep -q "TodoWrite" "$agent_file"; then
      pass "$agent_name — references TodoWrite for progress tracking"
    else
      fail "$agent_name — missing TodoWrite reference"
    fi
  fi
done

# ============================================
# TEST 3: 500-line file max enforcement
# ============================================
echo ""
echo "--- Test 3: 500-Line File Max ---"

# Check all .md files in agents and skills
for f in "$CLAUDE_DIR"/agents/*/*.md "$CLAUDE_DIR"/skills/*/SKILL.md "$CLAUDE_DIR"/skills/*/reference.md "$CLAUDE_DIR"/commands/*.md; do
  if [ -f "$f" ]; then
    lines=$(wc -l < "$f" | tr -d ' ')
    basename_f=$(basename "$f")
    dirname_f=$(basename "$(dirname "$f")")

    if [ "$lines" -gt 500 ]; then
      fail "$dirname_f/$basename_f — $lines lines (exceeds 500-line max)"
    elif [ "$lines" -gt 400 ]; then
      warn "$dirname_f/$basename_f — $lines lines (approaching 500-line limit)"
      pass "$dirname_f/$basename_f — $lines lines (under 500)"
    else
      pass "$dirname_f/$basename_f — $lines lines"
    fi
  fi
done

# Check CLAUDE.md too
if [ -f "$ROOT_DIR/CLAUDE.md" ]; then
  lines=$(wc -l < "$ROOT_DIR/CLAUDE.md" | tr -d ' ')
  if [ "$lines" -gt 500 ]; then
    fail "CLAUDE.md — $lines lines (exceeds 500-line max)"
  else
    pass "CLAUDE.md — $lines lines"
  fi
fi

# ============================================
# TEST 4: Agent line count (under 80)
# ============================================
echo ""
echo "--- Test 4: Agent File Length (max 80 lines) ---"

for agent_dir in "$CLAUDE_DIR"/agents/*/; do
  if [ -d "$agent_dir" ]; then
    agent_name=$(basename "$agent_dir")
    agent_file="$agent_dir/$agent_name.md"

    if [ -f "$agent_file" ]; then
      lines=$(wc -l < "$agent_file" | tr -d ' ')
      if [ "$lines" -gt 80 ]; then
        fail "$agent_name — $lines lines (exceeds 80-line agent max)"
      else
        pass "$agent_name — $lines lines"
      fi
    fi
  fi
done

# ============================================
# TEST 5: context-loader has progressive mode
# ============================================
echo ""
echo "--- Test 5: Context Loader Progressive Mode ---"

CTX_SKILL="$CLAUDE_DIR/skills/context-loader/SKILL.md"
if [ ! -f "$CTX_SKILL" ]; then
  fail "context-loader SKILL.md not found"
else
  if grep -q "Progressive Mode" "$CTX_SKILL"; then
    pass "context-loader has Progressive Mode section"
  else
    fail "context-loader missing Progressive Mode section"
  fi

  if grep -q "Chunk Type" "$CTX_SKILL"; then
    pass "context-loader has chunk-type loading table"
  else
    fail "context-loader missing chunk-type loading table"
  fi

  if grep -q "release context" "$CTX_SKILL" || grep -q "no longer needed" "$CTX_SKILL"; then
    pass "context-loader has context release guidance"
  else
    fail "context-loader missing context release guidance"
  fi
fi

# ============================================
# TEST 6: project-orchestrator atomic decomposition
# ============================================
echo ""
echo "--- Test 6: Project Orchestrator Atomic Decomposition ---"

PO_FILE="$CLAUDE_DIR/agents/project-orchestrator/project-orchestrator.md"
if [ ! -f "$PO_FILE" ]; then
  fail "project-orchestrator agent file not found"
else
  if grep -q "atomic" "$PO_FILE" || grep -q "Atomic" "$PO_FILE"; then
    pass "project-orchestrator has atomic decomposition"
  else
    fail "project-orchestrator missing atomic decomposition"
  fi

  if grep -q "Checkpointed" "$PO_FILE" || grep -q "checkpoint" "$PO_FILE"; then
    pass "project-orchestrator has checkpointed execution"
  else
    fail "project-orchestrator missing checkpointed execution"
  fi

  if grep -q "independently verifiable" "$PO_FILE"; then
    pass "project-orchestrator requires chunks to be independently verifiable"
  else
    fail "project-orchestrator missing independent verifiability requirement"
  fi
fi

# ============================================
# TEST 7: software-engineer chunked implementation
# ============================================
echo ""
echo "--- Test 7: Software Engineer Chunked Implementation ---"

SE_FILE="$CLAUDE_DIR/agents/software-engineer/software-engineer.md"
if [ ! -f "$SE_FILE" ]; then
  fail "software-engineer agent file not found"
else
  if grep -q "500-line file max" "$SE_FILE"; then
    pass "software-engineer has 500-line file max rule"
  else
    fail "software-engineer missing 500-line file max rule"
  fi

  if grep -q "ONE function" "$SE_FILE" || grep -q "one function" "$SE_FILE"; then
    pass "software-engineer has one-function-at-a-time rule"
  else
    fail "software-engineer missing one-function-at-a-time rule"
  fi

  if grep -q "write, test, write, test" "$SE_FILE" || grep -q "Write, test, write, test" "$SE_FILE"; then
    pass "software-engineer has write-test-write-test cycle"
  else
    fail "software-engineer missing write-test-write-test cycle"
  fi

  if grep -q "Per Chunk" "$SE_FILE"; then
    pass "software-engineer has per-chunk testing"
  else
    fail "software-engineer missing per-chunk testing section"
  fi

  if grep -q "Never write more than one function before testing" "$SE_FILE"; then
    pass "software-engineer has one-function-before-testing rule"
  else
    fail "software-engineer missing one-function-before-testing rule"
  fi
fi

# ============================================
# TEST 8: Eval files cover chunking criteria
# ============================================
echo ""
echo "--- Test 8: Eval Coverage for Chunking ---"

# context-loader evals should test progressive loading
CTX_EVAL="$CLAUDE_DIR/skills/context-loader/evals/eval-quality.json"
if [ -f "$CTX_EVAL" ]; then
  if grep -q "progressive" "$CTX_EVAL" || grep -q "Progressive" "$CTX_EVAL"; then
    pass "context-loader eval tests progressive loading"
  else
    fail "context-loader eval missing progressive loading criterion"
  fi
else
  fail "context-loader eval-quality.json not found"
fi

# project-kickoff evals should test atomic chunks
PK_EVAL="$CLAUDE_DIR/skills/project-kickoff/evals/eval-quality.json"
if [ -f "$PK_EVAL" ]; then
  if grep -q "atomic" "$PK_EVAL" || grep -q "chunk" "$PK_EVAL"; then
    pass "project-kickoff eval tests atomic chunking"
  else
    fail "project-kickoff eval missing atomic chunking criterion"
  fi
else
  fail "project-kickoff eval-quality.json not found"
fi

# self-eval should test chunk verification
SE_EVAL="$CLAUDE_DIR/skills/self-eval/evals/eval-quality.json"
if [ -f "$SE_EVAL" ]; then
  if grep -q "chunk" "$SE_EVAL" || grep -q "500" "$SE_EVAL"; then
    pass "self-eval eval tests chunk compliance"
  else
    fail "self-eval eval missing chunk compliance criterion"
  fi
else
  fail "self-eval eval-quality.json not found"
fi

# ============================================
# TEST 9: Health check script passes
# ============================================
echo ""
echo "--- Test 9: Health Check Integration ---"

HEALTH_SCRIPT="$CLAUDE_DIR/skills/agent-trainer/scripts/health-check.sh"
if [ -f "$HEALTH_SCRIPT" ]; then
  health_output=$(bash "$HEALTH_SCRIPT" "$CLAUDE_DIR" 2>&1)
  health_exit=$?
  if [ $health_exit -eq 0 ]; then
    pass "health-check.sh passes (exit 0)"
  else
    fail "health-check.sh fails (exit $health_exit)"
    echo "    Output: $(echo "$health_output" | grep -E 'FAIL|ERROR')"
  fi
else
  fail "health-check.sh not found"
fi

# ============================================
# TEST 10: calculate-score.sh edge cases
# ============================================
echo ""
echo "--- Test 10: Score Calculator Edge Cases ---"

SCORE_SCRIPT="$CLAUDE_DIR/skills/self-eval/scripts/calculate-score.sh"
if [ -f "$SCORE_SCRIPT" ]; then
  # Test perfect score
  result=$(echo "completeness=10 correctness=10 quality=10 efficiency=10 innovation=10" | bash "$SCORE_SCRIPT" 2>&1)
  if echo "$result" | grep -q "10.0/10"; then
    pass "calculate-score: perfect 10 works"
  else
    fail "calculate-score: perfect 10 broken — got: $(echo "$result" | grep Overall)"
  fi

  # Test minimum score
  result=$(echo "completeness=1 correctness=1 quality=1 efficiency=1 innovation=1" | bash "$SCORE_SCRIPT" 2>&1)
  if echo "$result" | grep -q "1.0/10"; then
    pass "calculate-score: minimum score works"
  else
    fail "calculate-score: minimum score broken — got: $(echo "$result" | grep Overall)"
  fi

  # Test missing value (should exit 3)
  result=$(echo "completeness=8 correctness=9" | bash "$SCORE_SCRIPT" 2>&1)
  exit_code=$?
  if [ $exit_code -eq 3 ]; then
    pass "calculate-score: catches missing values (exit 3)"
  else
    fail "calculate-score: doesn't catch missing values (exit $exit_code)"
  fi

  # Test boundary score (exactly 8 = PASS)
  result=$(echo "completeness=8 correctness=8 quality=8 efficiency=8 innovation=8" | bash "$SCORE_SCRIPT" 2>&1)
  if echo "$result" | grep -q "PASS"; then
    pass "calculate-score: boundary 8.0 = PASS"
  else
    fail "calculate-score: boundary 8.0 not PASS — got: $(echo "$result" | grep STATUS)"
  fi

  # Test boundary score (7.9 = NEEDS IMPROVEMENT)
  result=$(echo "completeness=8 correctness=8 quality=8 efficiency=7 innovation=7" | bash "$SCORE_SCRIPT" 2>&1)
  exit_code=$?
  if [ $exit_code -eq 1 ]; then
    pass "calculate-score: 7.6 = NEEDS IMPROVEMENT"
  else
    fail "calculate-score: 7.6 wrong status (exit $exit_code)"
  fi
else
  fail "calculate-score.sh not found"
fi

# ============================================
# SUMMARY
# ============================================
echo ""
echo "=========================================="
echo "  RESULTS"
echo "=========================================="
echo -e "  ${green}Passed${nc}: $PASS"
echo -e "  ${red}Failed${nc}: $FAIL"
echo -e "  ${yellow}Warnings${nc}: $WARN"
echo "  Total:  $TOTAL"
echo ""

if [ $FAIL -gt 0 ]; then
  echo -e "  ${red}STATUS: $FAIL FAILURE(S) FOUND${nc}"
  exit 1
else
  echo -e "  ${green}STATUS: ALL TESTS PASSED${nc}"
  exit 0
fi
