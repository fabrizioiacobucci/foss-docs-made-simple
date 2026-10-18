---
status: accepted
date: 2026-10-18
decision-makers: "@fabrizioiacobucci"
---

# State what shows that adopters need a change to the framework

## Context and Problem Statement

The "Nothing ahead of need" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) says that nothing is added before an adopter needs it, but not what shows the need. The framework's first tag was written before any adopter existed, from the criteria of the OpenSSF Best Practices Badge, and the [`ROADMAP`](../ROADMAP.md) plans laws, standards and a pilot. Adopters record their exceptions in their own `CHECKLIST`, which the maintainers do not see. What shows a need, and what do the maintainers do when adopters depart from the same rule?

## Considered Options

* Leave the rule as it is, judged change by change
* A count of adopters, such as two or more asking for the same rule
* A list of the kinds of evidence, and a channel for adopters

## Decision Outcome

Chosen option: "A list of the kinds of evidence, and a channel for adopters", because it covers how the framework was in fact written, it needs no count that two pilot adopters cannot reach in a meaningful way, and it gives the maintainers the adopters' exceptions, which a rule too strict produces.

### Consequences

* Good, because each change to the framework can name its evidence.
* Good, because repeated exceptions lead to re-reading a rule, within the "Badge strength" and "Sources" rules.
* Bad, because a single adopter's case can be enough, so the maintainers still judge whether it is general.

### Confirmation

The maintainers check each change to a framework document against the "Nothing ahead of need" rule, as for the other rules of `CONTRIBUTING`.

## Pros and Cons of the Options

### Leave the rule as it is, judged change by change

* Good, because nothing changes.
* Bad, because badge criteria, laws and defects are not "an adopter's need" in the words of the rule, though they are how the framework grows.

### A count of adopters, such as two or more asking for the same rule

* Good, because it is objective.
* Bad, because with two pilot adopters it means unanimity, and the [`ROADMAP`](../ROADMAP.md) already defers the organisation layer until one pilot asks for it.
