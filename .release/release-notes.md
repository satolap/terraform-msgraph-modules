Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1430 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2479 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 12 modules; 0 added, 0 removed, 3 interface-changed.
- Accepted breaking changes: 4 in 3 modules, from 1 release decision.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Conditional Access modules accept only api_version v1.0, and the policies module reports unmanaged properties that Microsoft Graph returns set
  - Decision: `2026-09-30-conditional-access-hardening.json`, approved by benhaspalace.
  - Accepted changes by kind: check_changed: 1, validation_changed: 3.
  - Accepted changes by catalog: curated: 4.
  - Migration notes: modules/curated/identity/conditional-access/policies, named-locations/ip-ranges and named-locations/countries now accept only api_version = "v1.0"; "beta" fails at plan, so remove api_version or set it to "v1.0". Switching from "beta" to "v1.0" plans one in-place update of each such resource; it sends no PATCH request and reads the object back through v1.0, so that apply fails if v1.0 cannot read an object written through beta (not verified). The new optional input timeouts keeps the previous behaviour by default (create, update and delete 10m, the provider's default read timeout), so the named location modules plan no change. Create, update and delete timeouts under 15s are rejected. The policies module adds the output unmanaged_properties_set and the check block unmanaged_properties, which warns when Microsoft Graph returns set a property that the module does not manage; such a value is lost when the module replaces the policy. After upgrading, the first plan shows one in-place update of each policy for the new read-back key; it sends no PATCH request and does not replace the policy. A terraform test run with command = plan that creates or replaces a policy through the policies module now fails with 'Check block assertion known after apply', and expect_failures cannot name a check inside a module; run it with command = apply, or, on Terraform 1.11 or later, add an override_resource for the module's msgraph_resource.policy with override_during = plan.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Curated modules:

- Interface-changed:
  - `modules/curated/identity/conditional-access/named-locations/countries`: validation_changed: 1, variable_added: 1.
  - `modules/curated/identity/conditional-access/named-locations/ip-ranges`: validation_changed: 1, variable_added: 1.
  - `modules/curated/identity/conditional-access/policies`: check_changed: 1, output_added: 1, validation_changed: 1, variable_added: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `969489fffe8e71434ea859e09b0674368477e026`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `1804d66a728122848656c21a90d943785f86e10c5f6330967b1ef9a9fec9802b`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 5/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 5/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes found by the release gate against `graphmodules-98e58792e28057d2c5d7`:

- check_changed: 1 module whose check blocks, assertions or check data sources were added or changed (blocking).
- output_added: 1 output added (notice).
- validation_changed: 3 inputs with a new or changed validation that may reject values accepted before (blocking).
- variable_added: 3 inputs added with a default, so existing configurations still plan (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-1804d66a728122848656`.
