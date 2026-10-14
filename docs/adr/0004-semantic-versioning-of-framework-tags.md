---
status: accepted
date: 2026-10-14
decision-makers: "@fabrizioiacobucci"
---

# Number framework tags with Semantic Versioning, against a declared public API

## Context and Problem Statement

Adopters follow the framework at a framework tag and move to newer tags as the framework's [GOVERNANCE](../../framework/GOVERNANCE.md#new-framework-tag) describes. [CONVENTIONS](../../framework/CONVENTIONS.md#versions) asks for a unique version, suggests Semantic Versioning or Calendar Versioning, and, with Semantic Versioning, asks for a declared public API, which by default is the external interface. Framework tags followed Semantic Versioning from the start, but the framework has no code, and the classes major, minor and patch were defined by examples, some of which fell between two classes or in both. What is the public API of the framework, so that an adopter can tell from the number whether moving to a tag can break its compliance or its links?

## Considered Options

* Calendar Versioning
* Semantic Versioning, with the whole external interface as the public API
* Semantic Versioning, with a public API narrower than the external interface, declared in `REFERENCE`

## Decision Outcome

Chosen option: "Semantic Versioning, with a public API narrower than the external interface, declared in `REFERENCE`", because each class can then be defined by what it does to the public API, so that every change falls in exactly one class, and changes that cannot break an adopter's compliance or links, such as a new row of [BADGE-MAP](../../framework/BADGE-MAP.md) or a reworded step of the `README`, do not make a major framework tag.

### Consequences

* Good, because from `1.0.0` an adopter that met a tag still meets every later tag of the same major version, though its records may change.
* Good, because the release notes name what an adopter must do to move ([`CONTRIBUTING`](../../CONTRIBUTING.md#releases)).
* Good, because Semantic Versioning, which CONVENTIONS only suggests, is required for this repository's tags, an addition listed in its project [`GOVERNANCE`](../GOVERNANCE.md#documentation).
* Bad, because telling a major change from a minor one needs judgement on each rule change; `CONTRIBUTING` defines the three classes, with examples, to guide it.
* Bad, because before `1.0.0` a breaking change increments the minor number, as Semantic Versioning allows, so until then the number tells less.

### Confirmation

The release notes of each framework tag mark every change that would be major, as `CONTRIBUTING` requires, and the maintainers check the number against them.

## Pros and Cons of the Options

### Calendar Versioning

* Good, because the number says how old a tag is, and needs no judgement.
* Bad, because the number does not tell an adopter whether a tag can break its compliance, so it cannot tell whether to plan a move without reading every release note.

### Semantic Versioning, with the whole external interface as the public API

* Good, because it is the default of CONVENTIONS, with nothing to declare.
* Bad, because a change to BADGE-MAP or to the wording of the `README` steps would count as a change to the public API, so the number would signal breaks that cannot happen.

## More Information

The public API is declared in [`REFERENCE`](../REFERENCE.md#public-api), and the classes are defined in `CONTRIBUTING`.

This ADR was written on 2026-10-14, the day of the decision. Semantic Versioning came from the previous framework's contribution rules; what was decided on 2026-10-14 is the public API and the classes defined against it. Calendar Versioning is the alternative that CONVENTIONS names.
