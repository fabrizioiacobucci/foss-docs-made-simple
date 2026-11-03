---
status: accepted
date: 2026-11-03
decision-makers: "@fabrizioiacobucci"
---

# Check adopters' copies and links from a clone of the framework

## Context and Problem Statement

An adopter copies [CHECKLIST](../../framework/CHECKLIST.md) and [DEFINITION-OF-DONE](../../framework/DEFINITION-OF-DONE.md) at its framework tag, and its project documents link to each other. The pilot adopter's copies drifted without anyone editing them on purpose, and its README listed files before they existed ([#6](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/6), [#10](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/10), [#13](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/13)). `scripts/check-copies.sh` worked only on this repository: it read the tag from a sentence only this README contains, looked the tag up in the checked repository or its `origin`, which for an adopter are the adopter's own, fell back to a `framework/` folder that adopters do not have, and read the copies from fixed paths. `scripts/check-links.sh` read every Markdown file, `node_modules/` included. The typical error to catch is a move to a newer tag that updates the tag in the links but not the text, so a check that only detects edits made after copying is not enough. How does an adopter check its copies against the framework documents at its tag, and see a diff when they differ?

## Considered Options

* A clone of the framework as the reference, from which the scripts are run
* A table of per-tag checksums in the script
* A checksum in a frontmatter of the copies
* The normalised texts of each tag embedded in the script
* A shallow clone of the framework made by the script at each run
* `DEFINITION-OF-DONE` linked instead of copied
* No tool

## Decision Outcome

Chosen option: "A clone of the framework as the reference, from which the scripts are run", because it shows a diff against the exact text of the declared tag, needs no step at each release, keeps the scripts free of network access, and puts nothing in the adopter's repository that could age there.

- The adopter clones the framework, preferably at its latest framework tag, and runs `<clone>/scripts/check-copies.sh` and `<clone>/scripts/check-links.sh` against its own repository, locally or in continuous integration. A script from a newer tag checks copies of any earlier tag.
- `check-copies.sh` reads the framework documents with `git show` at the declared tag in the clone it belongs to, or in the clone given with `--framework`; it never looks up tags in the checked repository or its `origin`. A tag missing from the clone is an error that asks to fetch the tags. Only when the checked repository is the clone itself, and the tag does not exist yet, as before a framework release, is `framework/` in its working tree the reference, with a warning.
- It reads the tag from the README in the root, `.github/` or `docs/`, as GitHub does, from exactly one statement outside fenced code in the form "framework tag \`vMAJOR.MINOR.PATCH\`". That form is a requirement of the tool, stated at the top of the script and in the README, not a framework rule: [DOCUMENTS-INDEX](../../framework/DOCUMENTS-INDEX.md) asks the README only for the framework tag the adopter follows.
- It reads the copies from `docs/`, or from the directory given with `--docs`.
- `check-links.sh` lists the files from git inside a repository, so that every ignored path is skipped, and stops when git fails there instead of falling back silently.
- The scripts' command line, options and exit statuses become external interface, outside the public API ([REFERENCE](../REFERENCE.md)), so their changes are a patch and are listed in [CHANGELOG](../CHANGELOG.md).

### Consequences

* Good, because the diff names what differs from the declared tag, including links that point at another tag.
* Good, because adopters at v0.1.0 and v0.2.0 can use it with no change to their documents.
* Good, because the tests stay offline, with fixture repositories that hold tags.
* Bad, because an adopter needs a clone of the framework, and the network to make or update it.
* Bad, because both copies must be in one directory, while DOCUMENTS-INDEX lets an adopter place them separately; this is stated as a known gap.
* Bad, because a README must state the tag in the form the script reads.

### Confirmation

The tests in `scripts/tests/` cover an adopter checked from a clone, copies of an earlier tag than the latest, `--framework`, `--docs`, a README in `.github/` or `docs/`, a tag in fenced code, two tags, a tag missing from the clone, and the framework repository before its tag. Before the change was merged, both scripts were run on the pilot adopter's repository, at framework tag v0.2.0, and passed.

## Pros and Cons of the Options

### A table of per-tag checksums in the script

* Good, because it works offline, with no clone.
* Bad, because it shows no diff, only that a copy differs.
* Bad, because each release needs a step to add its checksums, and a run of the checks on tags, which continuous integration does not have.

### A checksum in a frontmatter of the copies

* Bad, because it only proves that a copy agrees with its own checksum, not that it is the text of the declared tag: a v0.1.0 body with its own checksum passes as v0.2.0.
* Bad, because it changes the form of the copied files, a major change, and adopters at v0.1.0 and v0.2.0 could not use it.

### The normalised texts of each tag embedded in the script

* Good, because it works offline and can show a diff.
* Bad, because the script grows with each tag, and holds a second copy of every framework document, which can drift from the tags.

### A shallow clone of the framework made by the script at each run

* Good, because the adopter needs no clone of its own.
* Bad, because the script then needs the network at each run, and so would its tests.

### `DEFINITION-OF-DONE` linked instead of copied

* Good, because it leaves less text to drift.
* Bad, because contributors read the `DEFINITION-OF-DONE` at each change, and a copy in the repository keeps it at hand; `GOVERNANCE`, which is read rarely, is linked for that reason.

### No tool

* Good, because there is nothing to maintain.
* Bad, because a statement such as "do not edit" does not detect an edit, and the pilot's copies drifted without anyone editing them on purpose.

## More Information

Two other options were considered and set aside:

* **A structured record of the adoption data**, such as the tag and the paths of the copies, in a file the scripts read. It is deferred: the README statement covers today's case. If a second adopter shows that it is not enough, the cheapest form would be a `Framework tag: ` line in the `CHECKLIST`.
* **Checking the file names written in inline code**, as the pilot's README listed files before they existed. It is rejected: inline code also holds commands, document ids and folders, and there is no rule for where a path resolves from. The framework documents themselves cite in code adopter files that do not exist in this repository, such as `CODE_OF_CONDUCT.md`. The pilot's case came from copying this repository's README, which the README's examples now address. The residual risk is accepted and listed among the known gaps of arc42 section 8; if an adopter reports the case again, it is reconsidered.
