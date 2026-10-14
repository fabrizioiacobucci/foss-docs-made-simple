# Licence policy

Which licences an adopter releases its software under, which licences it accepts from its dependencies, and how it obtains assurance about the right to its contributions.

## Outbound licence

- An adopter's software MUST be released under at least one free and open-source licence; it MAY also be offered under other licences.
- It is SUGGESTED that each free and open-source licence of the software be approved by the [Open Source Initiative](https://opensource.org/licenses).
- The full text of every licence under which the software is released MUST be in the adopter's repository.

## Per-file statements

- At gold, every source file MUST contain a copyright statement that names the copyright holder, and a licence statement.
- At gold, these statements SHOULD use the format of the [REUSE specification 3.3](https://reuse.software/spec-3.3/).

## Dependencies

- Every dependency that is part of what the adopter distributes MUST be under a licence compatible with every licence under which the adopter releases its software.
- Such a dependency whose licence is unknown MUST be treated as incompatible until its licence is known.

The [FSF licence list](https://www.gnu.org/licenses/license-list.html) is one source that states, licence by licence, compatibility with the GNU GPL.

## Contributions

- From silver, an adopter SHOULD require every contributor of non-trivial changes to assert that they are legally authorised to make them, through the DCO or another legal mechanism such as a CLA.
