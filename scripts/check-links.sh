#!/usr/bin/env bash
# Checks that every relative link in the Markdown files of this repository,
# except those in .git/,
# points to a file that exists, with the same letter case, and, when it has
# an anchor and the target is a Markdown file, to an ATX heading (# Title) of
# that file. Links with a scheme (https:, mailto:, ...) are not checked, nor
# are anchors on other files, setext headings or HTML anchors.
#
# Usage: scripts/check-links.sh [ROOT]
#   ROOT  repository root to check; defaults to the current directory.
# Exit status: 0 when every link resolves, 1 when at least one does not,
#   2 when the arguments are wrong or ROOT is not a directory.
# Example: scripts/check-links.sh && echo "links ok"

set -euo pipefail

#######################################
# Prints the lines of a Markdown file that are outside fenced code blocks
# (``` or ~~~, indented by up to three spaces), as "LINE<TAB>TEXT", with any
# carriage return removed.
# Arguments:
#   $1  path of the Markdown file
# Outputs:
#   one "LINE<TAB>TEXT" per line, on stdout
# Example:
#   markdown_text README.md | head -n 3
#######################################
markdown_text() {
  awk '
    {
      line = $0
      sub(/\r$/, "", line)
      if (match(line, /^(   |  | )?(```|~~~)/)) {
        marker = substr(line, RSTART + RLENGTH - 3, 3)
        if (fence == "") { fence = marker; next }
        if (marker == fence) { fence = ""; next }
      }
      if (fence == "") print NR "\t" line
    }
  ' "$1"
}

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
# Checks every Markdown file under ROOT, except .git/.
# Arguments:
#   $1  repository root; defaults to the current directory
# Outputs:
#   the broken links, or a success line, on stdout
# Returns:
#   0 when every link resolves, 1 otherwise; exits with 2 when ROOT is not
#   a directory
# Example:
#   main .
#######################################
main() {
  (($# <= 1)) || { echo "usage: scripts/check-links.sh [ROOT]" >&2; exit 2; }
  local root=${1:-.} status=0 file
  if [[ ! -d $root ]]; then
    echo "check-links: $root: not a directory" >&2
    exit 2
  fi
  cd "$root"
  while IFS= read -r file; do
    check_file "$file" || status=1
  done < <(find . -name '*.md' -not -path './.git/*' \
    | sed 's#^\./##' | sort)
  if ((status == 0)); then
    echo "All relative links resolve."
  fi
  return "$status"
}

main "$@"
