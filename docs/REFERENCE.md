# Reference

The external interface of foss-docs-made-simple, and the part of it that is the public API under [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

## External interface

The framework has no code, command line or configuration; the scripts in `scripts/` check this repository and are not part of the interface. An adopter uses ([README](../README.md#adopting-the-framework)):

- the framework tags, listed on the [tags page](https://github.com/fabrizioiacobucci/foss-docs-made-simple/tags);
- the framework documents, read at a framework tag at `https://github.com/fabrizioiacobucci/foss-docs-made-simple/blob/TAG/framework/<name>.md`;
- the copies it makes of [CHECKLIST](../framework/CHECKLIST.md) and [DEFINITION-OF-DONE](../framework/DEFINITION-OF-DONE.md), and the copied `CHECKLIST` it fills in;
- the steps of the README and the release notes in [CHANGELOG](CHANGELOG.md), which say how to adopt the framework and how to move to a newer framework tag.

## Public API

The public API is narrower than the external interface. It is:

- every rule that a framework document other than [BADGE-MAP](../framework/BADGE-MAP.md) sets on an adopter, that is every statement with a BCP 14 keyword or `SUGGESTED`, with its strength, the level it applies from, and the framework document that holds it;
- the meaning of each term that [GLOSSARY](../framework/GLOSSARY.md) defines;
- the project documents that [DOCUMENTS-INDEX](../framework/DOCUMENTS-INDEX.md) requires at each level, with their ids, file names, content items and the locations it requires;
- the form of the copied files: their sections, the columns of their tables and the status values of the register;
- the names and paths of the framework documents.

The rest of the external interface is outside the public API.
