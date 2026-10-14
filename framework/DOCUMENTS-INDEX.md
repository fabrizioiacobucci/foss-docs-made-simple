# Documents index

Which project documents an adopter needs at each level, what each contains, what its file is called and where it lives.

## Files

- GitHub community files (`README.md`, `CONTRIBUTING.md`, `SECURITY.md`, `CODE_OF_CONDUCT.md`, `ACCESSIBILITY.md`) MUST be in the repository root, in `.github/` or in `docs/`, where GitHub finds them.
- The licence texts MUST be in `LICENSE` in the repository root or, when the adopter follows REUSE, in `LICENSES/`.
- An adopter MAY place its other project documents anywhere in its repository. The framework's default layout is `docs/` for project documents, `docs/architecture/` for arc42 sections, one file per section, and `docs/adr/` for ADRs.

## Reading the tables

- At each level, an adopter MUST have every document listed for that level and for the levels below it.
- Within a document, each content item carries its own strength, written before it. When a higher level lists an item again, the strength of the higher level applies.
- When an arc42 section and another project document would hold the same content, the content MUST be in the other project document and the arc42 section MUST link to it.
- An adopter MAY add arc42 sections that no level requires.

## Passing

| Document | File | Content |
|---|---|---|
| `README` | `README.md` | MUST: what the software does; how to obtain, install, start and use it; how to use it securely, when that applies; how to give feedback, report bugs and contribute; where discussion happens; where the project documents are; the framework tag the adopter follows |
| `CONTRIBUTING` | `CONTRIBUTING.md` | MUST: the contribution process; how to run the automated tests, or a link to the script that runs them. SHOULD: the requirements for acceptable contributions. SUGGESTED: the test policy |
| `SECURITY` | `SECURITY.md` | MUST: how to report a vulnerability; how to report it privately, when private reports are supported. SUGGESTED: the time within which a reporter receives a first response |
| `LICENSE` | `LICENSE` or `LICENSES/` | MUST: the licence texts, as [LICENSE-POLICY](LICENSE-POLICY.md) requires |
| `CHANGELOG` | `CHANGELOG.md` | MUST: release notes, written as [CONVENTIONS](CONVENTIONS.md) requires; or, when [DEFINITION-OF-DONE](DEFINITION-OF-DONE.md) lets the adopter omit release notes, a statement that the software is delivered continuously without them |
| `REFERENCE` | `REFERENCE.md` | MUST: the external interface of the software, input and output: API, command line, configuration, file formats; the public API, as [CONVENTIONS](CONVENTIONS.md) defines it |
| `GOVERNANCE` | `GOVERNANCE.md` | MUST: who holds each framework role; a "Documentation" section that links the framework's [GOVERNANCE](GOVERNANCE.md) at the adopted framework tag and lists the adopter's additions. Required at passing, before the badge asks for a governance document at silver, so that the role holders and the additions have one place at every level |
| `CHECKLIST` | `CHECKLIST.md` | MUST: a copy of the framework document of the same name, at the adopted framework tag |
| `DEFINITION-OF-DONE` | `DEFINITION-OF-DONE.md` | MUST: a copy of the framework document of the same name, at the adopted framework tag |
| arc42 section 8 | `08-crosscutting-concepts.md` | MUST: the crosscutting concepts the software has, at least its test strategy and how it is built and deployed; a link to `CONTRIBUTING` for how to run the tests. Required at passing because it holds the test strategy |
| arc42 section 9 | `09-architecture-decisions.md` and `docs/adr/` | MUST: one ADR per significant architectural decision, written when the decision is made; section 9 lists the ADRs and links to them. Required at passing because an ADR costs least when the decision is made |

## Silver

| Document | File | Content added |
|---|---|---|
| `README` | `README.md` | MUST: how to uninstall the software; links to the project's achievements, the badge included, once attained |
| `CONTRIBUTING` | `CONTRIBUTING.md` | MUST: the requirements for acceptable contributions; the test policy; the coding style guides of the main languages, and that contributions generally comply with them; how a developer sets up the environment, tests included. SHOULD: the mechanism by which contributors assert their right to contribute, as [LICENSE-POLICY](LICENSE-POLICY.md) requires |
| `SECURITY` | `SECURITY.md` | MUST: the security requirements; the process for responding to vulnerability reports; which older versions are maintained, or the upgrade path; how to upgrade, when upgrading is difficult; how users obtain the signing keys and verify releases. SUGGESTED: drawing the security requirements from [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/) |
| `GOVERNANCE` | `GOVERNANCE.md` | MUST: how the project decides; the key roles, their tasks and who holds them; how the project continues if any one person leaves, signing keys included |
| `CODE_OF_CONDUCT` | `CODE_OF_CONDUCT.md` | MUST: the code of conduct the project adopts |
| `ROADMAP` | `ROADMAP.md` | MUST: what the project intends to do, and not do, in the next year |
| `QUICK-START` | `QUICK-START.md` | MUST: a guide that takes a new user to a first useful result with the software |
| `ACCESSIBILITY` | `ACCESSIBILITY.md` | MUST: the accessibility target that the project's sites and software follow, or why none applies; MUST rather than the badge's SHOULD, because the badge asks for a justification either way. SUGGESTED: WCAG 2.2 level AA as the target |
| `THREAT-MODEL` | `THREAT-MODEL.md` | MUST: the assurance case: the threat model; the trust boundaries; how the common implementation weaknesses are countered; the argument that the security requirements are met; a link to arc42 section 8 for the secure design principles applied |
| Dependency manifest | the ecosystem's lock file or manifest | MUST: the external dependencies in a computer-processable form. SUGGESTED: an SBOM as well |
| arc42 section 1 | `01-introduction-and-goals.md` | MUST: the goals and the quality goals; a link to `SECURITY` for the security requirements; a link to `ACCESSIBILITY`, when accessibility is a quality goal |
| arc42 section 3 | `03-context-and-scope.md` | MUST: the C4 system context diagram; a link to `REFERENCE` for the external interfaces |
| arc42 section 4 | `04-solution-strategy.md` | MUST: a summary of the key decisions, with links to their ADRs |
| arc42 section 5 | `05-building-block-view.md` | MUST: the C4 container diagram |
| arc42 section 6 | `06-runtime-view.md` | MUST: the runtime behaviour of the key scenarios |
| arc42 section 7 | `07-deployment-view.md` | MUST: the infrastructure the software runs on, and which parts run where |
| arc42 section 8 | `08-crosscutting-concepts.md` | MUST: the secure design principles applied |
| arc42 section 10 | `10-quality-requirements.md` | MUST: the quality requirements, as scenarios where useful; a link to `SECURITY` for the security requirements; a link to `ACCESSIBILITY` for the accessibility target |
| arc42 section 11 | `11-risks-and-technical-debts.md` | MUST: the main risks and the technical debt; a link to `THREAT-MODEL` for the security risks |

## Gold

| Document | File | Content added |
|---|---|---|
| `CONTRIBUTING` | `CONTRIBUTING.md` | MUST: where small tasks for new or casual contributors are identified |
| `GOVERNANCE` | `GOVERNANCE.md` | MUST: the code review requirements, that is how review is done, what is checked and what is acceptable; the rule that at least half of the changes are reviewed before release by someone other than their author; the two-factor authentication required of developers |
| `SECURITY-REVIEW` | `SECURITY-REVIEW.md` | MUST: the latest security review of the security requirements and of the security boundary, that is the trust boundaries of `THREAT-MODEL`; its date |
