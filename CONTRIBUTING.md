# Contributing to foss-docs-made-simple

How to contribute to this repository, the rules that every change to the framework follows, and how framework tags are made.

## How to contribute

- Bugs and proposals SHOULD be reported in the [issues](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues), except security problems, which [SECURITY.md](SECURITY.md) routes; changes MUST be sent as pull requests.
- Every commit MUST carry a `Signed-off-by` line, by which its author certifies the [Developer Certificate of Origin](https://developercertificate.org/) (`git commit -s`). This is an addition to the framework's [contribution rule](framework/LICENSE-POLICY.md#contributions).
- Commit messages MUST follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). This is an addition to the framework's [commit rule](framework/CONVENTIONS.md#commits).

## Tests

- Contributors SHOULD run the two checks from the repository root before sending a change:
  - `scripts/check-links.sh`: every relative link of the Markdown files resolves, to a file with the same letter case and, when the link has an anchor, to a heading of that file;
  - `scripts/check-copies.sh`: `docs/CHECKLIST.md` and `docs/DEFINITION-OF-DONE.md` match the framework documents at the framework tag that `README` states, or in the working tree while that tag does not exist yet, except for the values filled in, and those values have a valid form.
- What each check leaves out is stated at the top of the script; the rest of the "References" rule below, such as links to other sites, is checked by review.
- Continuous integration runs both checks and the tests of the scripts on each pull request. A change MUST NOT be merged while either check fails.
- A change that adds a kind of link, copied document or filled-in value SHOULD extend the checks to cover it.
- A change to a script in `scripts/` SHOULD add or update, in `scripts/tests/`, the tests of the behaviour it changes, and MUST NOT be merged while `scripts/tests/run.sh` fails. The tests use the same tools as the scripts, need no network, and build their fixtures in a temporary directory.

## Rules for changing the framework

Every change to a framework document MUST meet these rules before it is merged:

- **One place.** Each rule is stated in one framework document; the others link to it where the reader needs it.
- **Keywords.** Each rule uses a BCP 14 keyword or `SUGGESTED`, as defined in [framework/GLOSSARY.md](framework/GLOSSARY.md).
- **Badge strength.** A rule taken from a criterion of the OpenSSF Best Practices Badge keeps the criterion's strength, unless the framework document states the reason for a stricter one.
- **Sources.** A rule taken from a badge criterion, a standard or a law matches its source, read at the source.
- **Terms.** Each term defined in [framework/GLOSSARY.md](framework/GLOSSARY.md) is used in its canonical form, never one of its "Avoid" synonyms.
- **References.** Every link resolves, and every project document named exists in [framework/DOCUMENTS-INDEX.md](framework/DOCUMENTS-INDEX.md).
- **Dependents.** When a change alters a rule, every framework document that relies on that rule is re-read against these rules in the same change.
- **Nothing ahead of need.** Nothing is added before an adopter needs it, and the simplest form that works is chosen.
- **Third-party text.** The framework links to third-party works where it uses them and does not copy their text beyond short quotations (see the [README](README.md#licence)).
- **Names.** A new project document is named in capitals with hyphens, such as `THREAT-MODEL`; a file that GitHub reads by name keeps the name GitHub expects, such as `CODE_OF_CONDUCT`.
- **Citations.** A framework document names:
  - a project document that the framework defines by its id in code format, such as `THREAT-MODEL`, or by its name when it has no id, such as the dependency manifest;
  - an arc42 section by the numbering that arc42 gives it, such as "arc42 section 8", so that readers find it under the name arc42 uses;
  - another framework document by a link at its first mention in the document, and by its name after that.

## Releases

- Each framework tag MUST follow [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html), as in code; this is an addition to the framework's [version rule](framework/CONVENTIONS.md#versions):
  - **Major**: a change that removes or alters an element of the public API that [docs/REFERENCE.md](docs/REFERENCE.md) declares, so that an adopter that met the previous tag may no longer meet the new one, or its links to framework documents may no longer resolve, such as a new rule stated with `MUST`, `SHOULD` or their synonyms, a rule made stricter, a document newly required at an existing level, a changed meaning of a GLOSSARY term, a renamed document id, file name or framework document, or a change to the form of the copied files that adds anything not optional;
  - **Minor**: a backward-compatible change to the public API, after which every such adopter still meets the new tag, though its records may change, such as a new rule stated with `MAY` or `SUGGESTED`, a rule made weaker, a document no longer required at a level, or a new framework document that no existing level requires;
  - **Patch**: any other change; it leaves the public API unchanged.
- Before `1.0.0`, major and minor changes MUST increment the minor number and patch changes the patch number.
- The release notes in [docs/CHANGELOG.md](docs/CHANGELOG.md) MUST mark each change that would be major, and MUST name, so that an adopter can move to the new tag as [framework/GOVERNANCE.md](framework/GOVERNANCE.md) describes: the documents newly required, those that must hold more, and those no longer required, at each level; each rule added, made stricter or made weaker; each renamed document id, file name or framework document, and each changed meaning of a GLOSSARY term; each other change to the public API; and, when the form of [framework/CHECKLIST.md](framework/CHECKLIST.md) changes, how an adopter carries over its data. These requirements are an addition to the framework's [release-notes rules](framework/CONVENTIONS.md#release-notes).

## Periodic checks

At least once a year, the maintainers MUST re-read the criteria pages of the [OpenSSF Best Practices Badge](https://www.bestpractices.dev/en/criteria) and change [framework/BADGE-MAP.md](framework/BADGE-MAP.md) and the framework documents where the criteria have changed.
