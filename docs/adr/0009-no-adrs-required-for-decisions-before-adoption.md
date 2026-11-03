---
status: accepted
date: 2026-11-03
decision-makers: "@fabrizioiacobucci"
---

# Exempt ADRs of decisions made before adoption

## Context and Problem Statement

[DOCUMENTS-INDEX](../../framework/DOCUMENTS-INDEX.md) asked, in the row of arc42 section 9, for "one ADR per significant architectural decision, written when the decision is made". Read literally, this includes decisions made before the adopter adopted the framework. Only [ADR 0006](0006-adr-triggers-as-should.md) and the release notes of v0.2.0 said that the framework "asks for no ADR of past decisions", and neither is part of the public API. The pilot adopter wrote no ADR for its past decisions, said so in its arc42 section 9, and logged no exception ([#11](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/11)). It also asked the same question for release notes of releases made before adoption ([#15](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/15)). Are records that arise from an event, an ADR from a decision or release notes from a release, required for events before adoption?

## Considered Options

* Exempt ADRs of decisions made before adoption, in the row of arc42 section 9, with `MAY` for writing them
* One sentence that exempts both ADRs and release notes from before adoption
* A general rule that every rule applying at each change or release applies from adoption on
* A clarification without keywords, moving the v0.2.0 sentence into the row
* Also requiring, with `SHOULD`, that section 9 state which decisions have no ADR

## Decision Outcome

Chosen option: "Exempt ADRs of decisions made before adoption, in the row of arc42 section 9, with `MAY` for writing them", because the badge does not ask for ADRs ([BADGE-MAP](../../framework/BADGE-MAP.md#not-asked-by-the-badge)), so the framework is free to set their scope, while it is not free to do so for release notes.

- **Adoption** is the change that first records the level in the adopter's `CHECKLIST`, the first event of the framework's [GOVERNANCE](../../framework/GOVERNANCE.md#events). It is not the same event as a move to a newer framework tag, which ADR 0006 and the v0.2.0 release notes speak of: a rule added by a tag applies to the changes made after the move to that tag, while this exemption concerns the decisions made before the first adoption. The two are kept apart, and ADR 0006 is unchanged.
- What counts for an ADR is the date of its decision: for an ADR written when the decision is made, the change that makes it, as the framework's [CONVENTIONS](../../framework/CONVENTIONS.md#adrs) defines it; for one written afterwards, the date it gives in "More Information".
- **Release notes are not exempt.** The badge criterion `release_notes` reads: "The project MUST provide, in each release, release notes that are a human-readable summary of major changes in that release…", and allows "N/A" only for software not intended for reuse that is delivered continuously. Under the "Badge strength" and "Sources" rules of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework), the framework cannot exempt releases made before adoption. An adopter whose earlier releases have no notes writes them, as a short human-readable summary of each release, or logs an exception in its `CHECKLIST`, as GOVERNANCE provides for any rule it does not follow. No new rule is needed.
- **Laws and standards.** The exemption is limited to ADRs. It is not a general rule that rules apply from adoption on. Each future rule taken from a law or a standard, such as those [ROADMAP](../ROADMAP.md) plans, states its own scope in time, as its source sets it, in the framework document that holds it.
- The literal reading of a rule is made weaker, so the change is minor.

### Consequences

* Good, because adopters with a history no longer read a duty to document every past decision.
* Good, because the exemption sits in the row that states the rule, where adopters read it.
* Bad, because adopters with releases before adoption and no notes for them must write the notes or log an exception, as the pilot would for its releases 0.1.0 to 0.1.4.

### Confirmation

The row of arc42 section 9 in DOCUMENTS-INDEX states the exemption with `MAY`, and the release notes of the framework tag name the rule made weaker. This repository's ADRs 0001 to 0003, of decisions made before it followed the framework, stay as written.

## Pros and Cons of the Options

### One sentence that exempts both ADRs and release notes from before adoption

* Good, because one sentence answers both questions.
* Bad, because the badge criterion `release_notes` does not allow it.

### A general rule that every rule applying at each change or release applies from adoption on

* Bad, because it is wider than the need, it misreads rules computed on a release that contains earlier work, and it conflicts with badge criteria and with the rules that laws will set.

### A clarification without keywords, moving the v0.2.0 sentence into the row

* Good, because it would be a patch.
* Bad, because stating the scope of a rule changes how it reads, so it is not clearly a patch.

### Also requiring, with `SHOULD`, that section 9 state which decisions have no ADR

* Bad, because it would be a major change for a small benefit.
