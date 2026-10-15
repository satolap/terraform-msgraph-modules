Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1411 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2400 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 17 modules; 17 added, 0 removed, 0 interface-changed.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Curated modules:

- Added: `modules/curated/applications`, `modules/curated/directory/administrative-units`, `modules/curated/groups/members`, `modules/curated/groups`, `modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes`, `modules/curated/identity-governance/entitlement-management/access-packages`, `modules/curated/identity-governance/entitlement-management/assignment-policies`, `modules/curated/identity-governance/entitlement-management/catalogs/custom-extensions`, `modules/curated/identity-governance/entitlement-management/catalogs/resources`, `modules/curated/identity-governance/entitlement-management/catalogs`, `modules/curated/identity-governance/entitlement-management/connected-organizations`, `modules/curated/identity/conditional-access/named-locations/countries`, `modules/curated/identity/conditional-access/named-locations/ip-ranges`, `modules/curated/identity/conditional-access/policies`, `modules/curated/naming`, `modules/curated/service-principals`, `modules/curated/users`.

Provenance:

- Generator commit: `ab23038d16c1be142ff0adf5a5606a7e09400aaa`
- Microsoft Graph metadata commit: `fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `b02867cb52d8db146f6247691db6bbfd0478fd189e3c46c5f72dcc2129b7f370`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1411/1411, contract_reviewed 6/1411, lifecycle_verified 0/1411
- beta: schema_validated 2400/2400, contract_reviewed 6/2400, lifecycle_verified 0/2400

Contract/interface and evidence changes found by the release gate against `v1.0.0`:

- module_added: 17 modules added to the catalog (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "1.1.0"`.
