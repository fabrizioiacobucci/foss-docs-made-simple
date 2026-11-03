---
status: accepted
date: 2026-11-03
decision-makers: "@fabrizioiacobucci"
---

# Use BCP 14 keywords outside the IETF scope, and state them once per adopter

## Context and Problem Statement

The framework's [GLOSSARY](../../framework/GLOSSARY.md) defines the BCP 14 keywords "with the meanings of RFC 2119", every framework rule uses them, and [CONVENTIONS](../../framework/CONVENTIONS.md#requirements) asks adopters to write requirements with them. [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119) defines those words "as they should be interpreted in IETF documents", and its section 6 says that they "MUST only be used where it is actually required for interoperation or to limit behavior which has potential for causing harm". Most framework rules govern a documentation process. The framework did not say that it departs from that guidance, or why ([#20](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/20)). The pilot adopter, which now uses the keywords in every project document, also asked how to state their meaning without copying the framework's definition into each document ([#17](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues/17)). RFC 2119 and [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174) advise authors that they "should incorporate this phrase near the beginning of their document", a lowercase "should" addressed to the authors of IETF documents; RFC 8174 adds that "using them is not required" and that the words carry their meanings only in capitals. `SUGGESTED`, which [ADR 0001](0001-suggested-as-a-framework-keyword.md) added, is not in either RFC. How does the framework state its use of the keywords, and how does an adopter state the meaning of the keywords it uses?

## Considered Options

* State the departure from section 6 in the GLOSSARY entry, and suggest that adopters state the meanings once, by reference to the framework's GLOSSARY
* State the departure in an ADR only
* Copy the definition into each adopter document, or into the adopter's glossary
* Require a glossary from a level, holding the statement
* Also suggest now that adopters use the keywords only for requirements a reader must be able to check

## Decision Outcome

Chosen option: "State the departure from section 6 in the GLOSSARY entry, and suggest that adopters state the meanings once, by reference to the framework's GLOSSARY", because adopters read the framework documents, which do not link to this repository's ADRs, and because one statement linked from the `README` reaches every project document, while the definition stays in one place.

- **Meanings.** The framework takes the meanings of the keywords from RFC 2119, sections 1 to 5, and their restriction to capitals from RFC 8174. It does not take the guidance of section 6, because the framework's rules govern a documentation process, not interoperation or harm, and the framework is not an IETF document, the scope that the Abstract of RFC 2119 names. No framework rule is taken from section 6, so the "Sources" rule of [`CONTRIBUTING`](../../CONTRIBUTING.md#rules-for-changing-the-framework) is met.
- **Name.** The name "BCP 14 keywords" is kept, although the guidance of section 6 is left out: it names the words and their meanings as BCP 14 defines them, it is the name readers find in RFC 8174, and the GLOSSARY entry now says how the framework's use differs.
- **GLOSSARY.** One sentence without keywords, in the entry "BCP 14 keywords", says that the framework and its adopters use these meanings for their own rules, beyond the use that section 6 advises for IETF documents. It has no link to this ADR, since framework documents do not link into this repository's own `docs/` ([ADR 0003](0003-framework-documents-in-framework-folder.md)). The sentence is a patch: it states where the meanings are used, not what they mean, so the meaning of the term is unchanged and no rule gains or loses scope. This differs from the clarification without keywords that [ADR 0009](0009-no-adrs-required-for-decisions-before-adoption.md) rejected, which would have changed the scope in time of a rule.
- **Adopters.** CONVENTIONS suggests, with `SUGGESTED`, that an adopter that writes requirements with the keywords state once, in its `README` or in a project document its `README` links, that the keywords and `SUGGESTED` carry the meanings of the framework's GLOSSARY entries, linked at the adopted framework tag. This departs from the per-document phrase that the RFCs advise for IETF documents, because one statement linked from the `README` reaches every project document without being repeated in each, and it also covers `SUGGESTED`. A new rule with `SUGGESTED` is a minor change.

### Consequences

* Good, because a reader of the GLOSSARY learns the choice without opening this repository's ADRs.
* Good, because adopters that follow the suggestion inherit the stated choice, by reference.
* Bad, because the `SHOULD` in CONVENTIONS still asks adopters to write requirements with the keywords, more widely than RFC 8174 needs; see "More Information".

### Confirmation

The GLOSSARY entry "BCP 14 keywords" holds the sentence, CONVENTIONS, "Requirements", holds the `SUGGESTED` rule, and the release notes of the framework tag classify the first as a patch and the second as minor.

## Pros and Cons of the Options

### State the departure in an ADR only

* Bad, because adopters read the documents in `framework/`, which do not link to `docs/adr/`, so the choice would stay hidden from them.

### Copy the definition into each adopter document, or into the adopter's glossary

* Bad, because it duplicates the framework's definition, and the copies can drift from it.

### Require a glossary from a level, holding the statement

* Bad, because it would be a major change, and neither the badge nor an adopter asks for it.

### Also suggest now that adopters use the keywords only for requirements a reader must be able to check

* Good, because it would follow the spirit of section 6, and RFC 8174 says that normative text does not need the keywords.
* Bad, because it would be a change ahead of need: no adopter has reported a problem caused by wide use.

## More Information

The rule asking adopters to use the keywords sparingly is deferred until an adopter reports a problem caused by their wide use. If it is taken up, the `SHOULD` of CONVENTIONS, "An adopter SHOULD write requirements with BCP 14 keywords", is re-read with it; making that `SHOULD` weaker would be a minor change.
