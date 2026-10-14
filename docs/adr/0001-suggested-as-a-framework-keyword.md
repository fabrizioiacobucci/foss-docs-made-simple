---
status: accepted
date: 2026-10-13
decision-makers: "@fabrizioiacobucci"
---

# Adopt `SUGGESTED` as a framework keyword

## Context and Problem Statement

Every framework rule uses a BCP 14 keyword, and many rules are taken from criteria of the [OpenSSF Best Practices Badge](https://www.bestpractices.dev/en/criteria), which uses three strengths: "MUST", "SHOULD" and "SUGGESTED", the last weaker than "SHOULD". Under the framework, a rule stated with `SHOULD` that an adopter does not follow is an exception, which the adopter records ([GLOSSARY](../../framework/GLOSSARY.md)). How does a rule taken from a criterion keep the criterion's strength, including a "SUGGESTED" one?

## Considered Options

* Map "SUGGESTED" to `SHOULD`
* Map "SUGGESTED" to `MAY`, or to a sentence without a keyword
* Map "SUGGESTED" to `RECOMMENDED`
* Adopt `SUGGESTED` as a framework keyword, defined in GLOSSARY

## Decision Outcome

Chosen option: "Adopt `SUGGESTED` as a framework keyword, defined in GLOSSARY", because it is the only option that keeps every badge strength as it is: the adopter considers the practice, and not following it is not an exception.

A rule taken from a criterion therefore keeps the criterion's strength: "MUST" becomes `MUST`, "SHOULD" becomes `SHOULD` and "SUGGESTED" becomes `SUGGESTED`. A framework document may make a rule stricter only by stating its reason, as the "Badge strength" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) requires.

### Consequences

* Good, because each rule's strength can be checked against its criterion, one to one.
* Good, because adopters record no exception for a practice that the badge only suggests.
* Bad, because `SUGGESTED` is not a BCP 14 keyword, so a reader learns its meaning from GLOSSARY, not from RFC 2119.

### Confirmation

The maintainers check each change to a framework document against the "Keywords" and "Badge strength" rules of `CONTRIBUTING`.

## Pros and Cons of the Options

### Map "SUGGESTED" to `SHOULD`

* Good, because the framework uses only standard keywords.
* Bad, because adopters would record as exceptions practices that the badge leaves free, such as an OSI-approved licence.

### Map "SUGGESTED" to `MAY`, or to a sentence without a keyword

* Good, because the framework uses only standard keywords.
* Good, because some suggested practices need no rule of their own: any licence approved by the FSF, Debian or Fedora already meets the rule that the licence be free, without OSI approval.
* Bad, because `MAY` makes the practice as optional as any other, and a sentence without a keyword is not a rule, so the badge's nudge is lost.

### Map "SUGGESTED" to `RECOMMENDED`

* Good, because it is a standard keyword, whose name reads weaker than `SHOULD`.
* Bad, because RFC 2119 makes `RECOMMENDED` a synonym of `SHOULD`, so it has the same cost as mapping to `SHOULD`.

## More Information

Rules that became `SUGGESTED` with this decision: OSI approval of the licence ([LICENSE-POLICY](../../framework/LICENSE-POLICY.md)) and Semantic Versioning or Calendar Versioning ([CONVENTIONS](../../framework/CONVENTIONS.md#versions)).

This ADR was written on 2026-10-14, after the decision. The maintainer chose after asking about `RECOMMENDED`, which RFC 2119 makes a synonym of `SHOULD`.
