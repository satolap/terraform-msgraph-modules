# identity-governance/entitlement-management/access-packages/resource-role-scopes

Grants an access package a specific role/scope on a catalog resource, via the
`microsoft/msgraph` Terraform provider. The folder mirrors the Graph collection it manages:
`identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes`.

This is the module that determines *what* a user gets when their access package request is
approved (e.g. "member of group X", "the Contributor app role on application Y", "Read access
on SharePoint site Z"). It's generic over `resource_origin_system` because that's the only
axis Microsoft Graph itself varies on for access package resources — there are exactly three
supported origin systems today.

## How the role is resolved

The module follows the flow Microsoft documents for this API: it lists the roles Graph
reports for the resource in the catalog
(`GET catalogs/{catalog_id}/resourceRoles?$filter=(originSystem eq '...' and resource/id eq
'...')&$expand=resource`), picks the role whose `displayName` matches `role_display_name`
(case-insensitively), and creates the role scope referencing the catalog resource by its
internal `id` with the resource's root scope. This avoids hard-coding Graph's per-origin
`originId` formats (`Member_{group_id}`, app role GUIDs, SharePoint role sequence numbers) —
if you already know the exact `originId`, pass `role_origin_id` to match on it instead.

The resource must already be in the catalog: pass the `resource_id` output of the
`catalogs/resources` module as `catalog_resource_id`. Because the value only becomes known
after the resource lands in the catalog, this also gives Terraform the correct ordering
without any `depends_on`.

If zero or multiple roles match, the apply fails with a precondition error; the module's
`available_roles` output shows everything Graph reported, for diagnosis.

## Usage

```hcl
# Entra ID group membership
module "group_member_role" {
  source = "../../modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.engineering_group_resource.resource_id
  resource_origin_system = "AadGroup"
  role_display_name      = "Member" # or "Owner"
}

# Application app role
module "app_role_assignment" {
  source = "../../modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.internal_app_resource.resource_id
  resource_origin_system = "AadApplication"
  role_display_name      = "Contributor" # the app role's display name
}

# SharePoint Online site role
module "sharepoint_site_role" {
  source = "../../modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.engineering_site_resource.resource_id
  resource_origin_system = "SharePointOnline"
  role_display_name      = "Read" # site role name, e.g. Read / Contribute / Full Control
}
```

## How create and destroy work (list-only entity)

Microsoft Graph exposes `resourceRoleScopes` as a **list-only** relationship of the access
package: the POST create works and the entry shows up in
`GET accessPackages/{id}/resourceRoleScopes`, but `GET .../resourceRoleScopes/{id}` returns
404 — while `DELETE .../resourceRoleScopes/{id}` works. A CRUD-managed `msgraph_resource`
would hang on "Still creating..." forever (its post-create read-back polls that 404 as if
the resource were still provisioning), so this module creates the role scope with a one-shot
`msgraph_resource_action` and deletes it on destroy through the ambient Azure CLI session
(`az account get-access-token` + `curl`), the same pattern as the `catalogs/resources`
module. The machine running `terraform destroy` needs Bash, the Azure CLI logged in with
`az login`, `curl`, and `ARM_TENANT_ID` set to the tenant ID the `msgraph` provider uses. The
hook targets the public cloud (`graph.microsoft.com`). Before it requests a token, it compares
`ARM_TENANT_ID` with `az account show --query tenantId` and stops if the variable is unset or
the tenants differ. The token reaches `curl` through a config on stdin, never on the command
line, so it does not appear in the process list. Missing IDs, credentials, a tenant mismatch
and unsuccessful HTTP responses fail destroy. HTTP 404 is accepted for an already absent scope
only after the tenant check passes, so a 404 from another tenant cannot hide a remaining
scope. Destroy cleanup is unsupported on Windows.

## Upgrade note: destroy cleanup requires `ARM_TENANT_ID`

`terraform destroy` now stops before deleting the role scope unless `ARM_TENANT_ID` is set on
the machine running Terraform and equals the Azure CLI tenant
(`az account show --query tenantId -o tsv`; letter case is ignored). Earlier versions sent the
`DELETE` to whichever tenant the Azure CLI was logged in to, treated a 404 from that tenant as
success, and passed the bearer token to `curl` as a command-line argument.

- **Why:** the hook authenticates with the Azure CLI, not with the provider's credentials, so
  the two can point at different tenants. A destroy-time hook can read only its own stored
  values, and a new module input would change them and replace the hook, which runs the
  cleanup. The hook therefore reads the expected tenant from `ARM_TENANT_ID`, the environment
  variable the `msgraph` provider reads for `tenant_id`
  ([provider source, v0.5.0](https://github.com/microsoft/terraform-provider-msgraph/blob/v0.5.0/internal/provider/provider.go#L303-L306),
  [provider documentation](https://registry.terraform.io/providers/microsoft/msgraph/0.5.0/docs)).
- **What to do:** export `ARM_TENANT_ID=<tenant GUID>` wherever `terraform destroy` runs,
  including CI, and log the Azure CLI in to that tenant (`az login --tenant <tenant GUID>`). If
  the `provider "msgraph"` block sets `tenant_id`, use the same value.
- **Still required:** Bash, the Azure CLI and `curl` on the machine running destroy. Destroy
  cleanup is unsupported on Windows.
- **Existing deployments:** only the hook's command changed, not its `triggers`, so upgrading
  plans no change to `null_resource.remove_on_destroy` and removes nothing. If destroy stops on
  the tenant check, the role scope stays on the access package and in state; fix the variable
  or the login and run destroy again.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |
| null | >= 3.2.0 |
| Bash, Azure CLI (`az`), `curl` and `ARM_TENANT_ID` | Required on the machine running `terraform destroy`; Windows is unsupported for destroy cleanup |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `resource_origin_system` is `"SharePointOnline"` | SHAREPOINT | Internal users who access a SharePoint Online site need an assigned license that includes SharePoint Online. Entitlement management licensing does not supply the workload entitlement, and the site must already exist. All of: SharePoint Online (any plan) (`SHAREPOINTENTERPRISE`). | Internal users who will access the site | direct / per_user | documented |

Notes:

- Privileged or eligible roles require independent feature and API verification; do not infer licensing from a role's display name.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [SharePoint Online service description](https://learn.microsoft.com/en-us/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-service-description).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| access_package_id | ID of the access package to attach this role scope to | `string` | n/a | yes |
| catalog_id | ID of the catalog containing the access package and resource | `string` | n/a | yes |
| catalog_resource_id | Catalog-internal accessPackageResource ID (`resource_id` output of `catalogs/resources`) | `string` | n/a | yes |
| resource_origin_system | `AadGroup`, `AadApplication`, or `SharePointOnline` | `string` | n/a | yes |
| role_display_name | Display name of the role to grant (matched case-insensitively) | `string` | n/a | yes |
| role_origin_id | Optional exact originId to match instead of the display name | `string` | `null` | no |
| scope_origin_id | Origin ID of the scope; defaults to the resource's root scope | `string` | `null` | no |
| scope_display_name | Display name of the scope; defaults to `"Root"` | `string` | `null` | no |
| enable_destroy_cleanup | Create the Azure CLI removal hook; disable only before first apply for tests or externally managed cleanup | `bool` | `true` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the resource role scope |
| access_package_id | The ID of the parent access package |
| role_origin_id | The resolved origin ID of the granted role |
| resource_origin_id | The resource's origin ID, from the catalog's resourceRoles list |
| available_roles | All roles Graph reported for the resource (for diagnosing a failed match) |

## Tests

`terraform test` runs offline unit tests (`tests/resource_role_scope.tftest.hcl`) that mock
the `msgraph` provider — they assert the role lookup/matching (by display name and by
originId), the documented request body shape (`role.resource.id`, root scope), custom
sub-scopes, and missing/ambiguous matches. Tests require Terraform 1.7 or later and
set `enable_destroy_cleanup=false`: provider mocks do not suppress provisioners.

See [live test setup and lifecycle limits](../../../../../docs/test-tenant-setup.md).
