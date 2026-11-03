# Changelog

All notable changes to the framework, by framework tag. The format follows [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/), and the framework tags follow [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2026-11-03

This release would be major: it adds two rules stated with `SHOULD`, and arc42 section 8 must hold more at passing. Before `1.0.0`, it increments the minor number. The form of the [CHECKLIST](../framework/CHECKLIST.md) (its sections, table columns and status values) is unchanged, so an adopter that moves to this tag copies the new `CHECKLIST` and carries over its level, register and log as they are.

### Added

- In [CONVENTIONS](../framework/CONVENTIONS.md#adrs), how an ADR records a decision and how it changes. An ADR is `accepted` once its decision is agreed, and an ADR without a `status` field records an agreed decision; the change that sets it to `accepted`, or adds it without status, makes the decision. Rules added with `MAY`: committing an ADR as `proposed`, also by adding MADR's `status` field to a template without metadata; carrying out a decision in later changes, named in "Confirmation"; supplementing or correcting an accepted ADR, or one without status, while its chosen and considered options stay the same. Rule added with `SUGGESTED`: a dated note in "More Information" for each supplement or correction. `date` is the date of the last update, as MADR defines it.
- In [CONVENTIONS](../framework/CONVENTIONS.md#adrs), two rules stated with `SHOULD`. **These changes would be major**: an ADR written after its decision says so, and gives the date of the decision, in "More Information"; an ADR that a later one supersedes is marked as superseded, with a link to it. An adopter that does not follow them logs an exception in its `CHECKLIST`, as [GOVERNANCE](../framework/GOVERNANCE.md#records) says.
- In [CONVENTIONS](../framework/CONVENTIONS.md#requirements), a rule added with `SUGGESTED`: an adopter that writes requirements with BCP 14 keywords states once, in its `README` or in a project document its `README` links, that they and `SUGGESTED` carry the meanings of the framework's [GLOSSARY](../framework/GLOSSARY.md), linked at its framework tag.
- In the [README](../README.md#adopting-the-framework), examples for the adoption steps: a project `GOVERNANCE` for passing, and `README` lines that state where the project documents are and the framework tag; that this repository's own texts are not starting texts; how a project can keep a glossary; and how to exclude the copies from a formatter.
- The check scripts, as external interface outside the public API ([REFERENCE](REFERENCE.md#external-interface)). From this tag, an adopter runs them from a full clone of this repository against its own repository, locally or in continuous integration, as the README's ["Checking the project documents"](../README.md#checking-the-project-documents) says: `scripts/check-copies.sh [--framework DIR] [--docs DIR] [ROOT]` compares the copies with the framework documents at the tag the `README` states, which it reads only in the form "framework tag \`vMAJOR.MINOR.PATCH\`", and `scripts/check-links.sh [ROOT]` checks the relative links. The scripts of earlier tags work only on this repository.

### Changed

- In [DOCUMENTS-INDEX](../framework/DOCUMENTS-INDEX.md#passing), arc42 section 8 at passing must hold more: how the software is built, and how it is deployed or released, for example published as a package. **This change would be major**: an adopter that releases software, such as a package, and has not described how, sets arc42 section 8 to `draft` until it does, as GOVERNANCE says for a move to a newer framework tag.
- In [DOCUMENTS-INDEX](../framework/DOCUMENTS-INDEX.md#files), a rule made weaker: a copy of a framework document may differ from it where the rendered document stays the same, that is in the spaces around table cells, the separators of tables, the indentation of list items that keeps their nesting, and line breaks inside a paragraph or a list item. The `scripts/check-copies.sh` of this tag also applies this tolerance to copies of earlier tags: this is how the tool behaves, not a rule of those tags.
- In [DOCUMENTS-INDEX](../framework/DOCUMENTS-INDEX.md#passing), a rule made weaker: ADRs are required for the decisions made since the adopter first recorded its level in its `CHECKLIST`, and an adopter may write ADRs of earlier decisions. Release notes stay required for every release, those made before adoption included, as the badge criterion `release_notes` asks: an adopter whose earlier releases have none writes them, or logs an exception.
- In [GLOSSARY](../framework/GLOSSARY.md#requirements-and-quality), the entry "BCP 14 keywords" says that the framework and its adopters use these meanings beyond the use that RFC 2119, section 6, advises for IETF documents. The meaning of the term is unchanged, and no rule gains or loses scope.
- In the [CHECKLIST](../framework/CHECKLIST.md#level), the level is written after `Level: `, and a sentence lists the three values, instead of a placeholder in italics. Two clarifications restate what the definitions already imply: only a review of the whole document sets the Reviewed date, and a document marked `active` that is found not to hold what the level requires is `draft`. No rule changes.

### Fixed

- `scripts/check-links.sh` lists the files from git in a repository, so that ignored paths such as `node_modules/` are skipped, skips tracked files deleted from the working tree, and stops when git fails or when no Markdown file is found.
- `scripts/check-copies.sh` checks a level line left without its trailing space, and says that the level is written without emphasis.

## [0.2.0] - 2026-10-25

### Added

- In [DEFINITION-OF-DONE](../framework/DEFINITION-OF-DONE.md#changes), which decisions an adopter SHOULD treat as significant architectural decisions, and so document in an ADR included in the change: those that affect the structure, the quality characteristics, the dependencies, the interfaces or the construction techniques of the software. This change would be major: an adopter that judges significance in another way logs an exception in its `CHECKLIST`, as [GOVERNANCE](../framework/GOVERNANCE.md#records) says. The rule applies to the changes made after the move to the new framework tag, and asks for no ADR of past decisions.
- In the [README](../README.md#adopting-the-framework), how an adopter reports a need, or an exception it has logged, to the maintainers.

## [0.1.0] - 2026-10-14

### Added

- The framework documents, which set the project documents of the three levels of the [OpenSSF Best Practices Badge](https://www.bestpractices.dev/en/criteria) and the rules around them: [GLOSSARY](../framework/GLOSSARY.md), [CONVENTIONS](../framework/CONVENTIONS.md), [LICENSE-POLICY](../framework/LICENSE-POLICY.md), [DOCUMENTS-INDEX](../framework/DOCUMENTS-INDEX.md), [DEFINITION-OF-DONE](../framework/DEFINITION-OF-DONE.md), [CHECKLIST](../framework/CHECKLIST.md), [GOVERNANCE](../framework/GOVERNANCE.md) and [BADGE-MAP](../framework/BADGE-MAP.md).
- The steps to adopt the framework and to choose a level, in the [README](../README.md#adopting-the-framework).

[Unreleased]: https://github.com/fabrizioiacobucci/foss-docs-made-simple/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/fabrizioiacobucci/foss-docs-made-simple/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/fabrizioiacobucci/foss-docs-made-simple/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/fabrizioiacobucci/foss-docs-made-simple/releases/tag/v0.1.0
