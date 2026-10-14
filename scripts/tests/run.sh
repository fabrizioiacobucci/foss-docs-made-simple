#!/usr/bin/env bash
# Runs every test file of the check scripts, scripts/tests/*.test.sh, each
# of which builds its fixtures in a temporary directory and removes them.
#
# Usage: scripts/tests/run.sh
# Exit status: 0 when every test passes, 1 otherwise.
# Example: scripts/tests/run.sh && echo "tests ok"

set -euo pipefail

status=0
for test_file in "$(dirname "$0")"/*.test.sh; do
  echo "== ${test_file##*/}"
  bash "$test_file" || status=1
done
exit "$status"
