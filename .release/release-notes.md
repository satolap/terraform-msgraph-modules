Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1411 modules; 0 added, 0 removed, 1411 renamed, 0 interface-changed.
- beta: 2400 modules; 5 added, 5 removed, 2390 renamed, 5 interface-changed.
- curated: 17 modules; 0 added, 0 removed, 1 interface-changed.
- Accepted breaking changes: 3828 in 3812 modules, from 2 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Refuse grant_controls.operator AND with a single grant control in the Conditional Access policy module
  - Decision: `2026-10-12-ca-and-single-grant-control.json`, approved by benhaspalace.
  - Accepted changes by kind: precondition_changed: 1.
  - Accepted changes by catalog: curated: 1.
  - Migration notes: curated/identity/conditional-access/policies gains a plan-time precondition: grant_controls.operator = "AND" now needs at least two grant controls; built-in controls, terms of use and an authentication strength count together. Microsoft Graph keeps OR for a single grant control, so AND with one control planned a permanent difference; it now fails at plan with an error that explains this. Set operator to "OR", or add a second grant control.
- Publish every module at its Microsoft Graph route as the first versioned release
  - Decision: `2026-10-12-flat-registry-layout.json`, approved by benhaspalace.
  - Accepted changes by kind: endpoint_changed: 5, module_removed: 5, module_renamed: 3801, schema_changed: 1, variable_default_changed: 1, variable_removed: 14.
  - Accepted changes by catalog: v1.0: 1411, beta: 2416.
  - Migration notes: This is the first versioned release, v1.0.0, of the Terraform Registry module satolap/modules/msgraph; earlier releases were tagged with input fingerprints and are withdrawn. The catalogs moved to the repository root: generated modules are at &lt;api-version&gt;/&lt;graph-route&gt; and curated modules at curated/&lt;module-path&gt;, so a registry source reads satolap/modules/msgraph//v1.0/&lt;graph-route&gt;, satolap/modules/msgraph//beta/&lt;graph-route&gt; or satolap/modules/msgraph//curated/&lt;module-path&gt;, with a version. A generated module's directory is its Graph route without the documentation category it was filed under before: modules/generated/v1.0/applications/applications is now v1.0/applications, and modules/generated/v1.0/mail/users/by-user-id/messages is now v1.0/users/by-user-id/messages. Categories group modules in each catalog README. Five beta security modules moved onto paths that earlier releases used for other endpoints: the sensitivity-labels module of /security/informationProtection/sensitivityLabels is now beta/security/information-protection/sensitivity-labels and that of /informationProtection/sensitivityLabels is beta/information-protection/sensitivity-labels; the four /security/threatSubmission modules are under beta/security/threat-submission and the four /threatSubmission modules under beta/threat-submission. No module interface changed. To move a configuration from an earlier release, change each source to the new path and add a version; keep the module block names so Terraform keeps the existing state.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Curated modules:

- Interface-changed:
  - `modules/curated/identity/conditional-access/policies`: precondition_changed: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `e113fad58c35519ab88084400bdf208e06d7c511`
- Microsoft Graph metadata commit: `fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `c398658bdc295e9049b2b0c64a8669d16589e77b29d05c87e38cdd57161fd6ed`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1411/1411, contract_reviewed 6/1411, lifecycle_verified 0/1411
- beta: schema_validated 2400/2400, contract_reviewed 6/2400, lifecycle_verified 0/2400

Contract/interface and evidence changes found by the release gate against `graphmodules-b804e648b78e233dec44`:

- endpoint_changed: 5 modules whose Graph collection or item path changed (blocking).
- module_added: 5 modules added to the catalog (notice).
- module_removed: 5 modules removed from the catalog (blocking).
- module_renamed: 3801 modules moved to a new path that serves the same Graph endpoint (blocking).
- precondition_changed: 1 module whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- schema_changed: 1 module whose Graph request type changed (blocking).
- variable_added: 6 inputs added with a default, so existing configurations still plan (notice).
- variable_default_changed: 1 input whose default changed, so leaving the input unset now gives a different value (blocking).
- variable_removed: 14 inputs removed; setting a removed input fails at plan time (blocking).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "1.0.0"`.
