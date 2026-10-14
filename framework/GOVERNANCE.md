# Governance

Who does what for an adopter's project documents, what the adopter records about its use of the framework, and when it reviews its project documents.

## Roles

- An adopter MUST have these two roles; one person MAY hold both:
  - **Maintainers** MUST decide, through the project's own decision process, the level, the exceptions, the additions and the move to a newer framework tag, and MUST write the project documents.
  - **Documentation Owner**: the person whom the maintainers appoint to keep the project documents complete and current. The Documentation Owner MUST keep the adopter's project `CHECKLIST`, a copy of the framework's [CHECKLIST](CHECKLIST.md); MUST run the periodic checks below; and MUST check, before each release, the release criteria of the [DEFINITION-OF-DONE](DEFINITION-OF-DONE.md) that concern project documents.

## Records

- A decision MUST be recorded by the commit that writes it into the project `CHECKLIST` or the project `GOVERNANCE`; the commit shows who recorded it and when, and no other signature is REQUIRED.
- The `CHECKLIST` log MUST record every exception, with the rule, what the adopter does instead and the reason, and every change of level, with the reason.

## Events

| Event | What the adopter MUST do |
|---|---|
| The adopter adopts the framework | Record the level; add a register row for each required document, `draft` or `active`; log each exception |
| A required document comes to hold what the level requires | Set its status to `active` |
| The level is raised | Add a `draft` row, or set its `retired` row back to `draft`, for each newly required document; set to `draft` each document that must now hold more |
| The level is lowered | Set to `retired` each document that is no longer required |
| A role holder joins or leaves | Update the role holders in the project `GOVERNANCE`, appointing a new Documentation Owner when needed; from silver, also what it says on continuity |

## Periodic checks

At least once a year, the Documentation Owner MUST:

- review as a whole each document of the register that exists and is not `retired`, and set its `reviewed` date and its status;
- re-read the exceptions with the maintainers, and log the end of each one that they decide is no longer needed;
- check whether a newer framework tag exists.

At gold, the Documentation Owner MUST also make sure that `SECURITY-REVIEW` is renewed before it is five years old.

## New framework tag

- An adopter MAY stay at its framework tag.
- When the maintainers decide to move to a newer framework tag, the Documentation Owner MUST first read the framework's release notes of every tag after the adopter's own, and then make the move in one change, which:
  - replaces the adopter's `DEFINITION-OF-DONE` with the one of the new tag;
  - copies the `CHECKLIST` of the new tag and carries over its level, register and log, as the framework's release notes say when the form of the `CHECKLIST` changed;
  - adds the documents that the [DOCUMENTS-INDEX](DOCUMENTS-INDEX.md) of the new tag newly requires, with their register rows, or sets their `retired` rows back to `draft`; sets to `draft` each document that does not yet hold what the new tag requires at its level; and sets to `retired` each document the new tag no longer requires;
  - logs each exception that ends because its rule changed, and each new exception;
  - updates the framework tag in `README` and in the links of the project documents, and the paths of those links that the framework's release notes say have changed.
