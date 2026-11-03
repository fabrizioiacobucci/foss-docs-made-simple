---
status: accepted
date: 2026-11-03
decision-makers: "@fabrizioiacobucci"
---

# Let copies differ only where the rendered document stays the same

## Context and Problem Statement

[DOCUMENTS-INDEX](../../framework/DOCUMENTS-INDEX.md) asks adopters for a copy of [CHECKLIST](../../framework/CHECKLIST.md) and of [DEFINITION-OF-DONE](../../framework/DEFINITION-OF-DONE.md) at the adopted framework tag, but no framework document says what "copy" means. [REFERENCE](../REFERENCE.md) defines the form of the copied files as their sections, the columns of their tables and the status values of the register, not their whitespace. In the pilot adopter, Prettier padded the tables of the `CHECKLIST` and re-indented its nested list, and `scripts/check-copies.sh`, which compared lines, reported the copy as different although it rendered the same ([#7](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/7)). Adopters format their files with different tools and settings. What may a copy change, and how does the check tell it apart from a changed text?

## Considered Options

* A rule that a copy may differ only where the rendered document stays the same, with a closed list of cases, and a check that compares words
* Exact copies, with advice to exclude them from formatters, and nothing else
* Framework documents already in the layout of one formatter
* Formatter-ignore markers in the framework documents
* A closed list without list indentation, with the `CHECKLIST` status list made flat

## Decision Outcome

Chosen option: "A rule that a copy may differ only where the rendered document stays the same, with a closed list of cases, and a check that compares words", because it leaves adopters free to format their files, ties the framework to no tool, and lets the list grow only with cases that adopters report, as the "Nothing ahead of need" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) asks.

- DOCUMENTS-INDEX, "Files", states the rule once, with `MAY`, and the rows of `CHECKLIST` and `DEFINITION-OF-DONE` cite it. The cases are the spaces around the content of table cells, the number of hyphens and spaces in the separator row of a table, the indentation of list items as long as their nesting stays the same, and line breaks inside a paragraph or a list item. Alignment colons in a separator row are not among them, since they change the rendering.
- `scripts/check-copies.sh` blanks the filled-in values line by line, as before, and then compares the two documents as lists of words. It squeezes whitespace, removes the spaces around `|` in table rows, reduces the hyphens of separator rows, and keeps a mark where a block starts: after a blank line, or at a list item, heading, table row or quote, which can interrupt a paragraph. Equality and the diff it shows use the same word lists.
- Removing all whitespace instead was rejected: it erased word boundaries, so `##Register` matched `## Register` and an invalid status then passed the value check, and it let a link definition joined to the paragraph before, or a list item merged into the one before, pass.
- The rule is made weaker, so the change is minor. A script from a newer tag also applies the tolerance to copies of earlier tags: this is how the tool behaves, not a rule of those tags.

### Consequences

* Good, because a copy formatted by Prettier, with `tabWidth` 2 or 4, or re-wrapped with `proseWrap: always`, matches.
* Good, because adopters who prefer exact copies can still exclude them from their formatters, as the README advises.
* Bad, because two cases are not detected, though the rule does not allow them: a nested list made flat, and a code block made by indentation. They are stated at the top of the script and in arc42 section 8.
* Bad, because the diff is shown on word lists, which are less easy to read than lines.

### Confirmation

The tests in `scripts/tests/` cover copies in Prettier's layout with `tabWidth` 2 and 4, a re-wrapped copy, and copies that must fail: `##Register` with an invalid status, a link definition joined to the paragraph before, a list item merged into the one before, and one changed word.

## Pros and Cons of the Options

### Exact copies, with advice to exclude them from formatters, and nothing else

* Good, because the check stays a plain comparison of lines.
* Bad, because every adopter with a formatter falls into the trap at least once, and each formatter is excluded differently.

### Framework documents already in the layout of one formatter

* Bad, because the padding of a table depends on the rows filled in, and the indentation on each project's `tabWidth`.

### Formatter-ignore markers in the framework documents

* Bad, because markers such as `<!-- prettier-ignore-start -->` tie the framework to one tool.

### A closed list without list indentation, with the `CHECKLIST` status list made flat

* Bad, because it needs a change to the framework text, and gives adopters less freedom than the chosen rule for the same amount of code.
