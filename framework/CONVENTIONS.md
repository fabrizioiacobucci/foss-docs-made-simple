# Conventions

How an adopter writes its project documents, requirements, ADRs, commits, versions and release notes.

## Project documents

- Project documents SHOULD be plain-text files, so that they are changed, reviewed and versioned with the code.
- Project documents SHOULD be written in Markdown, unless the adopter's documentation already uses another plain-text markup.
- Project documents SHOULD be available in English.

## Requirements

- An adopter SHOULD write requirements with BCP 14 keywords.

## ADRs

- ADRs SHOULD follow one of the templates of [MADR 4.0.0](https://github.com/adr/madr/releases/tag/4.0.0).

## Commits

- Commit messages SHOULD follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

## Versions

- Every release intended for users MUST have a unique version identifier.
- It is SUGGESTED that versions follow [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html) or [Calendar Versioning 26.0](https://calver.org/).
- An adopter that follows Semantic Versioning MUST declare its public API, as Semantic Versioning requires.
- `REFERENCE` MAY declare a public API narrower than the external interface it describes; if it does not, that whole external interface is the public API.

## Release notes

- Release notes in `CHANGELOG` SHOULD follow [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/).
- Release notes MUST be a human-readable summary of the major changes of the release, so that users can decide whether to upgrade and what the upgrade will affect.
- Release notes MUST NOT be the raw output of the version control log.
- Release notes MAY be generated from the commits, for example with [git-cliff](https://git-cliff.org/) when commits follow Conventional Commits.
- Generated release notes MUST be edited until they meet the two rules above.
- Unless users typically cannot update the software themselves and depend on intermediaries to do it, release notes MUST identify every publicly known run-time vulnerability of the adopter's software, not of its dependencies, that is fixed in the release and already had a CVE or similar identifier when the release was created.
