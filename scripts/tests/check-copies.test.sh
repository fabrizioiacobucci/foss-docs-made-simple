#!/usr/bin/env bash
# Tests of scripts/check-copies.sh, through its command line.
# Usage: scripts/tests/check-copies.test.sh

source "$(dirname "$0")/helpers.sh"

readonly TAG_LINE='This repository follows foss-docs-made-simple itself, at framework tag `v0.1.0`; its level is recorded in its CHECKLIST.'
readonly VALID_REGISTER='| `README` | `active` | 2026-10-14 |
| arc42 section 9 | `draft` |  |'
readonly VALID_LOG='| 2026-10-14 | Level set to passing | Adoption |'

#######################################
# Prints a CHECKLIST in the form of the framework's, with the given values.
# Arguments:
#   $1  level
#   $2  register rows, or "" for none
#   $3  log rows, or "" for none
#   $4  tag in the links, TAG in the framework document
# Outputs:
#   the document, on stdout
# Example:
#   checklist passing "$VALID_REGISTER" "" v0.1.0 >docs/CHECKLIST.md
#######################################
checklist() {
  printf '# Checklist\n\n## Level\n\nLevel: %s\n\n## Register\n\n| Document | Status | Reviewed |\n|---|---|---|\n' "$1"
  [[ -z $2 ]] || printf '%s\n' "$2"
  printf '\n- **Status** MUST be one of `draft`, `active` or `retired`.\n\n## Log\n\n| Date | Entry | Reason |\n|---|---|---|\n'
  [[ -z $3 ]] || printf '%s\n' "$3"
  printf '\n## Links\n\n[governance]: https://github.com/fabrizioiacobucci/foss-docs-made-simple/blob/%s/framework/GOVERNANCE.md\n' "$4"
}

#######################################
# Prints a DEFINITION-OF-DONE in the form of the framework's.
# Arguments:
#   $1  tag in the links, TAG in the framework document
# Outputs:
#   the document, on stdout
# Example:
#   definition_of_done v0.1.0 >docs/DEFINITION-OF-DONE.md
#######################################
definition_of_done() {
  printf '# Definition of Done\n\n- A release MUST NOT be made while a required document is missing ([DOCUMENTS-INDEX][index]).\n\n[index]: https://github.com/fabrizioiacobucci/foss-docs-made-simple/blob/%s/framework/DOCUMENTS-INDEX.md\n' "$1"
}

#######################################
# Writes, in the current directory, an adopter of tag v0.1.0 whose copies
# match the framework documents and hold valid values.
# Arguments:
#   none
# Example:
#   make_adopter
#######################################
make_adopter() {
  printf '# Project\n\n%s\n' "$TAG_LINE" >README.md
  mkdir -p framework docs
  checklist '_passing, silver or gold_' '' '' TAG >framework/CHECKLIST.md
  definition_of_done TAG >framework/DEFINITION-OF-DONE.md
  checklist passing "$VALID_REGISTER" "$VALID_LOG" v0.1.0 >docs/CHECKLIST.md
  definition_of_done v0.1.0 >docs/DEFINITION-OF-DONE.md
}

#######################################
# Makes the current directory a git repository with one commit of all its
# files, tagged v0.1.0 with an annotated tag, as releases usually are.
# Arguments:
#   none
# Example:
#   commit_and_tag
#######################################
commit_and_tag() {
  fixture_git init -q
  fixture_git add -A
  fixture_git commit -q -m fixture
  fixture_git tag -a -m v0.1.0 v0.1.0
}

#######################################
# Fails the test unless a CHECKLIST copy with the given values is rejected
# with the given problem.
# Arguments:
#   $1  level
#   $2  register rows
#   $3  log rows
#   $4  expected problem, part of the report line
# Example:
#   expect_rejected platinum "$VALID_REGISTER" "" 'level "platinum"'
#######################################
expect_rejected() {
  checklist "$1" "$2" "$3" v0.1.0 >docs/CHECKLIST.md
  run_check check-copies.sh
  assert_status 1
  assert_stdout_has "docs/CHECKLIST.md:"
  assert_stdout_has "$4"
}

#######################################
# Fails the test unless the check cannot run, with the given reason.
# Arguments:
#   $1  expected reason, part of the error
# Example:
#   expect_cannot_run "README.md is missing"
#######################################
expect_cannot_run() {
  run_check check-copies.sh
  assert_status 2
  assert_stderr_has "$1"
}

test_passes_when_the_copies_match_the_working_tree() {
  make_adopter
  run_check check-copies.sh
  assert_status 0
  assert_stdout_has "The copies match the framework documents in the working tree."
  assert_stderr_has "tag v0.1.0 not found; comparing with framework/ in the working tree"
}

test_reports_a_changed_rule_in_a_copy() {
  make_adopter
  edit docs/DEFINITION-OF-DONE.md 's/MUST NOT/SHOULD NOT/'
  run_check check-copies.sh
  assert_status 1
  assert_stdout_has "docs/DEFINITION-OF-DONE.md differs from framework/DEFINITION-OF-DONE.md at v0.1.0:"
  assert_stdout_has "+- A release SHOULD NOT be made"
}

test_reports_a_changed_form_in_the_checklist_copy() {
  make_adopter
  edit docs/CHECKLIST.md 's/| Document | Status | Reviewed |/| Document | State | Reviewed |/'
  run_check check-copies.sh
  assert_status 1
  assert_stdout_has "docs/CHECKLIST.md differs from framework/CHECKLIST.md at v0.1.0:"
}

test_reports_links_not_pointing_at_the_adopted_tag() {
  make_adopter
  definition_of_done TAG >docs/DEFINITION-OF-DONE.md
  run_check check-copies.sh
  assert_status 1
  assert_stdout_has "docs/DEFINITION-OF-DONE.md differs"
  checklist passing "$VALID_REGISTER" "" v0.2.0 >docs/CHECKLIST.md
  definition_of_done v0.1.0 >docs/DEFINITION-OF-DONE.md
  run_check check-copies.sh
  assert_status 1
  assert_stdout_has "docs/CHECKLIST.md differs"
}

test_ignores_carriage_returns_and_a_missing_final_newline() {
  make_adopter
  awk '{ printf "%s\r\n", $0 }' docs/CHECKLIST.md >crlf && mv crlf docs/CHECKLIST.md
  printf '%s' "$(cat docs/DEFINITION-OF-DONE.md)" >no-newline && mv no-newline docs/DEFINITION-OF-DONE.md
  run_check check-copies.sh
  assert_status 0
}

test_accepts_every_level_status_and_leap_day() {
  make_adopter
  local level
  for level in passing silver gold; do
    checklist "$level" '| `README` | `active` | 2000-02-29 |
| `SECURITY` | `draft` |  |
| `THREAT-MODEL` | `retired` | 2026-01-31 |
| arc42 section 8 | `active` | 2026-12-31 |' '| 2024-02-29 | Level raised | Silver criteria met |' v0.1.0 >docs/CHECKLIST.md
    run_check check-copies.sh
    assert_status 0
  done
}

test_rejects_a_level_outside_the_three() {
  make_adopter
  expect_rejected platinum "$VALID_REGISTER" "" 'level "platinum" is not passing, silver or gold'
  expect_rejected '' "$VALID_REGISTER" "" 'level "" is not passing, silver or gold'
}

test_rejects_a_document_name_of_another_form() {
  make_adopter
  expect_rejected passing '| README | `active` |  |' "" 'document "README" is neither an id in code format nor "arc42 section N"'
  expect_rejected passing '| arc42 section eight | `active` |  |' "" 'document "arc42 section eight" is neither'
}

test_rejects_a_document_with_two_rows() {
  make_adopter
  expect_rejected passing '| `README` | `active` |  |
| `README` | `draft` |  |' "" 'document `README` has more than one row'
}

test_rejects_an_unknown_status() {
  make_adopter
  expect_rejected passing '| `README` | `done` |  |' "" 'status "`done`" is not `draft`, `active` or `retired`'
  expect_rejected passing '| `README` | active |  |' "" 'status "active" is not'
}

test_rejects_a_reviewed_date_that_does_not_exist() {
  make_adopter
  local date
  for date in 2026-13-01 2026-00-10 2026-04-31 2026-02-29 1900-02-29 2026-1-5 14/10/2026; do
    expect_rejected passing "| \`README\` | \`active\` | $date |" "" "reviewed date \"$date\" is not a valid YYYY-MM-DD date"
  done
}

test_rejects_a_log_date_that_does_not_exist() {
  make_adopter
  expect_rejected passing "$VALID_REGISTER" '| 2026-02-30 | Level raised | Criteria met |' 'log date "2026-02-30" is not a valid YYYY-MM-DD date'
  expect_rejected passing "$VALID_REGISTER" '|  | Level raised | Criteria met |' 'log date "" is not a valid YYYY-MM-DD date'
}

test_rejects_a_row_without_three_columns() {
  make_adopter
  expect_rejected passing '| `README` | `active` |' "" 'row has 2 columns instead of 3'
  expect_rejected passing "$VALID_REGISTER" '| 2026-10-14 | Level raised | Criteria met | Extra |' 'row has 4 columns instead of 3'
}

test_cannot_run_without_a_single_valid_tag_in_the_readme() {
  make_adopter
  printf '# Project\n' >README.md
  expect_cannot_run "README.md states no framework tag"
  printf '# Project\n\n%s\n%s\n' "$TAG_LINE" "$TAG_LINE" >README.md
  expect_cannot_run "README.md states more than one framework tag"
  printf '# Project\n\n%s\n' "${TAG_LINE/v0.1.0/0.1}" >README.md
  expect_cannot_run '"0.1" is not a framework tag (vMAJOR.MINOR.PATCH)'
  rm README.md
  expect_cannot_run "README.md is missing"
}

test_cannot_run_when_a_copy_is_missing() {
  make_adopter
  rm docs/CHECKLIST.md
  expect_cannot_run "docs/CHECKLIST.md is missing"
}

test_cannot_run_when_a_framework_document_is_missing() {
  make_adopter
  rm framework/DEFINITION-OF-DONE.md
  expect_cannot_run "framework/DEFINITION-OF-DONE.md is missing"
}

test_compares_with_the_framework_at_the_tag() {
  make_adopter
  commit_and_tag
  edit framework/DEFINITION-OF-DONE.md 's/MUST NOT/SHOULD NOT/'
  run_check check-copies.sh
  assert_status 0
  assert_stdout_has "The copies match the framework documents at v0.1.0."
  edit docs/DEFINITION-OF-DONE.md 's/MUST NOT/SHOULD NOT/'
  run_check check-copies.sh
  assert_status 1
  assert_stdout_has "docs/DEFINITION-OF-DONE.md differs from framework/DEFINITION-OF-DONE.md at v0.1.0:"
}

test_cannot_run_when_a_framework_document_is_missing_at_the_tag() {
  make_adopter
  mv framework/DEFINITION-OF-DONE.md ../kept.md
  commit_and_tag
  mv ../kept.md framework/DEFINITION-OF-DONE.md
  expect_cannot_run "framework/DEFINITION-OF-DONE.md does not exist at v0.1.0"
}

test_cannot_run_when_the_tag_is_on_origin_but_not_fetched() {
  mkdir ../upstream
  (cd ../upstream && make_adopter && commit_and_tag)
  fixture_git clone -q --no-tags ../upstream .
  expect_cannot_run "tag v0.1.0 is on origin but not fetched; run: git fetch --tags"
}

test_cannot_run_when_origin_is_unreachable() {
  make_adopter
  fixture_git init -q
  fixture_git remote add origin ../nowhere.git
  expect_cannot_run "cannot reach origin to tell whether tag v0.1.0 exists"
}

test_uses_the_working_tree_when_origin_has_no_such_tag() {
  mkdir ../upstream
  (cd ../upstream && make_adopter && fixture_git init -q && fixture_git add -A && fixture_git commit -q -m fixture)
  fixture_git clone -q ../upstream .
  run_check check-copies.sh
  assert_status 0
  assert_stdout_has "The copies match the framework documents in the working tree."
  assert_stderr_has "tag v0.1.0 not found"
}

test_checks_the_given_root() {
  mkdir site
  (cd site && make_adopter)
  run_check check-copies.sh site
  assert_status 0
  assert_stdout_has "in the working tree"
}

test_checks_the_given_root_at_its_tag() {
  make_adopter
  commit_and_tag
  edit framework/DEFINITION-OF-DONE.md 's/MUST NOT/SHOULD NOT/'
  cd ..
  run_check check-copies.sh repo
  assert_status 0
  assert_stdout_has "The copies match the framework documents at v0.1.0."
}

test_cannot_run_when_the_root_is_not_a_directory() {
  run_check check-copies.sh missing
  assert_status 2
  assert_stderr_has "missing: not a directory"
}

test_cannot_run_with_more_than_one_argument() {
  run_check check-copies.sh one two
  assert_status 2
  assert_stderr_has "usage: scripts/check-copies.sh [ROOT]"
}

run_tests
