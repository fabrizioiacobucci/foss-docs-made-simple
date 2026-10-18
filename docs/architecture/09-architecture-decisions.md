# 9. Architecture decisions

The significant architectural decisions of this repository, one ADR each in `docs/adr/`, written with the full template of [MADR 4.0.0](https://github.com/adr/madr/releases/tag/4.0.0), as the framework's [CONVENTIONS](../../framework/CONVENTIONS.md#adrs) asks. The status and the date of each decision are at the top of its ADR.

ADRs 0001 to 0003 record decisions made before this repository followed the framework, and ADR 0004 one made after, while this section was still `draft`. Those four were written afterwards, on 2026-10-14, each with the date on which its decision was made; ADRs 0005 and 0006 were written when their decisions were made.

| ADR | Decision |
|---|---|
| [0001](../adr/0001-suggested-as-a-framework-keyword.md) | Adopt `SUGGESTED` as a framework keyword |
| [0002](../adr/0002-layered-governance.md) | Layer the governance: framework rules by link, project data in the project `GOVERNANCE` from passing |
| [0003](../adr/0003-framework-documents-in-framework-folder.md) | Keep the framework documents in `framework/`, so that `docs/` follows the default layout |
| [0004](../adr/0004-semantic-versioning-of-framework-tags.md) | Number framework tags with Semantic Versioning, against a declared public API |
| [0005](../adr/0005-evidence-of-need.md) | State what shows that adopters need a change to the framework |
| [0006](../adr/0006-adr-triggers-as-should.md) | State when an architectural decision is significant, with `SHOULD` |
