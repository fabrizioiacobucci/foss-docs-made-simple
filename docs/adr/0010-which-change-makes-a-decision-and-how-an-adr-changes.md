---
status: accepted
date: 2026-11-03
decision-makers: "@fabrizioiacobucci"
---

# Define which change makes a decision, and how an accepted ADR changes

## Context and Problem Statement

[DEFINITION-OF-DONE](../../framework/DEFINITION-OF-DONE.md) asks that "a change that makes a significant architectural decision" include its ADR, and the framework's [CONVENTIONS](../../framework/CONVENTIONS.md#adrs) asks adopters to follow the templates of [MADR 4.0.0](https://github.com/adr/madr/releases/tag/4.0.0), but no framework document says which change makes a decision, nor whether an accepted ADR may be edited. The pilot adopter set an ADR to `accepted` before carrying it out, later added consequences to it, and asked whether `accepted` should be set by the change that carries the decision out ([#12](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/12)) and whether an accepted ADR may be supplemented ([#14](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/14)). [Nygard 2011](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions), whom the GLOSSARY cites, says: "A decision may be "proposed" if the project stakeholders haven't agreed with it yet, or "accepted" once it is agreed", and "If a decision is reversed, we will keep the old one around, but mark it as superseded"; he says nothing about editing an accepted ADR. MADR makes its metadata optional, its minimal templates have none, and its `date` is "when the decision was last updated". How are these written in the framework, including for ADRs without a `status` field?

## Considered Options

* `accepted` means agreed, as in Nygard; an accepted ADR may be supplemented or corrected while its options stay the same; a changed decision gets a new ADR that supersedes the earlier one
* `accepted` set by the change that carries out the decision
* `date` fixed at the date of acceptance
* Only a reference to MADR and Nygard
* Never editing an accepted ADR, with a new ADR for each new consequence

## Decision Outcome

Chosen option: "`accepted` means agreed, as in Nygard; an accepted ADR may be supplemented or corrected while its options stay the same; a changed decision gets a new ADR that supersedes the earlier one", because it keeps the meaning that the cited source gives the status, works when several changes carry out one decision or one change carries out several, and lets a mistake be corrected without a new decision.

CONVENTIONS, "ADRs", states:

- an ADR is `accepted` once its decision is agreed, and an ADR without a `status` field records an agreed decision; for an ADR written when its decision is made, the change that sets it to `accepted`, or that adds it without a `status` field, makes the decision;
- with `MAY`: committing an ADR as `proposed`, adding MADR's `status` field to a template without metadata for that, carrying out a decision in later changes named in "Confirmation", and supplementing or correcting an accepted ADR, or one without status, while its chosen and considered options stay the same;
- `date` as MADR defines it;
- with `SUGGESTED`: a note in "More Information" with the date and reason of each supplement or correction, since a reader of the ADR does not read the git history; it is not stronger because no source and no adopter case asks for more, and `date` already records the last update;
- with `SHOULD`: an ADR written after its decision says so, and gives the date of the decision, in "More Information", so that the scope in time of [ADR 0009](0009-no-adrs-required-for-decisions-before-adoption.md) can be applied to it;
- with `SHOULD`: an ADR that a later one supersedes is marked as superseded, with a link to it, in its `status` field or, without one, in a line at its top, as Nygard asks for every reversed decision. A changed decision is a new decision, whose ADR DEFINITION-OF-DONE already asks for, so the rule adds only the mark and the link.

The `MAY` and `SUGGESTED` rules are minor changes; the two `SHOULD` rules are new rules, so changes that would be major, and the release notes mark them.

### Consequences

* Good, because adopters using the minimal templates know what their ADRs record.
* Good, because a correction keeps one record for one decision.
* Bad, because adopters that edited accepted ADRs without noting it, or that marked no superseded ADR, must start doing so, or log an exception.
* Bad, because the acceptance date of an ADR is read from the history of the change that set it, not from `date`.

### Confirmation

This repository's ADRs follow the rules: ADRs 0001 and 0002, written after their decisions, give the date of the decision in "More Information", and their `date` is the date of their last update.

## Pros and Cons of the Options

### `accepted` set by the change that carries out the decision

* Bad, because it redefines a status that Nygard defines.
* Bad, because it is ambiguous when several changes, or one change for several ADRs, carry out a decision.
* Bad, because it sets `accepted` before the effects are known, which in the pilot led to consequences being added afterwards.

### `date` fixed at the date of acceptance

* Bad, because it departs from MADR, so it would need a rule of its own.

### Only a reference to MADR and Nygard

* Bad, because neither says when an accepted ADR may be edited, or which change makes the decision.

### Never editing an accepted ADR, with a new ADR for each new consequence

* Bad, because a new ADR without a new decision goes against one record for one decision.
* Bad, because every correction of a mistake would become a new ADR.
