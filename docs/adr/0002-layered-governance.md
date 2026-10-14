---
status: accepted
date: 2026-10-13
decision-makers: "@fabrizioiacobucci"
---

# Layer the governance: framework rules by link, project data in the project `GOVERNANCE` from passing

## Context and Problem Statement

The framework's [GOVERNANCE](../../framework/GOVERNANCE.md) says who does what for the project documents: two roles, the events to record and the periodic checks. These rules apply from passing, while the badge asks for a governance document only from silver: how the project decides, its key roles and who holds them, and how it continues if a person leaves. At every level an adopter also has to name who holds the framework roles and to list its additions. Where does each of these live, without stating a rule twice or moving data when the level changes?

## Considered Options

* Copy the framework's GOVERNANCE into the project
* Restate the framework rules in the project `GOVERNANCE`
* Two layers, the project `GOVERNANCE` from passing
* Two layers, the project `GOVERNANCE` from silver

In both layered options the framework's GOVERNANCE, read at the adopted framework tag, holds the rules, and the project `GOVERNANCE` holds the project's data: the role holders, a "Documentation" section that links the framework's GOVERNANCE and lists the additions and, from silver, what the badge asks.

## Decision Outcome

Chosen option: "Two layers, the project `GOVERNANCE` from passing", because each rule stays in one framework document, the project document holds only the project's data, and nothing moves between documents when the level changes.

### Consequences

* Good, because a new framework tag reaches the adopter's governance rules through the tag, with no text to merge.
* Good, because the role holders and the additions have one place at every level ([DOCUMENTS-INDEX](../../framework/DOCUMENTS-INDEX.md)).
* Bad, because at passing an adopter writes one document more than the badge asks; DOCUMENTS-INDEX states the reason.
* Bad, because two documents are called governance; framework documents cite the project document by the id `GOVERNANCE`, in code format, and the framework's by its name, as the "Citations" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) says, so that a reader can tell them apart.

## Pros and Cons of the Options

### Copy the framework's GOVERNANCE into the project

* Good, because the rules are in the adopter's repository, where its contributors read them.
* Bad, because the copy would mix framework rules with the project's own data, so a new framework tag could not replace it whole, as it replaces `DEFINITION-OF-DONE`, which holds only framework text; nor carry its data over a fixed form, as for `CHECKLIST`; each move to a new tag would be a merge by hand.

### Restate the framework rules in the project `GOVERNANCE`

* Good, because a reader finds the rules and the project's data in one document.
* Bad, because each rule would be stated twice, and the restated text would drift from the framework at every new tag.

### Two layers, the project `GOVERNANCE` from silver

* Good, because at passing it asks no more than the badge.
* Bad, because at passing the role holders and the additions would be in the `CHECKLIST` and its log, and would move to the project `GOVERNANCE` when the level is raised, and back when it is lowered.

## More Information

This repository's own project `GOVERNANCE` is [docs/GOVERNANCE.md](../GOVERNANCE.md).

This ADR was written on 2026-10-14, after the decision. The layers were first decided on 2026-10-13 with the project `GOVERNANCE` from silver, and changed the same day to start from passing. The first two options were added when this ADR was written: the previous framework already said that its GOVERNANCE is never copied, and a review found a draft of this repository's `GOVERNANCE` restating rules.
