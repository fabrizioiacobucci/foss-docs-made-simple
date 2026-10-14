#!/usr/bin/env bash
# Tests of scripts/check-links.sh, through its command line.
# Usage: scripts/tests/check-links.test.sh

source "$(dirname "$0")/helpers.sh"

test_passes_when_every_link_resolves() {
  write docs/guide.md <<'EOF'
# Guide

## Getting started
EOF
  write README.md <<'EOF'
# Project

See [the guide](docs/guide.md), [getting started](docs/guide.md#getting-started) and [this page](#project).
EOF
  run_check check-links.sh
  assert_status 0
  assert_stdout_has "All relative links resolve."
}

test_reports_a_link_to_a_missing_file() {
  write README.md <<'EOF'
# Project

See [the guide](docs/missing.md).
EOF
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:3: docs/missing.md (missing file, or different letter case)"
}

test_reports_a_link_with_a_different_letter_case() {
  write docs/guide.md <<<'# Guide'
  write README.md <<<'See [the guide](Docs/Guide.md).'
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:1: Docs/Guide.md (missing file, or different letter case)"
}

test_reports_a_link_to_a_missing_heading() {
  write docs/guide.md <<<'# Guide'
  write README.md <<<'See [installing](docs/guide.md#installing).'
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:1: docs/guide.md#installing (missing heading)"
}

test_resolves_anchors_as_github_generates_them() {
  write docs/guide.md <<'EOF'
# Guide

## What's new? (2026)
## Perché così
## Closed heading ##
## See [the README](../README.md) first
## Notes
## Notes
   ### Indented heading
EOF
  write README.md <<'EOF'
- [a](docs/guide.md#whats-new-2026)
- [b](docs/guide.md#perché-così)
- [c](docs/guide.md#closed-heading)
- [d](docs/guide.md#see-the-readme-first)
- [e](docs/guide.md#notes)
- [f](docs/guide.md#notes-1)
- [g](docs/guide.md#indented-heading)
EOF
  run_check check-links.sh
  assert_status 0
}

test_ignores_headings_inside_fenced_code() {
  write docs/guide.md <<'EOF'
# Guide

```
# Not a heading
```

## After the code
EOF
  write README.md <<'EOF'
See [it](docs/guide.md#not-a-heading).
See [after](docs/guide.md#after-the-code).
EOF
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:1: docs/guide.md#not-a-heading (missing heading)"
  assert_stdout_lacks "after-the-code"
}

test_ignores_links_inside_code_and_checks_those_after_it() {
  write README.md <<'EOF'
```
[a](missing-a.md)
~~~
[b](missing-b.md)
```
~~~
[c](missing-c.md)
```
[d](missing-d.md)
~~~
  ```
[e](missing-e.md)
  ```
Inline `[f](missing-f.md)` and ``[g](missing-g.md)`` code, then [h](missing-h.md).
[i](missing-i.md)
EOF
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:14: missing-h.md"
  assert_stdout_has "README.md:15: missing-i.md"
  local name
  for name in a b c d e f g; do
    assert_stdout_lacks "missing-$name.md"
  done
}

test_ignores_links_with_a_scheme() {
  write README.md <<'EOF'
- [a](https://example.org/missing.md)
- [b](HTTP://example.org/missing.md)
- [c](mailto:someone@example.org)
- [d](//example.org/missing.md)
- [e](ftp://example.org/missing.md)
- [f](missing.md)
EOF
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:6: missing.md"
  assert_stdout_lacks "example.org"
}

test_checks_only_the_file_when_the_anchor_is_not_on_markdown() {
  write scripts/run.sh <<<'echo run'
  write README.md <<'EOF'
- [line](scripts/run.sh#L1)
- [folder](scripts/#top)
EOF
  run_check check-links.sh
  assert_status 0
}

test_checks_link_reference_definitions() {
  write docs/guide.md <<<'# Guide'
  write README.md <<'EOF'
[guide]: docs/guide.md "The guide"
   [angled]: <docs/guide.md>
[missing]: docs/missing.md
EOF
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "README.md:3: docs/missing.md (missing file, or different letter case)"
}

test_resolves_encoded_angled_titled_and_query_targets() {
  write "docs/my guide.md" <<<'# My guide'
  write docs/café.md <<<'# Café'
  write README.md <<'EOF'
- [accented](docs/caf%C3%A9.md#café)
- [a](docs/my%20guide.md)
- [b](<docs/my guide.md>)
- [c](docs/my%20guide.md?plain=1#my-guide)
- [d](docs/my%20guide.md "Title")
EOF
  run_check check-links.sh
  assert_status 0
}

test_resolves_links_from_the_linking_file_or_from_the_root() {
  write docs/a.md <<'EOF'
- [up](../README.md)
- [sibling](b.md)
- [root](/docs/b.md)
EOF
  write docs/b.md <<<'# B'
  write README.md <<<'# Project'
  run_check check-links.sh
  assert_status 0
}

test_reports_a_path_written_from_the_root_without_a_slash() {
  write docs/a.md <<<'[readme](README.md)'
  write README.md <<<'# Project'
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "docs/a.md:1: README.md (missing file, or different letter case)"
}

test_skips_the_git_directory() {
  write .git/notes.md <<<'[gone](missing.md)'
  write legacy/old.md <<<'[gone](missing.md)'
  run_check check-links.sh
  assert_status 1
  assert_stdout_has "legacy/old.md:1: missing.md"
  assert_stdout_lacks ".git/"
}

test_ignores_carriage_returns() {
  printf '# Project\r\n\r\n## Next steps ##\r\n\r\n[next](#next-steps)\r\n[self]: README.md\r\n' >README.md
  run_check check-links.sh
  assert_status 0
}

test_checks_the_given_root() {
  write README.md <<<'[gone](missing.md)'
  write site/README.md <<<'# Site'
  run_check check-links.sh site
  assert_status 0
}

test_cannot_run_when_the_root_is_not_a_directory() {
  run_check check-links.sh missing
  assert_status 2
  assert_stderr_has "missing: not a directory"
}

test_cannot_run_with_more_than_one_argument() {
  run_check check-links.sh one two
  assert_status 2
  assert_stderr_has "usage: scripts/check-links.sh [ROOT]"
}

run_tests
