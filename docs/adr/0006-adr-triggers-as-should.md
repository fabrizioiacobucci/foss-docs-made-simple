---
status: accepted
date: 2026-10-18
decision-makers: "@fabrizioiacobucci"
---

# State when an architectural decision is significant, with `SHOULD`

## Context and Problem Statement

From passing, [DEFINITION-OF-DONE](../../framework/DEFINITION-OF-DONE.md#changes) requires an ADR for each significant architectural decision, a requirement that the badge does not set ([BADGE-MAP](../../framework/BADGE-MAP.md#not-asked-by-the-badge)). [GLOSSARY](../../framework/GLOSSARY.md) defines an ADR by citing Nygard, but no framework document says what makes a decision significant, so a rule stated with `MUST` depends on a judgement that each reader makes differently: a defect that the "Nothing ahead of need" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) counts as a need. Adopters come either without documentation rules of their own, and need a criterion ready to use, or with documentation that they adapt, and may already judge significance in their own way. How does an adopter know when the rule applies?

## Considered Options

* Suggest the cases with `SUGGESTED`
* State the cases with `SHOULD` in DEFINITION-OF-DONE
* Require each adopter to state its own criterion in arc42 section 9, with `MUST`

## Decision Outcome

Chosen option: "State the cases with `SHOULD` in DEFINITION-OF-DONE", because it gives every adopter the same baseline, and an adopter that judges significance in another way records how in one log entry of its `CHECKLIST`, an exception that documents its own criterion.

The cases are those in which a decision is costly to reverse, sets a constraint that lasts, or sets a policy that applies across the software. The cases that the rule names as not significant are those that none of these cases covers, so that a decision covered by one of the cases is significant even when it looks like a refactoring.

### Consequences

* Good, because adopters without rules of their own follow the cases and write nothing more.
* Good, because the rule sits next to the `MUST` it qualifies, in the document that adopters copy and read at each change.
* Good, because a rule made weaker later, if the pilot shows exceptions to it, is a minor change, while a rule made stricter is a major one ([`CONTRIBUTING`](../../CONTRIBUTING.md#releases)).
* Bad, because a new rule stated with `SHOULD` is a change that would be major, so the release notes mark it.
* Bad, because the cases are judged too, though more narrowly than "significant" alone.

### Confirmation

The release notes of the framework tag mark the change as one that would be major and say that it asks for no ADR of past decisions. This repository follows the cases with no exception: its ADRs 0001 to 0006 each set a policy or record a decision costly to reverse.

## Pros and Cons of the Options

### Suggest the cases with `SUGGESTED`

* Good, because it is a minor change, and no adopter records anything.
* Bad, because an adopter that judges significance in another way leaves no record of how.
* Bad, because making the cases a `SHOULD` later, once the pilot asks for it, would be a major change.

### Require each adopter to state its own criterion in arc42 section 9, with `MUST`

* Good, because every adopter's criterion is written down.
* Bad, because every adopter writes something, including those that would follow a criterion ready to use.
* Bad, because it is a major change too, and a heavier one.
