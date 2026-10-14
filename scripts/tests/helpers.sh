# Helpers for the tests of the check scripts, sourced by each *.test.sh file:
# a fresh fixture directory per test, a runner that keeps a check's exit
# status and output, and assertions on them.

set -euo pipefail

readonly SCRIPTS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
FIXTURES_ROOT=$(cd "$(mktemp -d "${TMPDIR:-/tmp}/check-tests.XXXXXX")" && pwd -P)
readonly FIXTURES_ROOT
trap 'rm -rf "$FIXTURES_ROOT"' EXIT
# Keeps git on the fixtures: no repository found above a fixture, such as
# this one; none named by the environment, as in a git hook; and no user or
# system configuration, which may sign commits, run hooks or forbid local
# clones.
export GIT_CEILING_DIRECTORIES=$FIXTURES_ROOT
unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE GIT_COMMON_DIR GIT_OBJECT_DIRECTORY GIT_ALTERNATE_OBJECT_DIRECTORIES
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null HOME=$FIXTURES_ROOT

#######################################
# Writes stdin to a file, creating its parent directories.
# Arguments:
#   $1  path of the file
# Example:
#   write docs/guide.md <<<'# Guide'
#######################################
write() {
  mkdir -p "$(dirname "$1")"
  cat >"$1"
}

#######################################
# Edits a file in place with a sed script, the same way on BSD and GNU sed.
# Arguments:
#   $1  path of the file
#   $2  sed script
# Example:
#   edit docs/CHECKLIST.md 's/passing/gold/'
#######################################
edit() {
  sed "$2" "$1" >"$1.edited"
  mv "$1.edited" "$1"
}

#######################################
# Runs git with a fixed identity, so that fixture commits and tags work on
# any machine, and ends the test when git fails.
# Arguments:
#   git arguments
# Example:
#   fixture_git commit -q -m fixture
#######################################
fixture_git() {
  git -c user.name=Test -c user.email=test@example.invalid \
    -c init.defaultBranch=main "$@" || fail "git $1 failed while building the fixture"
}

#######################################
# Runs a check script and keeps its exit status in $status, its standard
# output in $TEST_DIR/stdout and its standard error in $TEST_DIR/stderr.
# Arguments:
#   $1  script name in scripts/, such as check-links.sh
#   the script's arguments
# Example:
#   run_check check-links.sh docs
#######################################
run_check() {
  local script=$1
  shift
  status=0
  "$SCRIPTS_DIR/$script" "$@" >"$TEST_DIR/stdout" 2>"$TEST_DIR/stderr" || status=$?
}

#######################################
# Prints why the current test failed, with the output of the last check, and
# ends the test.
# Arguments:
#   $1  reason
# Example:
#   fail "expected exit status 0, got 1"
#######################################
fail() {
  local stream
  echo "    $1"
  for stream in stdout stderr; do
    if [[ -s $TEST_DIR/$stream ]]; then
      echo "    $stream:"
      sed 's/^/      /' "$TEST_DIR/$stream"
    fi
  done
  exit 1
}

#######################################
# Fails the test unless the last check exited with the given status.
# Arguments:
#   $1  expected exit status
# Example:
#   assert_status 1
#######################################
assert_status() {
  [[ $status == "$1" ]] || fail "expected exit status $1, got $status"
}

#######################################
# Fails the test unless the standard output of the last check holds a text.
# Arguments:
#   $1  text, matched literally
# Example:
#   assert_stdout_has "All relative links resolve."
#######################################
assert_stdout_has() {
  grep -qF -- "$1" "$TEST_DIR/stdout" || fail "stdout lacks: $1"
}

#######################################
# Fails the test when the standard output of the last check holds a text.
# Arguments:
#   $1  text, matched literally
# Example:
#   assert_stdout_lacks "missing-a.md"
#######################################
assert_stdout_lacks() {
  ! grep -qF -- "$1" "$TEST_DIR/stdout" || fail "stdout holds: $1"
}

#######################################
# Fails the test unless the standard error of the last check holds a text.
# Arguments:
#   $1  text, matched literally
# Example:
#   assert_stderr_has "not a directory"
#######################################
assert_stderr_has() {
  grep -qF -- "$1" "$TEST_DIR/stderr" || fail "stderr lacks: $1"
}

#######################################
# Runs every function whose name starts with "test_", each in a subshell
# whose working directory is a new empty directory, prints one line per
# test and a summary, and returns 1 when any test failed or none was found.
# Arguments:
#   none
# Example:
#   run_tests
#######################################
run_tests() {
  local name passed=0 failed=0
  for name in $(declare -F | awk '$3 ~ /^test_/ { print $3 }'); do
    TEST_DIR="$FIXTURES_ROOT/$name"
    mkdir -p "$TEST_DIR/repo"
    if (cd "$TEST_DIR/repo" && "$name"); then
      echo "ok   $name"
      passed=$((passed + 1))
    else
      echo "FAIL $name"
      failed=$((failed + 1))
    fi
  done
  echo "$passed passed, $failed failed"
  ((passed + failed > 0)) || { echo "no test_ function found"; return 1; }
  ((failed == 0))
}
