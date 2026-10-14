# Badge map

For each criterion of the [OpenSSF Best Practices Badge](https://www.bestpractices.dev/en/criteria), at each level, where an adopter finds what answers it: a project document, a practice of the project, or nothing in this framework.

The criteria are those of the criteria pages for [passing](https://www.bestpractices.dev/en/criteria/0), [silver](https://www.bestpractices.dev/en/criteria/1) and [gold](https://www.bestpractices.dev/en/criteria/2), read on 2026-10-13. The silver and gold pages list only the criteria that the level adds or strengthens.

## Reading the map

- **Badge** is the strength the badge gives the criterion at that level.
- **Kind** is one of:
  - *Document*: the criterion asks for something written, and the project document named holds it, with the content that [DOCUMENTS-INDEX](DOCUMENTS-INDEX.md) gives.
  - *Practice*: the criterion asks for something the project does or has; **Answered by** names the evidence, and the framework document that sets a rule on it, if any.
- A criterion that asks both for something written and for something done is a *Document*: the framework covers what is written, and the rest is the adopter's practice.
- The criteria about the code, its build, its tests, its cryptography and the project's sites are listed under "Outside the framework": the framework is about documentation and sets no rule on them.

## Passing

| Criterion | Badge | Kind | Answered by |
|---|---|---|---|
| `description_good` | MUST | Document | `README`: what the software does |
| `interact` | MUST | Document | `README`: how to obtain the software, give feedback and contribute |
| `contribution` | MUST | Document | `CONTRIBUTING`: the contribution process |
| `contribution_requirements` | SHOULD | Document | `CONTRIBUTING`: the requirements for acceptable contributions |
| `floss_license` | MUST | Practice | The licences in `LICENSE`; rule in [LICENSE-POLICY](LICENSE-POLICY.md) |
| `floss_license_osi` | SUGGESTED | Practice | The licences in `LICENSE`; rule in [LICENSE-POLICY](LICENSE-POLICY.md) |
| `license_location` | MUST | Document | `LICENSE`, where DOCUMENTS-INDEX places it |
| `documentation_basics` | MUST | Document | `README`: how to obtain, install, start and use the software, and how to use it securely, when that applies |
| `documentation_interface` | MUST | Document | `REFERENCE` |
| `discussion` | MUST | Practice | The discussion channels, named in `README` |
| `english` | SHOULD | Practice | Project documents in English (rule in [CONVENTIONS](CONVENTIONS.md)); bug reports and comments accepted in English |
| `maintained` | MUST | Practice | Recent activity in the repository and the issue tracker |
| `repo_public` | MUST | Practice | The public repository |
| `repo_track` | MUST | Practice | The version control history |
| `repo_interim` | MUST | Practice | The commits between releases |
| `repo_distributed` | SUGGESTED | Practice | The version control system |
| `version_unique` | MUST | Practice | The release versions; rule in [CONVENTIONS](CONVENTIONS.md) |
| `version_semver` | SUGGESTED | Practice | The release versions; rule in [CONVENTIONS](CONVENTIONS.md) |
| `version_tags` | SUGGESTED | Practice | The release tags in version control; rule in the project's `DEFINITION-OF-DONE` |
| `release_notes` | MUST | Document | `CHANGELOG`: the release notes; rules in [CONVENTIONS](CONVENTIONS.md) and in the project's `DEFINITION-OF-DONE`, which also gives the badge's continuous delivery case |
| `release_notes_vulns` | MUST | Document | `CHANGELOG`: the release notes; rule in [CONVENTIONS](CONVENTIONS.md) |
| `report_process` | MUST | Practice | The bug report process, described in `README` |
| `report_tracker` | SHOULD | Practice | The issue tracker |
| `report_responses` | MUST | Practice | The responses to bug reports in the issue tracker |
| `enhancement_responses` | SHOULD | Practice | The responses to enhancement requests in the issue tracker |
| `report_archive` | MUST | Practice | The public archive of reports and responses, such as the issue tracker |
| `vulnerability_report_process` | MUST | Document | `SECURITY`: how to report a vulnerability |
| `vulnerability_report_private` | MUST | Document | `SECURITY`: how to report a vulnerability privately, when private reports are supported |
| `vulnerability_report_response` | MUST | Practice | The first responses to vulnerability reports, within 14 days |
| `test` | MUST | Document | `CONTRIBUTING`: how to run the automated tests |
| `test_policy` | MUST | Practice | The test policy, formal or not |
| `tests_are_added` | MUST | Practice | The tests added with the most recent major changes |
| `tests_documented_added` | SUGGESTED | Document | `CONTRIBUTING`: the test policy |
| `know_secure_design` | MUST | Practice | A primary developer who knows how to design secure software |
| `know_common_errors` | MUST | Practice | A primary developer who knows the common errors that lead to vulnerabilities, and how to counter them |
| `vulnerabilities_fixed_60_days` | MUST | Practice | No vulnerability of medium or higher severity left unpatched more than 60 days after it became publicly known |
| `vulnerabilities_critical_fixed` | SHOULD | Practice | Critical vulnerabilities fixed rapidly after they are reported |

Outside the framework: `sites_https`, `build`, `build_common_tools`, `build_floss_tools`, `test_invocation`, `test_most`, `test_continuous_integration`, `warnings`, `warnings_fixed`, `warnings_strict`, `crypto_published`, `crypto_call`, `crypto_floss`, `crypto_keylength`, `crypto_working`, `crypto_weaknesses`, `crypto_pfs`, `crypto_password_storage`, `crypto_random`, `delivery_mitm`, `delivery_unsigned`, `no_leaked_credentials`, `static_analysis`, `static_analysis_common_vulnerabilities`, `static_analysis_fixed`, `static_analysis_often`, `dynamic_analysis`, `dynamic_analysis_unsafe`, `dynamic_analysis_enable_assertions`, `dynamic_analysis_fixed`.

## Silver

| Criterion | Badge | Kind | Answered by |
|---|---|---|---|
| `achieve_passing` | MUST | Practice | The passing badge |
| `contribution_requirements` | MUST | Document | `CONTRIBUTING`: the requirements for acceptable contributions |
| `dco` | SHOULD | Practice | The mechanism by which contributors assert their right to contribute, described in `CONTRIBUTING`; rule in [LICENSE-POLICY](LICENSE-POLICY.md) |
| `governance` | MUST | Document | `GOVERNANCE`: how the project decides, and its key roles |
| `code_of_conduct` | MUST | Document | `CODE_OF_CONDUCT` |
| `roles_responsibilities` | MUST | Document | `GOVERNANCE`: the key roles, their tasks and who holds them |
| `access_continuity` | MUST | Practice | The ability to continue if any one person leaves, described in `GOVERNANCE` |
| `bus_factor` | SHOULD | Practice | Two or more people able to keep the project going, such as the role holders named in `GOVERNANCE` |
| `documentation_roadmap` | MUST | Document | `ROADMAP` |
| `documentation_architecture` | MUST | Document | The arc42 sections of passing and silver |
| `documentation_security` | MUST | Document | `SECURITY`: the security requirements |
| `documentation_quick_start` | MUST | Document | `QUICK-START` |
| `documentation_current` | MUST | Practice | Documentation kept consistent with the current version; rule in the project's `DEFINITION-OF-DONE` |
| `documentation_achievements` | MUST | Document | `README`: links to the project's achievements |
| `accessibility_best_practices` | SHOULD | Practice | The project's sites and software following the accessibility target in `ACCESSIBILITY` |
| `maintenance_or_update` | MUST | Document | `SECURITY`: which older versions are maintained, or the upgrade path; how to upgrade, when upgrading is difficult |
| `report_tracker` | MUST | Practice | The issue tracker |
| `vulnerability_report_credit` | MUST | Practice | The credit given to reporters, for example in advisories or release notes |
| `vulnerability_response_process` | MUST | Document | `SECURITY`: the process for responding to vulnerability reports |
| `coding_standards` | MUST | Document | `CONTRIBUTING`: the coding style guides |
| `installation_common` | MUST | Practice | A common way to install and uninstall the software, described in `README` |
| `installation_development_quick` | MUST | Practice | A quick way for developers to set up the environment, tests included, described in `CONTRIBUTING` |
| `external_dependencies` | MUST | Document | Dependency manifest |
| `dependency_monitoring` | MUST | Practice | The tool or the periodic check that finds known vulnerabilities in the dependencies |
| `test_policy_mandated` | MUST | Document | `CONTRIBUTING`: the test policy |
| `tests_documented_added` | MUST | Document | `CONTRIBUTING`: the test policy |
| `implement_secure_design` | MUST | Practice | The secure design principles applied, described in arc42 section 8 |
| `signed_releases` | MUST | Document | `SECURITY`: how users obtain the signing keys and verify releases; signing itself is a practice, with its rule in the project's `DEFINITION-OF-DONE` |
| `version_tags_signed` | SUGGESTED | Practice | Signed version tags; rule in the project's `DEFINITION-OF-DONE` |
| `assurance_case` | MUST | Document | `THREAT-MODEL` |

Outside the framework: `internationalization`, `sites_password_security`, `coding_standards_enforced`, `build_standard_variables`, `build_preserve_debug`, `build_non_recursive`, `build_repeatable`, `installation_standard_variables`, `updateable_reused_components`, `interfaces_current`, `automated_integration_testing`, `regression_tests_added50`, `test_statement_coverage80`, `warnings_strict`, `crypto_weaknesses`, `crypto_algorithm_agility`, `crypto_credential_agility`, `crypto_used_network`, `crypto_tls12`, `crypto_certificate_verification`, `crypto_verification_private`, `input_validation`, `hardening`, `static_analysis_common_vulnerabilities`, `dynamic_analysis_unsafe`.

## Gold

| Criterion | Badge | Kind | Answered by |
|---|---|---|---|
| `achieve_silver` | MUST | Practice | The silver badge |
| `bus_factor` | MUST | Practice | As at silver |
| `contributors_unassociated` | MUST | Practice | Two or more significant contributors not paid by the same organisation |
| `copyright_per_file` | MUST | Practice | The copyright statement in each source file; rules in [LICENSE-POLICY](LICENSE-POLICY.md) and in the project's `DEFINITION-OF-DONE` |
| `license_per_file` | MUST | Practice | The licence statement in each source file; rules in [LICENSE-POLICY](LICENSE-POLICY.md) and in the project's `DEFINITION-OF-DONE` |
| `repo_distributed` | MUST | Practice | The version control system |
| `small_tasks` | MUST | Document | `CONTRIBUTING`: where small tasks for new or casual contributors are identified |
| `require_2FA` | MUST | Practice | Two-factor authentication required of developers, as `GOVERNANCE` states |
| `secure_2FA` | SHOULD | Practice | Two-factor authentication by cryptographic means |
| `code_review_standards` | MUST | Document | `GOVERNANCE`: the code review requirements |
| `two_person_review` | MUST | Practice | At least half of the changes reviewed before release by someone other than their author, as `GOVERNANCE` states |
| `security_review` | MUST | Practice | The latest security review, recorded in `SECURITY-REVIEW`; renewal rule in [GOVERNANCE](GOVERNANCE.md) |

Outside the framework: `build_reproducible`, `test_invocation`, `test_continuous_integration`, `test_statement_coverage90`, `test_branch_coverage80`, `crypto_used_network`, `crypto_tls12`, `hardened_site`, `hardening`, `dynamic_analysis`, `dynamic_analysis_enable_assertions`.

## Not asked by the badge

What the framework requires that no criterion asks for, or asks for only at a higher level or with a weaker strength:

- At passing: arc42 section 8; arc42 section 9 with the ADRs; `GOVERNANCE`; `CHECKLIST`; `DEFINITION-OF-DONE`; in `README`, where the project documents are and the framework tag; in `REFERENCE`, the public API.
- At silver: `ACCESSIBILITY` as a MUST; arc42 sections 1, 3, 4, 5, 6, 7, 10 and 11 with the C4 diagrams.
- In [DOCUMENTS-INDEX](DOCUMENTS-INDEX.md): where the GitHub community files go; an arc42 section linking to the other project document that holds shared content.
- In [CONVENTIONS](CONVENTIONS.md): every rule except those that the tables above name.
- In [LICENSE-POLICY](LICENSE-POLICY.md): the licence compatibility of the dependencies; the REUSE format for the per-file statements.
- In [DEFINITION-OF-DONE](DEFINITION-OF-DONE.md): every rule except those that the tables above name.
- In [GOVERNANCE](GOVERNANCE.md): every rule except those that the tables above name.
