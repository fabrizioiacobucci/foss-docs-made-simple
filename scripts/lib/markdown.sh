# Markdown helpers shared by the check scripts, which source this file.
# It defines functions only and runs nothing.

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
