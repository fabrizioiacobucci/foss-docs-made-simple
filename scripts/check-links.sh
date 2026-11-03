#!/usr/bin/env bash
# Checks that every relative link in the Markdown files under ROOT points to
# a file that exists, with the same letter case, and, when it has an anchor
# and the target is a Markdown file, to an ATX heading (# Title) of that
# file. Links with a scheme (https:, mailto:, ...) are not checked, nor are
# anchors on other files, setext headings or HTML anchors. Inside a git
# repository, the files are those git lists, tracked or not, except those it
# ignores (such as node_modules/) and tracked files deleted from the working
# tree; outside one, every Markdown file except those in .git/. It finds
# scripts/lib/ next to itself, so a symbolic link to it is not supported.
#
# Usage: scripts/check-links.sh [ROOT]
#   ROOT  directory to check, such as an adopter's repository; defaults to
#         the current directory.
# Exit status: 0 when every link resolves, 1 when at least one does not,
#   2 when the check cannot run (wrong arguments, ROOT not a directory, git
#   failing inside a repository, or no Markdown file found).
# Example: scripts/check-links.sh ../my-project && echo "links ok"

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/lib/markdown.sh"

#######################################
# Lists the anchors that GitHub generates for the ATX headings of a Markdown
# file: lower case, link targets and punctuation removed, letters beyond
# ASCII kept, spaces turned into hyphens, "-1", "-2"... added to repeats.
# Arguments:
#   $1  path of the Markdown file
# Outputs:
#   one anchor per line, on stdout
# Example:
#   anchors_of README.md   # adopting-the-framework, ...
#######################################
anchors_of() {
  markdown_text "$1" | LC_ALL=C awk -F '\t' '
    $2 ~ /^(   |  | )?#+([ \t]|$)/ {
      text = $2
      sub(/^ *#+[ \t]*/, "", text)
      sub(/[ \t#]*$/, "", text)
      gsub(/\]\([^)]*\)/, "", text)
      text = tolower(text)
      slug = ""
      for (i = 1; i <= length(text); i++) {
        c = substr(text, i, 1)
        if (c ~ /[a-z0-9_-]/ || c > "\177") slug = slug c
        else if (c == " ") slug = slug "-"
      }
      if (seen[slug]++) print slug "-" (seen[slug] - 1)
      else print slug
    }
  '
}

#######################################
# Lists the link targets of a Markdown file that have no scheme, from inline
# links and from link reference definitions, outside code, as
# "LINE<TAB>TARGET".
# Arguments:
#   $1  path of the Markdown file
# Outputs:
#   one "LINE<TAB>TARGET" per link, on stdout
# Example:
#   links_of README.md   # 13	framework/GOVERNANCE.md
#######################################
links_of() {
  markdown_text "$1" | awk -F '\t' '
    function emit(target) {
      if (target ~ /^</) { sub(/^</, "", target); sub(/>.*$/, "", target) }
      else sub(/[ \t].*$/, "", target)
      if (target == "" || tolower(target) ~ /^([a-z][a-z0-9+.-]*:|\/\/)/) return
      print $1 "\t" target
    }
    {
      line = $2
      gsub(/``[^`]*``|`[^`]*`/, "", line)
      if (match(line, /^(   |  | )?\[[^]]+\]:[ \t]+/)) {
        emit(substr(line, RSTART + RLENGTH))
        next
      }
      while (match(line, /\]\([^)]+\)/)) {
        emit(substr(line, RSTART + 2, RLENGTH - 3))
        line = substr(line, RSTART + RLENGTH)
      }
    }
  '
}

#######################################
# Tells whether a path exists with exactly the letter case it is written
# with, also on file systems that ignore case, such as the default on macOS.
# Arguments:
#   $1  path, relative to the current directory
# Returns:
#   0 when it exists with that case, 1 otherwise
# Example:
#   exists_with_case framework/GLOSSARY.md && echo found
#######################################
exists_with_case() {
  local current=. component
  local IFS=/
  for component in $1; do
    case $component in
      '' | .) continue ;;
      ..) current="$current/.." ;;
      *)
        ls -a "$current" 2>/dev/null | grep -xF -- "$component" >/dev/null || return 1
        current="$current/$component"
        ;;
    esac
  done
  [[ -e $current ]]
}

#######################################
# Checks the relative links of one Markdown file and reports each broken
# one as "FILE:LINE: TARGET (reason)".
# Arguments:
#   $1  path of the Markdown file, relative to the repository root
# Outputs:
#   one line per broken link, on stdout
# Returns:
#   0 when every link resolves, 1 otherwise
# Example:
#   check_file README.md
#######################################
check_file() {
  local file=$1 dir status=0 line_no target path anchor
  dir=$(dirname "$file")
  while IFS=$'\t' read -r line_no target; do
    path=${target%%#*}
    path=${path%%\?*}
    path=$(printf '%b' "${path//%/\\x}")
    anchor=''
    [[ $target == *'#'* ]] && anchor=${target#*#}
    if [[ -z $path ]]; then
      path=$file
    elif [[ $path == /* ]]; then
      path=".$path"
    else
      path="$dir/$path"
    fi
    if ! exists_with_case "$path"; then
      echo "$file:$line_no: $target (missing file, or different letter case)"
      status=1
    elif [[ -n $anchor && -f $path && $path == *.md ]] \
      && ! anchors_of "$path" | grep -xF -- "$anchor" >/dev/null; then
      echo "$file:$line_no: $target (missing heading)"
      status=1
    fi
  done < <(links_of "$file")
  return "$status"
}

#######################################
# Prints an error and exits with status 2.
# Arguments:
#   $1  message
# Example:
#   fail_to_run "missing: not a directory"
#######################################
fail_to_run() {
  echo "check-links: $1" >&2
  exit 2
}

#######################################
# Lists the Markdown files to check under the current directory, sorted,
# one per line. Inside a git work tree, they are the files git lists,
# tracked or not, except those it ignores and tracked files deleted from
# the working tree; outside one, every Markdown file except those in .git/.
# Exits with status 2 when git fails for any reason other than the
# directory not being in a repository, such as "dubious ownership".
# Arguments:
#   $1  directory for git's output and errors
# Outputs:
#   one path per line, relative to the current directory, on stdout
# Example:
#   markdown_files "$work_dir" >"$work_dir/list"
#######################################
markdown_files() {
  local dir=$1 file
  if LC_ALL=C git rev-parse --is-inside-work-tree >/dev/null 2>"$dir/git-error"; then
    LC_ALL=C git ls-files -z --cached --others --exclude-standard -- '*.md' \
      >"$dir/git-files" 2>"$dir/git-error" \
      || fail_to_run "git cannot list the files: $(cat "$dir/git-error")"
    while IFS= read -r -d '' file; do
      if [[ -f $file ]]; then printf '%s\n' "$file"; fi
    done <"$dir/git-files"
  elif grep -q 'not a git repository' "$dir/git-error"; then
    find . -name '*.md' -not -path './.git/*' | sed 's#^\./##'
  else
    fail_to_run "git cannot tell whether this is a repository: $(cat "$dir/git-error")"
  fi | LC_ALL=C sort -u
}

#######################################
# Checks every Markdown file under ROOT that markdown_files lists.
# Arguments:
#   $1  directory to check; defaults to the current directory
# Outputs:
#   the broken links, or a success line, on stdout
# Returns:
#   0 when every link resolves, 1 otherwise; exits with 2 when the check
#   cannot run
# Example:
#   main .
#######################################
main() {
  (($# <= 1)) || fail_to_run "usage: scripts/check-links.sh [ROOT]"
  local root=${1:-.} status=0 file work_dir
  [[ -d $root ]] || fail_to_run "$root: not a directory"
  cd "$root"
  work_dir=$(mktemp -d "${TMPDIR:-/tmp}/check-links.XXXXXX")
  # Expanded now: work_dir is local to main and gone when the EXIT trap runs.
  trap "rm -rf $(printf '%q' "$work_dir")" EXIT
  markdown_files "$work_dir" >"$work_dir/list" || exit 2
  [[ -s $work_dir/list ]] || fail_to_run "no Markdown file found"
  while IFS= read -r file; do
    check_file "$file" || status=1
  done <"$work_dir/list"
  if ((status == 0)); then
    echo "All relative links resolve."
  fi
  return "$status"
}

main "$@"
