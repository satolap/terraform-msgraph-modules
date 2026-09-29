Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1430 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2479 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 12 modules; 3 added, 0 removed, 0 interface-changed.
- Accepted breaking changes: 1 in 0 modules, from 1 release decision.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Add three curated Conditional Access modules: policies, IP named locations and country named locations
  - Decision: `2026-09-29-curated-conditional-access.json`, approved by benhaspalace.
  - Accepted changes by kind: inventory_shift: 1.
  - Accepted changes by catalog: without a module path: 1.
  - Migration notes: The curated catalog grows from 9 to 12 modules: modules/curated/identity/conditional-access/policies, modules/curated/identity/conditional-access/named-locations/ip-ranges and modules/curated/identity/conditional-access/named-locations/countries. No existing module changes, so upgrading gives no plan change. The new modules need microsoft/msgraph 0.5.0 or later and Microsoft Entra ID P1; sign-in and user risk conditions need Microsoft Entra ID P2. Policies default to report-only (enabledForReportingButNotEnforced) and always exclude break_glass_user_ids and break_glass_group_ids; set state = "enabled" only after reviewing report-only results. Adding or removing an optional part of a policy replaces it, and a trusted IP location must be set to is_trusted = false in a separate apply before it is destroyed.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Curated modules:

- Added: `modules/curated/identity/conditional-access/named-locations/countries`, `modules/curated/identity/conditional-access/named-locations/ip-ranges`, `modules/curated/identity/conditional-access/policies`.

Provenance:

- Generator commit: `af109fce0d55ef0a000ca556a88be9d340003876`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `98e58792e28057d2c5d7bb70ccaf8a2f73ddd476b7640c6dd27d5345303c4e05`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 5/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 5/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes found by the release gate against `graphmodules-eb2d5f1aa0c898e21711`:

- inventory_shift: 1 catalog whose module count grew or shrank by more than the gate's shift threshold, 10 percent by default (blocking).
- module_added: 3 modules added to the catalog (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

Verify downloads with `sha256sum -c SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-98e58792e28057d2c5d7`.
