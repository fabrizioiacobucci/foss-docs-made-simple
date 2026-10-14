#!/usr/bin/env bash
# Checks that this repository's copies of the copied framework documents,
# docs/CHECKLIST.md and docs/DEFINITION-OF-DONE.md, match framework/ at the
# framework tag that README.md states, except for TAG replaced by that tag
# and, in the CHECKLIST, the values filled in; and that those values have a
# valid form: the level, each register row (document name, status, date)
# and each log date. It does not check that the register lists every
# required document. Carriage returns and a missing final newline are
# ignored. While the tag exists neither locally nor on the remote origin,
# framework/ in the working tree is the reference, with a warning.
#
# Usage: scripts/check-copies.sh [ROOT]
#   ROOT  repository root to check; defaults to the current directory.
# Exit status: 0 when the copies match, 1 when they do not, 2 when the check
#   cannot run (bad arguments, ROOT not a directory, README.md stating no
#   single valid tag, a file missing, the tag on origin but not fetched, or
#   origin unreachable while the tag is not fetched).
# Example: scripts/check-copies.sh && echo "copies ok"

set -euo pipefail

readonly COPIED_DOCUMENTS=(DEFINITION-OF-DONE.md CHECKLIST.md)
readonly TABLE_SEPARATOR='^[|]( *-+ *[|])+ *$'

#######################################
# Prints an error and exits with status 2.
# Arguments:
#   $1  message
# Example:
#   fail_to_run "README.md is missing"
#######################################
fail_to_run() {
  echo "check-copies: $1" >&2
  exit 2
}

#######################################
# Prints the framework tag that README.md says this repository follows, and
# exits with status 2 unless README.md states exactly one tag of the form
# vMAJOR.MINOR.PATCH.
# Arguments:
#   none; reads README.md in the current directory
# Outputs:
#   the tag, such as v0.1.0, on stdout
# Example:
#   tag=$(adopted_tag)
#######################################
adopted_tag() {
  local tags
  [[ -f README.md ]] || fail_to_run "README.md is missing"
  tags=$(sed -nE 's/.*follows foss-docs-made-simple itself, at framework tag `([^`]+)`.*/\1/p' README.md)
  [[ -n $tags ]] || fail_to_run "README.md states no framework tag"
  [[ $tags != *$'\n'* ]] || fail_to_run "README.md states more than one framework tag"
  [[ $tags =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || fail_to_run "\"$tags\" is not a framework tag (vMAJOR.MINOR.PATCH)"
  printf '%s\n' "$tags"
}

#######################################
# Tells whether framework/ should be read at the tag (the tag exists here),
# or from the working tree (there is no remote origin, or origin answers
# that the tag does not exist, as before its first release). Exits with
# status 2 when the tag is on origin but not fetched, as in a clone made
# without tags, or when origin cannot be reached to tell. git ls-remote
# --exit-code returns 2 only when origin answered and has no such tag.
# Arguments:
#   $1  framework tag
# Outputs:
#   "tag" or "working-tree" on stdout; a warning on stderr for the latter
# Example:
#   source=$(reference_source v0.1.0)
#######################################
reference_source() {
  local tag=$1 remote_status
  if git rev-parse -q --verify "refs/tags/$tag" >/dev/null 2>&1; then
    echo tag
    return
  fi
  if git remote get-url origin >/dev/null 2>&1; then
    git ls-remote --exit-code --tags origin "refs/tags/$tag" >/dev/null 2>&1 \
      && remote_status=0 || remote_status=$?
    case $remote_status in
      0) fail_to_run "tag $tag is on origin but not fetched; run: git fetch --tags" ;;
      2) ;;
      *) fail_to_run "cannot reach origin to tell whether tag $tag exists; connect, or fetch the tags" ;;
    esac
  fi
  echo "check-copies: tag $tag not found; comparing with framework/ in the working tree" >&2
  echo working-tree
}

#######################################
# Exits with status 2 when a framework document does not exist in the
# given source.
# Arguments:
#   $1  framework tag
#   $2  "tag" or "working-tree"
#   $3  file name in framework/, such as CHECKLIST.md
# Example:
#   require_framework_document v0.1.0 tag CHECKLIST.md
#######################################
require_framework_document() {
  local tag=$1 source=$2 name=$3
  if [[ $source == tag ]]; then
    git cat-file -e "refs/tags/$tag:./framework/$name" 2>/dev/null \
      || fail_to_run "framework/$name does not exist at $tag"
  else
    [[ -f framework/$name ]] || fail_to_run "framework/$name is missing"
  fi
}

#######################################
# Prints a framework document from the given source, with TAG in its links
# replaced by the tag.
# Arguments:
#   $1  framework tag
#   $2  "tag" or "working-tree"
#   $3  file name in framework/, such as CHECKLIST.md
# Outputs:
#   the document, on stdout
# Example:
#   framework_document v0.1.0 tag CHECKLIST.md | head -n 1
#######################################
framework_document() {
  local tag=$1 source=$2 name=$3
  if [[ $source == tag ]]; then
    git show "refs/tags/$tag:./framework/$name"
  else
    cat "framework/$name"
  fi | sed "s#/blob/TAG/#/blob/$tag/#g"
}

#######################################
# Prints a document with carriage returns removed and a final newline,
# blanking the filled-in values when it is a CHECKLIST: the value of the
# "Level: " line and the data rows of its tables.
# Arguments:
#   $1  file name, such as CHECKLIST.md; reads the document on stdin
# Outputs:
#   the normalised document, on stdout
# Example:
#   normalise CHECKLIST.md <docs/CHECKLIST.md
#######################################
normalise() {
  local blank_values=0
  [[ $1 == CHECKLIST.md ]] && blank_values=1
  awk -v blank_values="$blank_values" -v separator="$TABLE_SEPARATOR" '
    { sub(/\r$/, "") }
    blank_values && /^Level: / { print "Level: "; next }
    blank_values && $0 ~ separator { print; in_rows = 1; next }
    blank_values && in_rows && /^[|]/ { next }
    { in_rows = 0; print }
  '
}

#######################################
# Checks the form of the values filled in a CHECKLIST copy: the level; in
# each register row, the column count, a document name in code format or
# "arc42 section N", unique, the status and the reviewed date; in each log
# row, the column count and the date. Reports each problem as
# "FILE:LINE: problem".
# Arguments:
#   $1  path of the CHECKLIST copy
# Outputs:
#   one line per problem, on stdout
# Returns:
#   0 when every value has a valid form, 1 otherwise
# Example:
#   check_checklist_values docs/CHECKLIST.md
#######################################
check_checklist_values() {
  awk -v file="$1" -v separator="$TABLE_SEPARATOR" '
    function fail(message) { print file ":" NR ": " message; bad = 1 }
    function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
    function is_date(s,   year, month, day, last) {
      if (s !~ /^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$/) return 0
      year = substr(s, 1, 4) + 0; month = substr(s, 6, 2) + 0; day = substr(s, 9, 2) + 0
      if (month < 1 || month > 12 || day < 1) return 0
      last = substr("312831303130313130313031", month * 2 - 1, 2) + 0
      if (month == 2 && year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) last = 29
      return day <= last
    }
    { sub(/\r$/, "") }
    /^## / { section = $0; in_rows = 0 }
    /^Level: / {
      level = trim(substr($0, 8))
      if (level !~ /^(passing|silver|gold)$/) fail("level \"" level "\" is not passing, silver or gold")
    }
    $0 ~ separator { in_rows = 1; next }
    in_rows && /^[|]/ {
      columns = split($0, cell, "|") - 2
      if (columns != 3) { fail("row has " columns " columns instead of 3"); next }
      if (section == "## Register") {
        document = trim(cell[2]); status = trim(cell[3]); reviewed = trim(cell[4])
        if (document !~ /^`[A-Z][A-Z_-]*`$/ && document !~ /^arc42 section [0-9]+$/)
          fail("document \"" document "\" is neither an id in code format nor \"arc42 section N\"")
        else if (seen[document]++) fail("document " document " has more than one row")
        if (status !~ /^`(draft|active|retired)`$/) fail("status \"" status "\" is not `draft`, `active` or `retired`")
        if (reviewed != "" && !is_date(reviewed)) fail("reviewed date \"" reviewed "\" is not a valid YYYY-MM-DD date")
      } else if (section == "## Log") {
        date = trim(cell[2])
        if (!is_date(date)) fail("log date \"" date "\" is not a valid YYYY-MM-DD date")
      }
      next
    }
    { in_rows = 0 }
    END { exit bad }
  ' "$1"
}

#######################################
# Compares a copy with the framework document it copies, both normalised,
# and prints a unified diff when they differ.
# Arguments:
#   $1  framework tag
#   $2  "tag" or "working-tree"
#   $3  file name in framework/ and in docs/
#   $4  directory for the two normalised files
# Outputs:
#   the differences, on stdout
# Returns:
#   0 when they match, 1 otherwise
# Example:
#   compare_copy v0.1.0 tag DEFINITION-OF-DONE.md "$work_dir"
#######################################
compare_copy() {
  local tag=$1 source=$2 name=$3 dir=$4
  framework_document "$tag" "$source" "$name" | normalise "$name" >"$dir/framework-$name"
  normalise "$name" <"docs/$name" >"$dir/copy-$name"
  if ! diff -u "$dir/framework-$name" "$dir/copy-$name" >"$dir/diff"; then
    echo "docs/$name differs from framework/$name at $tag:"
    cat "$dir/diff"
    return 1
  fi
}

#######################################
# Runs every check on the copies under ROOT.
# Arguments:
#   $1  repository root; defaults to the current directory
# Outputs:
#   the problems found, or a success line, on stdout
# Returns:
#   0 when the copies match, 1 otherwise; exits with 2 when the check
#   cannot run
# Example:
#   main .
#######################################
main() {
  (($# <= 1)) || fail_to_run "usage: scripts/check-copies.sh [ROOT]"
  local root=${1:-.} status=0 tag source work_dir name
  [[ -d $root ]] || fail_to_run "$root: not a directory"
  cd "$root"
  tag=$(adopted_tag)
  source=$(reference_source "$tag")
  for name in "${COPIED_DOCUMENTS[@]}"; do
    [[ -f docs/$name ]] || fail_to_run "docs/$name is missing"
    require_framework_document "$tag" "$source" "$name"
  done
  work_dir=$(mktemp -d "${TMPDIR:-/tmp}/check-copies.XXXXXX")
  # Expanded now: work_dir is local to main and gone when the EXIT trap runs.
  trap "rm -rf $(printf '%q' "$work_dir")" EXIT
  for name in "${COPIED_DOCUMENTS[@]}"; do
    compare_copy "$tag" "$source" "$name" "$work_dir" || status=1
  done
  check_checklist_values docs/CHECKLIST.md || status=1
  if ((status == 0)); then
    if [[ $source == tag ]]; then
      echo "The copies match the framework documents at $tag."
    else
      echo "The copies match the framework documents in the working tree."
    fi
  fi
  return "$status"
}

main "$@"
