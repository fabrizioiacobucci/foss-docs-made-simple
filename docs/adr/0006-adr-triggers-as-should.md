---
status: accepted
date: 2026-10-18
decision-makers: "@fabrizioiacobucci"
---

# State which decisions are significant architectural decisions, with `SHOULD`

## Context and Problem Statement

From passing, [DEFINITION-OF-DONE](../../framework/DEFINITION-OF-DONE.md#changes) requires an ADR for each significant architectural decision, a requirement that the badge does not set ([BADGE-MAP](../../framework/BADGE-MAP.md#not-asked-by-the-badge)). [GLOSSARY](../../framework/GLOSSARY.md) defines an ADR by citing [Nygard 2011](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions), who keeps records for decisions "that affect the structure, non-functional characteristics, dependencies, interfaces, or construction techniques", but no framework document says which decisions those are, so a rule stated with `MUST` depends on a judgement that each reader makes differently: a defect that the "Nothing ahead of need" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) counts as a need. Adopters come either without documentation rules of their own, and need a criterion ready to use, or with documentation that they adapt, and may already judge significance in their own way. How does an adopter know when the rule applies?

## Considered Options

* Suggest the cases with `SUGGESTED`
* State Nygard's five aspects with `SHOULD`, leaving out the decisions that only apply an earlier one
* State cases with `SHOULD`, leaving out the decisions that are obvious and cheap to reverse
* Require each adopter to state its own criterion in arc42 section 9, with `MUST`

## Decision Outcome

Chosen option: "State Nygard's five aspects with `SHOULD`, leaving out the decisions that only apply an earlier one", because it gives every adopter the same baseline, says the same as the source that GLOSSARY cites, and leaves out decisions by a test that a reader can check, the earlier ADR or project document that the decision applies; an adopter that judges significance in another way records how in one log entry of its `CHECKLIST`, an exception that documents its own criterion.

The rule names the aspects as the framework's terms do: "quality characteristics" for Nygard's non-functional characteristics, which GLOSSARY avoids, and "external interface", as CONVENTIONS uses it, with the interfaces between building blocks, as arc42 names the parts of the software.

### Consequences

* Good, because adopters without rules of their own follow the rule and write nothing more.
* Good, because the rule sits next to the `MUST` it qualifies, in the document that adopters copy and read at each change.
* Good, because an ADR that sets a policy, such as for dependencies, makes the later decisions that apply it part of it, so the number of ADRs falls as the policies grow, as Nygard expects the consequences of one ADR to become the context of the next.
* Good, because a rule made weaker later, if the pilot shows exceptions to it, is a minor change, while a rule made stricter is a major one ([`CONTRIBUTING`](../../CONTRIBUTING.md#releases)).
* Bad, because until such policies exist, each decision on one of the aspects asks for an ADR, a new dependency included.
* Bad, because a new rule stated with `SHOULD` is a change that would be major, so the release notes mark it.

### Confirmation

The release notes of the framework tag mark the change as one that would be major and say that it asks for no ADR of past decisions. This repository follows the rule with no exception: its ADRs 0001 to 0006 each affect the structure, the external interface or the construction techniques of the framework.

## Pros and Cons of the Options

### Suggest the cases with `SUGGESTED`

* Good, because it is a minor change, and no adopter records anything.
* Bad, because an adopter that judges significance in another way leaves no record of how.
* Bad, because making the cases a `SHOULD` later, once the pilot asks for it, would be a major change.

### State cases with `SHOULD`, leaving out the decisions that are obvious and cheap to reverse

* Good, because it asks for fewer ADRs.
* Bad, because "obvious" and "cheap" do not say to whom, in what or when: a choice cheap to reverse today grows costly as the software grows, and what is obvious to its author is not to the person who joins later.
* Bad, because Nygard records decisions so that later readers neither accept nor reverse them blindly, and expects decisions to be reversed and superseded, so the cost of reversing is not what makes a decision significant.

### Require each adopter to state its own criterion in arc42 section 9, with `MUST`

* Good, because every adopter's criterion is written down.
* Bad, because every adopter writes something, including those that would follow a criterion ready to use.
* Bad, because it is a major change too, and a heavier one.

## More Information

A first version of this decision, never released, stated cases filtered by the cost of reversing; it was replaced the same day, after Nygard's text was read at the source.
