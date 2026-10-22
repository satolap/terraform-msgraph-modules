# identity-governance/entitlement-management/access-packages/resource-role-scopes

Grants an access package a specific role/scope on a catalog resource, via the
`microsoft/msgraph` Terraform provider. The folder mirrors the Graph collection it manages:
`identityGovernance/entitlementManagement/accessPackages/{id}/resourceRoleScopes`.

This is the module that determines *what* a user gets when their access package request is
approved (e.g. "member of group X", "the Contributor app role on application Y", "Read access
on SharePoint site Z", "eligible Reader on resource group R"). It's generic over
`resource_origin_system` because that's the axis Microsoft Graph itself varies on for access
package resources: `AadGroup`, `AadApplication`, `SharePointOnline` and `AzureResources`.

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

## Azure RBAC roles

With `resource_origin_system = "AzureResources"`, the access package grants an Azure role on a
subscription or management group that the `catalogs/resources` module added to the catalog
([Microsoft Learn](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-azure-role-assignments)).
Azure roles cannot use the lookup above: Graph answers the `resourceRoles` query for
`AzureResources` with HTTP 400 `FunctionNotSupportedForOriginSystem`, and a catalog resource's
expanded `roles` hold only the roles that some access package already grants (both observed in
a licensed tenant on 2026-10-12). The portal reads role definitions from Azure Resource
Manager, which this provider cannot call. So for Azure roles:

- **Role:** set `role_definition_id` to the role definition GUID: the ID that
  [Azure built-in roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
  lists for each role, or the `name` that `az role definition list --name <role name>`
  returns. The module builds the origin ID from Microsoft's
  [examples](https://learn.microsoft.com/en-us/graph/api/accesspackage-post-resourcerolescopes?view=graph-rest-1.0#example-4-add-an-active-subscription-scoped-to-a-resource-group-resource-role-to-an-access-package):
  - For a subscription: `/subscriptions/<subscription GUID>/providers/Microsoft.Authorization/roleDefinitions/<GUID>`.
    Azure Resource Manager addresses a role definition at any scope where it can be assigned
    ([Role Definitions - Get](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles-rest#list-a-custom-role-definition-by-id)),
    so this form also fits a custom role defined on a parent management group.
  - For a management group: `/providers/Microsoft.Authorization/roleDefinitions/<GUID>`, the
    form Microsoft shows for a built-in role. A custom role that is assignable only on the
    management group is not assignable at the tenant root, so for one set `role_origin_id`
    to the `id` that `az role definition list --scope <management group ID> --name <role name>`
    returns, instead of `role_definition_id`.

  `role_origin_id` sends any full ID verbatim. Custom roles are not yet verified live.
  `role_display_name` is sent as the role's display name; the module cannot check it against
  Azure, so use the role's Azure name.
- **Role type:** `role_type` is required: `"active"` for a standing role assignment, or
  `"eligible"` for one the user activates through Privileged Identity Management when needed.
  Other origin systems refuse it, because Graph supports these types only for Azure roles.
- **Scope:** the module reads the catalog resource
  (`GET catalogs/{catalog_id}/resources?$filter=id eq '...'&$expand=scopes`) and sends the scope
  as Graph lists it, with its `id`. Leave `scope_origin_id` null for the root scope of the
  subscription or management group, or set it to a resource group in the subscription,
  `/subscriptions/<subscription GUID>/resourceGroups/<name>` (letter case is ignored). The
  scopes Graph lists are in the `available_scopes` output. A management group offers only its
  root scope, matching Microsoft's
  [supported scenarios](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-azure-role-assignments#supported-scenarios).
  If a resource group you expect is missing, check that it exists in the subscription; the
  [refresh](https://learn.microsoft.com/en-us/graph/api/accesspackageresource-refresh?view=graph-rest-1.0)
  action rereads a catalog resource from its origin system.
- **Azure permissions:** Microsoft states that the identity adding an Azure role to an access
  package needs `Microsoft.Authorization/roleDefinitions/read` at the assignment scope.
- **Live status:** the subscription role ID form, the role type and the resource group scope
  shape match an existing role scope in a licensed tenant. The management group
  role ID form follows Microsoft's example and has not been checked live.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
# Entra ID group membership
module "group_member_role" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/access-packages/resource-role-scopes"
  version = "<version>"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.engineering_group_resource.resource_id
  resource_origin_system = "AadGroup"
  role_display_name      = "Member" # or "Owner"
}

# Application app role
module "app_role_assignment" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/access-packages/resource-role-scopes"
  version = "<version>"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.internal_app_resource.resource_id
  resource_origin_system = "AadApplication"
  role_display_name      = "Contributor" # the app role's display name
}

# SharePoint Online site role
module "sharepoint_site_role" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/access-packages/resource-role-scopes"
  version = "<version>"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.engineering_site_resource.resource_id
  resource_origin_system = "SharePointOnline"
  role_display_name      = "Read" # site role name, e.g. Read / Contribute / Full Control
}

# Azure RBAC role, eligible through Privileged Identity Management, on one resource group
module "platform_reader_eligible" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/access-packages/resource-role-scopes"
  version = "<version>"

  access_package_id      = module.engineering_access.id
  catalog_id             = module.engineering_catalog.id
  catalog_resource_id    = module.platform_subscription_resource.resource_id
  resource_origin_system = "AzureResources"
  role_display_name      = "Reader"
  role_definition_id     = var.reader_role_definition_id # Reader's ID from Azure built-in roles
  role_type              = "eligible"                    # or "active"
  scope_origin_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-platform"
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
| terraform | >= 1.11.0 |
| msgraph | >= 0.3.0 |
| null | >= 3.2.0 |
| Bash, Azure CLI (`az`), `curl` and `ARM_TENANT_ID` | Required on the machine running `terraform destroy`; Windows is unsupported for destroy cleanup |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission. For Azure roles, Microsoft also lists Azure RBAC
`Microsoft.Authorization/roleDefinitions/read` at the assignment scope.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `resource_origin_system` is `"SharePointOnline"` | SHAREPOINT | Internal users who access a SharePoint Online site need an assigned license that includes SharePoint Online. Entitlement management licensing does not supply the workload entitlement, and the site must already exist. All of: SharePoint Online (any plan) (`SHAREPOINTENTERPRISE`). | Internal users who will access the site | direct / per_user | documented |
| `resource_origin_system` is `"AzureResources"` | EM-AZURE-ROLES | Granting active or eligible Azure RBAC roles at a management group, subscription or resource group through entitlement management requires Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. The Azure subscription or management group must already exist, and its Azure costs are separate. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment that grants the Azure role; eligible roles are activated through Privileged Identity Management, whose users need the same coverage | group_based / per_user | documented |

Notes:

- Privileged or eligible roles require independent feature and API verification; do not infer licensing from a role's display name.
- An eligible Azure role is activated through Privileged Identity Management; review the role's Privileged Identity Management settings, such as activation approval, before an access package grants it.
- The Azure resource role rules were reviewed against Microsoft Learn on 2026-10-12, which is later than the review date stated above.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [SharePoint Online service description](https://learn.microsoft.com/en-us/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-service-description), [Assign Azure role-based access control (RBAC) roles with entitlement management](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-azure-role-assignments#prerequisites), [Microsoft Entra ID Governance licensing fundamentals: Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#privileged-identity-management).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| access_package_id | ID of the access package to attach this role scope to | `string` | n/a | yes |
| catalog_id | ID of the catalog containing the access package and resource | `string` | n/a | yes |
| catalog_resource_id | Catalog-internal accessPackageResource ID (`resource_id` output of `catalogs/resources`) | `string` | n/a | yes |
| resource_origin_system | `AadGroup`, `AadApplication`, `SharePointOnline`, or `AzureResources` | `string` | n/a | yes |
| role_display_name | Display name of the role to grant (matched case-insensitively; sent as given for Azure roles) | `string` | n/a | yes |
| role_origin_id | Optional exact originId to match instead of the display name; for Azure roles, the full role definition ID sent verbatim | `string` | `null` | no |
| role_definition_id | Azure roles only: the role definition GUID (set this or `role_origin_id`) | `string` | `null` | no |
| role_type | Azure roles only, required there: `active` or `eligible` | `string` | `null` | no |
| scope_origin_id | Origin ID of the scope; defaults to the resource's root scope. For Azure roles, a listed resource group of the subscription | `string` | `null` | no |
| scope_display_name | Display name of the scope; defaults to `"Root"`, or for Azure roles to the name Graph lists | `string` | `null` | no |
| enable_destroy_cleanup | Create the Azure CLI removal hook; disable only before first apply for tests or externally managed cleanup | `bool` | `true` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the resource role scope |
| access_package_id | The ID of the parent access package |
| role_origin_id | The resolved origin ID of the granted role |
| resource_origin_id | The resource's origin ID, from the catalog's resourceRoles list |
| available_roles | All roles Graph reported for the resource (for diagnosing a failed match); empty for Azure roles |
| available_scopes | Azure roles only: the scopes Graph lists for the catalog resource (for diagnosing a failed scope match) |

## Tests

`terraform test` runs offline unit tests that mock the `msgraph` provider.
`tests/resource_role_scope.tftest.hcl` asserts the role lookup/matching (by display name and
by originId), the documented request body shape (`role.resource.id`, root scope), custom
sub-scopes, missing/ambiguous matches, and that bodies for these origin systems keep their
earlier fields. `tests/azure_role_scope.tftest.hcl` asserts Azure roles: the role definition
origin ID for a subscription and a management group, active and eligible role types, root
and resource group scopes, and the refusals of missing or conflicting inputs and unlisted
scopes. Tests require Terraform 1.11 or later and
set `enable_destroy_cleanup=false`: provider mocks do not suppress provisioners.

See [live test setup and lifecycle limits](../../../../../docs/test-tenant-setup.md).
