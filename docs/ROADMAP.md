# Roadmap

What this repository intends to do, and not do, from October 2026 to the end of 2027. It is reviewed at least once a year.

## Will do

- Add the following, in this order, each with its own minor framework tag:
  - modules that an adopter takes on by choice, such as an API contract, service levels or a mobile client, and the mechanism that defines them;
  - personal data, under the EU General Data Protection Regulation;
  - artificial intelligence, under the EU Artificial Intelligence Act;
  - open-source software stewards, under the EU Cyber Resilience Act;
  - software supplied in the course of a commercial activity: the Cyber Resilience Act, the European Accessibility Act and record retention.
- Pilot `v0.2.0` on two adopters for one release cycle, measuring the hours spent on each project document, to write it and to keep it current, the documents nobody reads and the problems caused by missing documents, and adjust the framework to the results.
- Automate what can be automated: filling the register of an adopter's `CHECKLIST` for its level, checking the release criteria of [framework/DEFINITION-OF-DONE.md](../framework/DEFINITION-OF-DONE.md) that concern project documents, and moving an adopter to a newer framework tag as [framework/GOVERNANCE.md](../framework/GOVERNANCE.md) describes.
- Read the details of every criterion of the OpenSSF Best Practices Badge, and correct [framework/BADGE-MAP.md](../framework/BADGE-MAP.md) where they change a mapping.

## Will not do

- Set rules on how code is written, built or tested beyond those the framework already states.
- Cover sector legislation, such as health, automotive, aviation, finance or the entities of the NIS2 Directive.
- Cover high-risk AI systems or general-purpose AI models under the Artificial Intelligence Act, until an adopter needs it.
- Add an organisation layer shared by several projects, until a pilot asks for it (see the README, "Other rules").
