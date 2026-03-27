#!/bin/bash
# Calculates weighted overall score from individual dimension scores
# macOS compatible (no grep -P)
# Usage: echo "completeness=8 correctness=9 quality=7 efficiency=8 innovation=6" | ./calculate-score.sh

INPUT=$(cat)

extract() {
  echo "$INPUT" | sed -n "s/.*$1=\([0-9]*\).*/\1/p"
}

COMPLETENESS=$(extract completeness)
CORRECTNESS=$(extract correctness)
QUALITY=$(extract quality)
EFFICIENCY=$(extract efficiency)
INNOVATION=$(extract innovation)

# Validate
for var in COMPLETENESS CORRECTNESS QUALITY EFFICIENCY INNOVATION; do
  val=$(eval echo \$$var)
  if [ -z "$val" ]; then
    echo "ERROR: Missing $var value" >&2
    exit 3
  fi
done

# Weights: completeness 30%, correctness 30%, quality 20%, efficiency 10%, innovation 10%
OVERALL=$(echo "scale=1; ($COMPLETENESS * 0.3 + $CORRECTNESS * 0.3 + $QUALITY * 0.2 + $EFFICIENCY * 0.1 + $INNOVATION * 0.1)" | bc)

echo "Completeness: $COMPLETENESS/10 (30%)"
echo "Correctness:  $CORRECTNESS/10 (30%)"
echo "Quality:      $QUALITY/10 (20%)"
echo "Efficiency:   $EFFICIENCY/10 (10%)"
echo "Innovation:   $INNOVATION/10 (10%)"
echo "---"
echo "Overall Score: $OVERALL/10"

if (( $(echo "$OVERALL >= 8" | bc -l) )); then
  echo "STATUS: PASS — Production quality"
  exit 0
elif (( $(echo "$OVERALL >= 6" | bc -l) )); then
  echo "STATUS: NEEDS IMPROVEMENT"
  exit 1
else
  echo "STATUS: FAIL — Requires rework"
  exit 2
fi
