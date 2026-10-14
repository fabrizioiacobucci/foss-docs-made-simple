# foss-docs-made-simple

A documentation framework for free and open-source software: which project documents a project needs at each level of the [OpenSSF Best Practices Badge](https://www.bestpractices.dev/en/criteria), what they contain, and how to keep them complete and current.

The framework covers the documents of the three levels and the rules around them. It sets no rule on how code is written, built or tested, beyond the licence, commit, version and release rules it states, and it does not cover legal obligations, such as those of European Union law; what is planned is in [docs/ROADMAP.md](docs/ROADMAP.md). Nothing here is legal advice: read the [disclaimer](#disclaimer).

## Adopting the framework

An adopter follows the framework at a framework tag, cited like the version of a standard, and reads the framework documents at that tag. The tags are listed on the [tags page](https://github.com/fabrizioiacobucci/foss-docs-made-simple/tags) of this repository.

1. Choose a framework tag and a level.
2. Copy [framework/CHECKLIST.md](framework/CHECKLIST.md) and [framework/DEFINITION-OF-DONE.md](framework/DEFINITION-OF-DONE.md) into the project's repository, and replace `TAG` in their links with the framework tag.
3. Write the project's `GOVERNANCE`, which names who holds the roles of [framework/GOVERNANCE.md](framework/GOVERNANCE.md) ([framework/DOCUMENTS-INDEX.md](framework/DOCUMENTS-INDEX.md)).
4. Record the adoption in the project's `CHECKLIST`, as [framework/GOVERNANCE.md](framework/GOVERNANCE.md) says: the level, one register row per required document, and the exceptions.
5. Write the other project documents that [framework/DOCUMENTS-INDEX.md](framework/DOCUMENTS-INDEX.md) lists for the level and the levels below it, setting each to `active` in the register when it holds what the level requires, and state the framework tag in the project's `README`. Apart from `CHECKLIST` and `DEFINITION-OF-DONE`, the framework gives no starting text for project documents.

From then on, the project works by its `DEFINITION-OF-DONE`, and [framework/GOVERNANCE.md](framework/GOVERNANCE.md) says what to do when the level changes, at the yearly checks and when moving to a newer framework tag.

A release can be made only when every required document exists ([framework/DEFINITION-OF-DONE.md](framework/DEFINITION-OF-DONE.md)). A project that cannot write them before its next release can adopt later, or adopt a lower level and raise it afterwards.

**Choosing a level.** The levels nest: an adopter at silver or gold has the documents of the levels below as well ([framework/DOCUMENTS-INDEX.md](framework/DOCUMENTS-INDEX.md)). Gold asks for rules that need more than one person, such as the review, before release, of at least half of the changes by someone other than their author; the badge itself asks, at gold, for at least two unassociated significant contributors.

**Other rules.** Projects that adopt the same framework tag follow the same rules. An adopter can set additions, listed in its project `GOVERNANCE` ([framework/DOCUMENTS-INDEX.md](framework/DOCUMENTS-INDEX.md)), and record exceptions, as [framework/GOVERNANCE.md](framework/GOVERNANCE.md) says; an adopter that needs other rules can fork this repository and follow its fork instead.

## The framework

| Document | What it is for |
|---|---|
| [GLOSSARY.md](framework/GLOSSARY.md) | The terms this framework uses, one meaning each |
| [CONVENTIONS.md](framework/CONVENTIONS.md) | How an adopter writes its project documents, requirements, ADRs, commits, versions and release notes |
| [LICENSE-POLICY.md](framework/LICENSE-POLICY.md) | Which licences an adopter releases its software under and accepts from its dependencies, and how it obtains assurance about the right to its contributions |
| [DOCUMENTS-INDEX.md](framework/DOCUMENTS-INDEX.md) | Which project documents an adopter needs at each level, what each contains, what its file is called and where it lives |
| [DEFINITION-OF-DONE.md](framework/DEFINITION-OF-DONE.md) | What an adopter checks at each change and at each release. Copied into the project |
| [CHECKLIST.md](framework/CHECKLIST.md) | The adopter's record of its level, of the state of its required documents, and of its exceptions and level changes. Copied into the project |
| [GOVERNANCE.md](framework/GOVERNANCE.md) | Who does what for the project documents, what the adopter records, and when it reviews its documents |
| [BADGE-MAP.md](framework/BADGE-MAP.md) | Where an adopter finds what answers each criterion of the badge, at each level |

## This repository

- How to report a bug, propose a change or contribute: [CONTRIBUTING.md](CONTRIBUTING.md); discussion happens in the issues and pull requests.
- The framework documents are in `framework/`. The project documents of this repository are `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `AGENTS.md` and `LICENSE` in its root, and the others in `docs/`.
- What changed between framework tags: [docs/CHANGELOG.md](docs/CHANGELOG.md).
- This repository follows foss-docs-made-simple itself, at framework tag `v0.1.0`; its level is recorded in its [CHECKLIST](docs/CHECKLIST.md).

## Licence

The framework is released under the [MIT License](LICENSE).

The framework names and links the standards it relies on where it uses them, without copying their text beyond short quotations. When an adopter copies or adapts a template or a text from one of them, the licence of that work applies to the copy. Among them are the [arc42](https://arc42.org/) template (CC BY-SA 4.0), the [MADR](https://adr.github.io/madr/) templates (MIT or CC0), [Keep a Changelog](https://keepachangelog.com/) (MIT) and the [Developer Certificate of Origin](https://developercertificate.org/) (verbatim copies only).

## Disclaimer

This framework helps free and open-source projects produce and maintain their documentation. It is a facilitator, not a certification and not a compliance system.

Nothing in this repository is legal advice. Where the framework maps a badge criterion or a standard to a document, the mapping is a shortcut written to help, and it can be incomplete, outdated or wrong; only the primary text applies. Read the badge criteria and the standards at their source before relying on them.

The framework is provided "as is", under the terms of the [MIT License](LICENSE), without warranty of any kind. The authors accept no liability for decisions taken on the basis of its contents.
