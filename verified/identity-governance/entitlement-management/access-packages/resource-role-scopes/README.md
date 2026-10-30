# identity-governance/entitlement-management/access-packages/resource-role-scopes

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

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

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

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

## Native create, destroy and recovery

The ignore-all POST creates once; changing its creation inputs replaces it
destroy-first. The provider cannot GET a role scope by ID. An independent GET
of the access package expands `resourceRoleScopes($expand=role,scope)` and
requires exactly the returned created ID, matching role and scope identity as returned by the documented expansion (the role's resource is not expanded)
and no pagination before registering `msgraph_resource_action.remove[0]`.
The GET alone retries 404 / NotFound / Request_ResourceNotFound for at most two
minutes; an empty collection fails closed and needs another unchanged apply.
`enable_destroy_cleanup = false` leaves verification and removal to an external
owner. It is intended only before first apply; disabling registered cleanup
runs its removal. The old `null_resource.remove_on_destroy[0]` remains as an
inert saved-identity record with unchanged triggers, so upgrades retain its ID.

The destroy-only action sends DELETE to the saved role-scope ID using provider
credentials. No Bash, Azure CLI or curl is needed. Registration sends no write.
Accepted limitation: no destroy-time identity re-check or absence proof; guard
state and coordinate a single writer. Registration validates URL segments; it is
not a destroy-time state integrity check. Direct edits to action state are
unsupported. Unlike the old script, native DELETE does not tolerate 404 when an
out-of-band deletion has already removed the parent access package. The pinned
provider has no ignore-404 or successful-error override; retrying that 404 does
not turn it into success. This migration limitation requires owner acceptance:
independently confirm exact parent-package GET 404 (or complete expanded scope
absence on an existing package), then use the confirmed-absence state-rm
recovery below. A denied read or replication 404 immediately after create is not
proof that the parent was removed.

Verification remains a data source, not a one-time check. Every refresh-enabled
plan or apply runs the verification GET again, even after removal registration.
A later 404, missing or mismatched identity can therefore fail routine plans.
Failure does not revoke access or unregister an existing remove action.
Reconcile the saved identity; never taint or replay the successful POST to
repair a read. For cleanup after independently confirmed absence, use the state-
rm recovery below and finish `terraform destroy -refresh=false`; this skips
failing refresh reads and does not establish ownership or revoke access by
itself.

Back up state privately. **Upgrade with an unchanged apply before any destroy,
identity change or replacement**, confirming the POST and legacy record retain
their IDs and the native remove action stores the existing item URL. Merely
updating configuration does not register removal. Destroy before registration
can orphan the scope with nothing in state to delete it. This sequencing is
not enforced by a state-presence check.

If verification fails after POST, **re-run apply with unchanged inputs; never
use destroy as recovery**. Preserve the successful POST state and retry the GET
without replaying POST. An ambiguous POST requires owner investigation first.
For manual recovery, independently GET the saved package with the same expand,
require the exact captured scope ID and matching role and scope (the role's resource is not expanded),
then DELETE only that saved scope route. Never select a substitute by label.
Confirm absence from a complete expanded collection before retrying creation.
If registered DELETE fails for an absent scope, first independently confirm
that exact ID is absent from a complete collection, or its parent package
is independently confirmed absent, in the provider tenant;
then `terraform state rm 'module.scope.msgraph_resource_action.remove[0]'`
and finish `terraform destroy -refresh=false`. Do not re-apply between state
removal and completing destroy. Denied or incomplete reads prove no absence.

Owner-dispatched live acceptance: verify the selected provider's destroy-only
schema on each platform; create a disposable scope, inspect independent
expanded identity, confirm unchanged apply and legacy upgrade are no-ops;
exercise replication/denied reads and retry apply without a second POST;
replace role/package/scope and confirm old removal precedes new creation;
destroy and independently confirm exact-ID absence and unrelated scopes
unchanged. Exercise already absent DELETE and the confirmed-absence recovery.
Retain only sanitized evidence. Offline mocks do not prove HTTP transport.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |
| null | >= 3.2.0 |

The configuring identity/application needs the `EntitlementManagement.ReadWrite.All`
Microsoft Graph permission. For Azure roles, Microsoft also lists Azure RBAC
`Microsoft.Authorization/roleDefinitions/read` at the assignment scope.

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

Before deployment, check the requirements of the features you enable and the users who benefit. You can inspect tenant subscriptions with `GET /subscribedSkus`; this requires `Organization.Read.All` or `LicenseAssignment.Read.All` ([List subscribedSkus](https://learn.microsoft.com/en-us/graph/api/subscribedsku-list?view=graph-rest-1.0)).

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

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| access_package_id | ID of the access package to attach this role scope to | `string` | n/a | yes | replaces `msgraph_resource_action.resource_role_scope`; changes `null_resource.remove_on_destroy`; see the module notes |
| catalog_id | ID of the catalog containing the access package and resource | `string` | n/a | yes | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| catalog_resource_id | Catalog-internal accessPackageResource ID (`resource_id` output of `catalogs/resources`) | `string` | n/a | yes | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| resource_origin_system | `AadGroup`, `AadApplication`, `SharePointOnline`, or `AzureResources` | `string` | n/a | yes | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes; changes `null_resource.remove_on_destroy`; see the module notes |
| role_display_name | Display name of the role to grant (matched case-insensitively; sent as given for Azure roles) | `string` | n/a | yes | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| role_origin_id | Optional exact originId to match instead of the display name; for Azure roles, the full role definition ID sent verbatim | `string` | `null` | no | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| role_definition_id | Azure roles only: the role definition GUID (set this or `role_origin_id`) | `string` | `null` | no | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| role_type | Azure roles only, required there: `active` or `eligible` | `string` | `null` | no | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| scope_origin_id | Origin ID of the scope; defaults to the resource's root scope. For Azure roles, a listed resource group of the subscription | `string` | `null` | no | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| scope_display_name | Display name of the scope; defaults to `"Root"`, or for Azure roles to the name Graph lists | `string` | `null` | no | replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes |
| enable_destroy_cleanup | Register provider-native removal after independent verification; disable only before first apply for externally owned cleanup | `bool` | `true` | no | changes `null_resource.remove_on_destroy`; see the module notes; creates or deletes `msgraph_resource_action.remove` instances |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | replaces `msgraph_resource_action.resource_role_scope`; changes `null_resource.remove_on_destroy`; see the module notes |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| id | The ID of the resource role scope | no |
| access_package_id | The ID of the parent access package | yes |
| role_origin_id | The resolved origin ID of the granted role | no |
| resource_origin_id | The resource's origin ID, from the catalog's resourceRoles list | no |
| available_roles | All roles Graph reported for the resource (for diagnosing a failed match); empty for Azure roles | no |
| available_scopes | Azure roles only: the scopes Graph lists for the catalog resource (for diagnosing a failed scope match) | no |

## Tests

`terraform test` runs offline unit tests that mock the `msgraph` provider.
`tests/resource_role_scope.tftest.hcl` asserts the role lookup/matching (by display name and
by originId), the documented request body shape (`role.resource.id`, root scope), custom
sub-scopes, missing/ambiguous matches, and that bodies for these origin systems keep their
earlier fields. `tests/azure_role_scope.tftest.hcl` asserts Azure roles: the role definition
origin ID for a subscription and a management group, active and eligible role types, root
and resource group scopes, and the refusals of missing or conflicting inputs and unlisted
scopes. Tests require Terraform 1.11 or later and
use mocked Graph transport. Native cleanup and legacy upgrade suites also run with cleanup enabled.

See [live test setup and lifecycle limits](../../../../../docs/test-tenant-setup.md).

<!-- drift:start -->
## Drift and out-of-band changes

Terraform plans compare configuration and refreshed provider state. A plan that changes one of these inputs proposes its declared effect; review the plan before applying. The consumer guide explains refresh limits and emergency reconciliation.

- `enable_destroy_cleanup`: changes `null_resource.remove_on_destroy`; see the module notes; creates or deletes `msgraph_resource_action.remove` instances.
- `access_package_id`: replaces `msgraph_resource_action.resource_role_scope`; changes `null_resource.remove_on_destroy`; see the module notes.
- `catalog_id`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `catalog_resource_id`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `resource_origin_system`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes; changes `null_resource.remove_on_destroy`; see the module notes.
- `role_display_name`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `role_origin_id`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `role_definition_id`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `role_type`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `scope_origin_id`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `scope_display_name`: replaces `msgraph_resource_action.resource_role_scope` when its effect on `local.body` changes.
- `api_version`: replaces `msgraph_resource_action.resource_role_scope`; changes `null_resource.remove_on_destroy`; see the module notes.
<!-- drift:end -->
