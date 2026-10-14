# Glossary

The terms this framework uses, one meaning each, so that the framework and the projects that adopt it use the same words.

## Framework and adopters

**Adopter**:
A project that follows the framework at a framework tag it has chosen, and cites that tag in its own documentation.
_Avoid_: user, client

**User**:
A person or organisation that uses an adopter's software, including projects that depend on it.
_Avoid_: adopter

**Framework tag**:
A Semantic Versioning tag of this repository, cited by an adopter the way it would cite a version of a standard.
_Avoid_: framework version, framework release

**Level**:
One of the three levels of the [OpenSSF Best Practices Badge](https://www.bestpractices.dev/en/criteria) (passing, silver, gold), as chosen by an adopter to decide which documents it needs, whether or not it holds the badge.
_Avoid_: badge (for the level), tier, profile

## Documents

**Framework document**:
A document in the `framework/` folder of this repository, read at a framework tag.
_Avoid_: template

**Project document**:
A document in an adopter's repository, written by the adopter or copied from a framework document and filled in.
_Avoid_: template

**Required document**:
A project document that an adopter needs because of its level.
_Avoid_: core document, mandatory document

## Adopter rules

**Exception**:
An adopter's recorded decision not to follow a framework rule as written, including a rule stated with `SHOULD`; not following a rule stated with `SUGGESTED` or `MAY` is not an exception.
_Avoid_: deviation, waiver

**Addition**:
A rule an adopter sets on top of the framework rules, such that following it never breaks a framework rule: a rule stricter than a framework rule, that is with a stronger keyword, from an earlier level or with fewer allowed choices, or a requirement for a project document that no level requires. Any other rule that a project document states, such as the contribution process or the test policy, is content of that document, even when a framework rule asks for its topic.
_Avoid_: exception

## Requirements and quality

**BCP 14 keywords**:
`MUST`, `SHOULD`, `MAY`, their synonyms (`REQUIRED`, `SHALL`, `RECOMMENDED`, `OPTIONAL`) and their negations, with the meanings of [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119), which they carry only in capitals ([RFC 8174](https://www.rfc-editor.org/rfc/rfc8174)).
_Avoid_: Vocabulary, RFC 2119 keywords

**SUGGESTED**:
A keyword taken from the [OpenSSF Best Practices Badge criteria](https://github.com/ossf/best-practices-badge/blob/main/docs/criteria.md), weaker than `SHOULD`: the adopter considers the practice, and valid reasons not to follow it are common.
_Avoid_: `RECOMMENDED` (a synonym of `SHOULD`)

**Quality goal**:
One of the few quality requirements that matter most to the stakeholders of an adopter's software, as in arc42 section 1.2.
_Avoid_: non-functional requirement

## Architecture

**arc42**:
A template for software architecture documentation in twelve sections ([arc42](https://arc42.org/)).
_Avoid_: Architecture Template

**ADR**:
A short document recording one architecturally significant decision, its context and its consequences ([Nygard 2011](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions)).
_Avoid_: Arch Decision, decision record

**C4 model**:
A set of hierarchical architecture diagrams at four levels of detail: system context, containers, components and code ([C4 model](https://c4model.com/)).

## Security

**Security requirements**:
What an adopter states its users can and cannot expect from its software in terms of security.
_Avoid_: security target, security goals

**Threat model**:
The analysis of an adopter's software that answers the four questions of the [Threat Modeling Manifesto](https://www.threatmodelingmanifesto.org/): what are we working on, what can go wrong, what are we going to do about it, did we do a good enough job.
_Avoid_: risk analysis

**Assurance case**:
The argument that the security requirements are met: the threat model, the trust boundaries, the secure design principles applied and the common weaknesses countered.
_Avoid_: security proof, verification report

**SBOM**:
A machine-readable inventory of the components of a piece of software and of their dependencies.
_Avoid_: bill of materials, dependency list

## Testing

**Test policy**:
An adopter's stated rule on when contributors add tests to the automated test suite.
_Avoid_: test strategy

**Test strategy**:
The description of how an adopter's software is tested: which kinds of tests, with which tools, covering what.
_Avoid_: test policy, test plan

## Contributions and licences

**Free and open-source licence**:
A licence that meets the Open Source Definition or the Free Software Definition, such as one approved by the Open Source Initiative or by the Free Software Foundation.
_Avoid_: FLOSS licence, open licence

**DCO**:
The [Developer Certificate of Origin](https://developercertificate.org/), a statement by which a contributor certifies the right to submit a contribution; in practice it is given with a `Signed-off-by` line on each commit.
_Avoid_: sign-off (for the certificate itself)

**CLA**:
A Contributor License Agreement: a contract by which a contributor grants a project rights over a contribution.
_Avoid_: contributor agreement

**REUSE**:
The [REUSE specification](https://reuse.software/spec/), which states the copyright and licence of every file of a project in a human- and machine-readable way.
_Avoid_: licence headers (for REUSE as a whole)

## Relationships

- An **adopter** follows exactly one **framework tag** and has exactly one **level** at a time.
- An **exception** departs from one framework rule; an **addition** departs from none.
- The **assurance case** argues that the **security requirements** are met, and includes the **threat model**.
