# Security policy

How to report a security problem in this repository, and what happens next.

## What to report, and where

This repository holds documentation and scripts that check it. Adopters copy or read its framework documents at a framework tag ([README](README.md#adopting-the-framework)).

- Reporters SHOULD report privately:
  - any sign that the repository or its framework tags have been tampered with, or that a maintainer's account has been compromised;
  - a link in a framework document that now leads to malicious content;
  - a secret or personal data found in the repository or its history.
- Reporters SHOULD report in the [issues](https://github.com/fabrizioiacobucci/foss-docs-made-simple/issues) an error in the framework that could weaken an adopter's security, such as a criterion of the OpenSSF Best Practices Badge that the framework requires at a lower strength than the badge does. Such an error is a defect of the framework, already public in its documents, not a vulnerability of this repository.
- Reporters SHOULD report a vulnerability in an adopter's software to that adopter.

## How to report privately

Reporters SHOULD use [Report a vulnerability](https://github.com/fabrizioiacobucci/foss-docs-made-simple/security/advisories/new) in this repository. Only the maintainers and the reporter see the report. It needs a GitHub account; this repository has no other private channel.

## First response

The maintainers MUST send a first response to a private report within 14 days.
