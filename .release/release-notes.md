Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1410 modules; 0 added, 20 removed, 0 interface-changed.
- beta: 2399 modules; 0 added, 80 removed, 0 interface-changed.
- curated: 12 modules; 0 added, 0 removed, 0 interface-changed.
- Accepted breaking changes: 100 in 100 modules, from 1 release decision.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Stop publishing modules whose update or delete needs an If-Match ETag header that msgraph_resource cannot send
  - Decision: `2026-10-01-if-match-schema-exclusions.json`, approved by benhaspalace.
  - Accepted changes by kind: module_removed: 100.
  - Accepted changes by catalog: v1.0: 20, beta: 80.
  - Migration notes: 100 generated modules are no longer published, 20 in v1.0 and 80 in beta. Microsoft Graph requires an If-Match header with the object's current ETag to update or delete Planner plans, tasks and buckets (https://learn.microsoft.com/en-us/graph/api/plannerplan-update, https://learn.microsoft.com/en-us/graph/api/plannertask-update, https://learn.microsoft.com/en-us/graph/api/plannerbucket-update and their delete pages), delegated admin relationships and access assignments, and, in beta only, business scenario Planner tasks, Teams sections and section items, and the Business Central collections under financials/companies (country or region, currency, customer, customer payment, customer payment journal, employee, item, item category, journal, journal line, payment method, payment term, shipment method, tax area, tax group, unit of measure and vendor). msgraph_resource in the Microsoft/msgraph provider sends no request headers on update or delete, so these modules could create and read an object, but later changes and destroys fail. Each catalog's manifest.json lists the excluded collections under exclusions with reason_code if_match_required, and the release asset interface-changes.json lists every removed module. No replacement module is published. Before upgrading, stop managing each existing object without deleting it. Either add a removed block with from = module.&lt;name&gt; and lifecycle { destroy = false } (Terraform 1.7 or later, the minimum version of these modules), or run terraform state rm module.&lt;name&gt;.msgraph_resource.this. Then delete the module block and manage the object outside these modules. If you keep the old module block, terraform init fails on the new release ('Failed to expand subdir globs' on Terraform 1.7.5). Both the removed block and the failing init were checked offline with Terraform 1.7.5.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `6a68c7ba75094b04ea8b5cf52abee1d4f9070d6a`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `59a4cae78d14be98f10544806803954f2d3cc5c68751f9e1db7d85ff9faa9992`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1410/1410, contract_reviewed 6/1410, lifecycle_verified 0/1410
- beta: schema_validated 2399/2399, contract_reviewed 6/2399, lifecycle_verified 0/2399

Contract/interface and evidence changes found by the release gate against `graphmodules-ef8abfd72f69d722705c`:

- module_removed: 100 modules removed from the catalog (blocking).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-59a4cae78d14be98f105`.
