---
status: accepted
date: 2026-10-14
decision-makers: "@fabrizioiacobucci"
---

# Keep the framework documents in `framework/`, so that `docs/` follows the default layout

## Context and Problem Statement

The framework's default layout puts an adopter's project documents in `docs/`, its arc42 sections in `docs/architecture/` and its ADRs in `docs/adr/`, apart from the files that tools read from the root ([DOCUMENTS-INDEX](../../framework/DOCUMENTS-INDEX.md)). This repository is both the framework and an adopter of it, and its framework documents were in `docs/`. Where do the framework documents go, so that the repository can keep its own project documents where the framework says they go by default?

## Considered Options

* Keep the framework documents in `docs/`
* Move the framework documents to `src/`
* Move the framework documents to `framework/`

## Decision Outcome

Chosen option: "Move the framework documents to `framework/`", because `docs/` then keeps the meaning that the framework gives it, so this repository shows adopters the default layout, and the folder's name says what it holds.

With the same decision, `CHANGELOG` and `ROADMAP` moved from the root to `docs/`, while `README`, `CONTRIBUTING`, `SECURITY` and `LICENSE` stayed in the root.

### Consequences

* Good, because this repository is an example of the default layout, which adopters can compare with theirs.
* Good, because the copies in `docs/` and the framework documents they copy are told apart by their folder, which `scripts/check-copies.sh` relies on.
* Good, because the move was made before the first framework tag, so no adopter's link broke.
* Bad, because the path of each framework document is part of the public API ([`REFERENCE`](../REFERENCE.md#public-api)), so moving them again would be a major change.

## Pros and Cons of the Options

### Keep the framework documents in `docs/`

* Good, because nothing moves.
* Bad, because this repository's project documents would leave the default layout, and its `docs/` would mix the documents adopters read with its own records.

### Move the framework documents to `src/`

* Good, because `src/` is a common name for what a repository is made from.
* Bad, because `src/` usually holds source code, which the framework documents are not.

## More Information

This ADR was written on 2026-10-14, the day of the decision. The maintainer named `src/` as an option and asked whether it was too tied to code.
