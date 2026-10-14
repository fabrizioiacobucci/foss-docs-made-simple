# 8. Crosscutting concepts

The concepts that apply across this repository: how it is tested, how it is released, and where the rules for writing it are.

## Test strategy

The repository holds Markdown documents and the scripts that check them, and the scripts have tests of their own in `scripts/tests/`. The scripts are Bash scripts that use standard tools and git; `scripts/check-copies.sh` also needs to reach the remote `origin` while the adopted framework tag is not fetched. Their tests use the same tools and need no network.

| What can go wrong | How it is caught, and by whom | When |
|---|---|---|
| A relative link points to a missing file or heading | `scripts/check-links.sh`, run by contributors and by continuous integration | Before each change is merged |
| A copied framework document drifts from the framework documents at the adopted framework tag, or a value filled in the project `CHECKLIST` has a wrong form | `scripts/check-copies.sh`, run by contributors and by continuous integration | Before each change is merged |
| A check script misses a problem, or reports one that is not there | The tests in `scripts/tests/`, run by contributors who change a script and by continuous integration | Before each change is merged |
| A change leaves a project document inaccurate | The change criteria of the [DEFINITION-OF-DONE](../DEFINITION-OF-DONE.md#changes), checked by the maintainers ([GOVERNANCE](../GOVERNANCE.md#roles)) | Before each change is merged |
| A change to a framework document breaks a [rule for changing the framework](../../CONTRIBUTING.md#rules-for-changing-the-framework) | Review of the change by the maintainers | Before each change to a framework document is merged |
| A required document is missing, or the release notes are not written | The release criteria of the [DEFINITION-OF-DONE](../DEFINITION-OF-DONE.md#releases), checked by the Documentation Owner | Before each release |
| A value of the project `CHECKLIST` is not true, such as the status of a document | The review of each document of the register by the Documentation Owner ([periodic checks](../../framework/GOVERNANCE.md#periodic-checks)) | At least once a year |
| A criterion of the OpenSSF Best Practices Badge has changed | The re-read of the criteria by the maintainers ([periodic checks](../../CONTRIBUTING.md#periodic-checks)) | At least once a year |

How to run the two scripts and their tests is in [CONTRIBUTING](../../CONTRIBUTING.md#tests), and what each script leaves out is stated at the top of the script. Continuous integration, in `.github/workflows/checks.yml`, runs the tests and both scripts on Linux and on macOS, on each pull request and on each push to `main`.

Known gaps, which no check covers yet:

- links to other sites, including the links at the adopted framework tag, which resolve only once the tag is published;
- whether the register lists every required document.

## Release

Nothing is built. Each release is a framework tag of this repository with its section in [CHANGELOG](../CHANGELOG.md), numbered and described as [CONTRIBUTING](../../CONTRIBUTING.md#releases) says, and made when the release criteria of the [DEFINITION-OF-DONE](../DEFINITION-OF-DONE.md#releases) are met. What adopters use of a release is in [REFERENCE](../REFERENCE.md#external-interface).

## Writing

How project documents are written: the framework's [CONVENTIONS](../../framework/CONVENTIONS.md). How framework documents are changed: [CONTRIBUTING](../../CONTRIBUTING.md#rules-for-changing-the-framework).
