#!/usr/bin/env bash
# Checks that a project's copies of the copied framework documents,
# CHECKLIST.md and DEFINITION-OF-DONE.md, match framework/ in a clone of the
# framework at the framework tag that the project's README states, except
# for TAG replaced by that tag and, in the CHECKLIST, the values filled in;
# and that those values have a valid form: the level, each register row
# (document name, status, date) and each log date, as the framework's
# CHECKLIST defines them at v0.1.0 and v0.2.0. It does not check that the
# register lists every required document. Carriage returns and a missing
# final newline are ignored.
#
# The README is the first of README.md, .github/README.md and docs/README.md
# under ROOT, as GitHub reads them. The script needs it to state the tag
# exactly once, outside fenced code, in the form
#   framework tag `vMAJOR.MINOR.PATCH`
# such as "at framework tag `v0.2.0`". This is a requirement of this tool,
# not a framework rule. The tag is read from the clone, which must hold it:
# the script never uses the network. When ROOT is the clone itself and the
# tag does not exist yet, as before a framework release, framework/ in its
# working tree is the reference, with a warning.
#
# Known gaps: both copies must be in one directory; the script finds
# scripts/lib/ next to itself, so a symbolic link to it is not supported.
#
# Usage: scripts/check-copies.sh [--framework DIR] [--docs DIR] [ROOT]
#   --framework DIR  clone of the framework to read the framework documents
#                    from; defaults to the clone this script belongs to.
#   --docs DIR       directory of the copies, relative to ROOT unless
#                    absolute; defaults to docs.
#   ROOT             project to check; defaults to the current directory.
# Exit status: 0 when the copies match, 1 when they do not, 2 when the check
#   cannot run (wrong arguments, ROOT not a directory, DIR not a git clone,
#   no README or no single valid tag in it, a file missing, or the tag not
#   in the clone).
# Example: ../foss-docs-made-simple/scripts/check-copies.sh . && echo "ok"

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib/markdown.sh"

readonly COPIED_DOCUMENTS=(DEFINITION-OF-DONE.md CHECKLIST.md)
readonly TABLE_SEPARATOR='^[|]( *-+ *[|])+ *$'
readonly TAG_STATEMENT='framework tag `v[0-9]+\.[0-9]+\.[0-9]+`'
readonly USAGE='usage: scripts/check-copies.sh [--framework DIR] [--docs DIR] [ROOT]'

#######################################
# Prints an error and exits with status 2.
# Arguments:
#   $1  message
# Example:
#   fail_to_run "docs/CHECKLIST.md is missing"
#######################################
fail_to_run() {
  echo "check-copies: $1" >&2
  exit 2
}

#######################################
# Prints the path of the project's README under ROOT: the first of
# README.md, .github/README.md and docs/README.md that exists, as GitHub
# reads them. Exits with status 2 when there is none.
# Arguments:
#   $1  absolute path of ROOT
# Outputs:
#   the path, relative to ROOT, on stdout
# Example:
#   readme=$(project_readme "$root")
#######################################
project_readme() {
  local root=$1 path
  for path in README.md .github/README.md docs/README.md; do
    if [[ -f $root/$path ]]; then
      printf '%s\n' "$path"
      return
    fi
  done
  fail_to_run "no README.md in ROOT, .github/ or docs/"
}

#######################################
# Prints the framework tag that a README states, and exits with status 2
# unless the README states exactly one, outside fenced code, in the form
# framework tag `vMAJOR.MINOR.PATCH`.
# Arguments:
#   $1  absolute path of ROOT
#   $2  path of the README, relative to ROOT
# Outputs:
#   the tag, such as v0.1.0, on stdout
# Example:
#   tag=$(adopted_tag "$root" README.md)
#######################################
adopted_tag() {
  local root=$1 readme=$2 statements count
  statements=$(markdown_text "$root/$readme" | cut -f 2- | grep -oE "$TAG_STATEMENT" || true)
  count=$(printf '%s' "$statements" | grep -c . || true)
  ((count > 0)) || fail_to_run "$readme states no framework tag in the form: framework tag \`vMAJOR.MINOR.PATCH\`"
  ((count == 1)) || fail_to_run "$readme states more than one framework tag"
  printf '%s\n' "$statements" | sed -E 's/^framework tag `(.*)`$/\1/'
}

#######################################
# Tells whether framework/ should be read at the tag in the clone, or from
# the clone's working tree, which happens only when ROOT is the clone itself
# and the tag does not exist yet, as before a framework release. Exits with
# status 2 when the tag is missing from the clone of another project's
# framework.
# Arguments:
#   $1  framework tag
#   $2  absolute path of the framework clone
#   $3  absolute path of ROOT
# Outputs:
#   "tag" or "working-tree" on stdout; a warning on stderr for the latter
# Example:
#   source=$(reference_source v0.1.0 "$framework" "$root")
#######################################
reference_source() {
  local tag=$1 framework=$2 root=$3
  if git -C "$framework" rev-parse -q --verify "refs/tags/$tag^{commit}" >/dev/null 2>&1; then
    echo tag
  elif [[ $root == "$framework" ]]; then
    echo "check-copies: tag $tag not found; comparing with framework/ in the working tree" >&2
    echo working-tree
  else
    fail_to_run "tag $tag is not in the framework clone $framework; run: git -C $framework fetch --tags"
  fi
}

#######################################
# Exits with status 2 when a framework document does not exist in the
# given source.
# Arguments:
#   $1  framework tag
#   $2  "tag" or "working-tree"
#   $3  absolute path of the framework clone
#   $4  file name in framework/, such as CHECKLIST.md
# Example:
#   require_framework_document v0.1.0 tag "$framework" CHECKLIST.md
#######################################
require_framework_document() {
  local tag=$1 source=$2 framework=$3 name=$4
  if [[ $source == tag ]]; then
    git -C "$framework" cat-file -e "refs/tags/$tag:framework/$name" 2>/dev/null \
      || fail_to_run "framework/$name does not exist at $tag"
  else
    [[ -f $framework/framework/$name ]] || fail_to_run "framework/$name is missing"
  fi
}

#######################################
# Prints a framework document from the given source, with TAG in its links
# replaced by the tag.
# Arguments:
#   $1  framework tag
#   $2  "tag" or "working-tree"
#   $3  absolute path of the framework clone
#   $4  file name in framework/, such as CHECKLIST.md
# Outputs:
#   the document, on stdout
# Example:
#   framework_document v0.1.0 tag "$framework" CHECKLIST.md | head -n 1
#######################################
framework_document() {
  local tag=$1 source=$2 framework=$3 name=$4
  if [[ $source == tag ]]; then
    git -C "$framework" show "refs/tags/$tag:framework/$name"
  else
    cat "$framework/framework/$name"
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
#   $2  name of the copy in the report, such as docs/CHECKLIST.md
# Outputs:
#   one line per problem, on stdout
# Returns:
#   0 when every value has a valid form, 1 otherwise
# Example:
#   check_checklist_values "$root/docs/CHECKLIST.md" docs/CHECKLIST.md
#######################################
check_checklist_values() {
  awk -v file="$2" -v separator="$TABLE_SEPARATOR" '
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
#   $3  absolute path of the framework clone
#   $4  file name in framework/ and in the copies' directory
#   $5  absolute path of the copies' directory
#   $6  name of the copies' directory in the report, such as docs
#   $7  directory for the two normalised files
# Outputs:
#   the differences, on stdout
# Returns:
#   0 when they match, 1 otherwise
# Example:
#   compare_copy v0.1.0 tag "$framework" DEFINITION-OF-DONE.md "$root/docs" docs "$work_dir"
#######################################
compare_copy() {
  local tag=$1 source=$2 framework=$3 name=$4 docs=$5 docs_label=$6 dir=$7
  framework_document "$tag" "$source" "$framework" "$name" | normalise "$name" >"$dir/framework-$name"
  normalise "$name" <"$docs/$name" >"$dir/copy-$name"
  if ! diff -u "$dir/framework-$name" "$dir/copy-$name" >"$dir/diff"; then
    echo "$docs_label/$name differs from framework/$name at $tag:"
    cat "$dir/diff"
    return 1
  fi
}

#######################################
# Prints the absolute path of the top of the git clone that holds a
# directory, and exits with status 2 when it is not in one.
# Arguments:
#   $1  directory, as given on the command line
# Outputs:
#   the absolute path, on stdout
# Example:
#   framework=$(framework_clone ../foss-docs-made-simple)
#######################################
framework_clone() {
  [[ -d $1 ]] && git -C "$1" rev-parse --show-toplevel 2>/dev/null \
    || fail_to_run "$1 is not a git clone of the framework"
}

#######################################
# Runs every check on the copies of the project under ROOT.
# Arguments:
#   [--framework DIR] [--docs DIR] [ROOT], as in the usage above
# Outputs:
#   the problems found, or a success line, on stdout
# Returns:
#   0 when the copies match, 1 otherwise; exits with 2 when the check
#   cannot run
# Example:
#   main --docs handbook .
#######################################
main() {
  local framework root='' docs_label=docs docs status=0 readme tag source work_dir name
  framework="$(dirname "${BASH_SOURCE[0]}")/.."
  while (($# > 0)); do
    case $1 in
      --framework | --docs)
        (($# >= 2)) || fail_to_run "$USAGE"
        if [[ $1 == --framework ]]; then framework=$2; else docs_label=$2; fi
        shift 2
        ;;
      -*) fail_to_run "$USAGE" ;;
      *)
        [[ -z $root ]] || fail_to_run "$USAGE"
        root=$1
        shift
        ;;
    esac
  done
  root=${root:-.}
  [[ -d $root ]] || fail_to_run "$root: not a directory"
  root=$(cd "$root" && pwd -P)
  framework=$(framework_clone "$framework")
  framework=$(cd "$framework" && pwd -P)
  if [[ $docs_label == /* ]]; then docs=$docs_label; else docs=$root/$docs_label; fi
  readme=$(project_readme "$root")
  tag=$(adopted_tag "$root" "$readme")
  source=$(reference_source "$tag" "$framework" "$root")
  for name in "${COPIED_DOCUMENTS[@]}"; do
    [[ -f $docs/$name ]] || fail_to_run "$docs_label/$name is missing"
    require_framework_document "$tag" "$source" "$framework" "$name"
  done
  work_dir=$(mktemp -d "${TMPDIR:-/tmp}/check-copies.XXXXXX")
  # Expanded now: work_dir is local to main and gone when the EXIT trap runs.
  trap "rm -rf $(printf '%q' "$work_dir")" EXIT
  for name in "${COPIED_DOCUMENTS[@]}"; do
    compare_copy "$tag" "$source" "$framework" "$name" "$docs" "$docs_label" "$work_dir" || status=1
  done
  check_checklist_values "$docs/CHECKLIST.md" "$docs_label/CHECKLIST.md" || status=1
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
