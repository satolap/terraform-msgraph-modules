# identity-governance/entitlement-management/catalogs/resources

<!-- uses-beta:start -->
Uses beta: **optional**. Beta is an optional api_version selection for compatibility; no beta-only capability is required by this module's contract. Prefer v1.0. Beta is preview and may change without notice. Pin module and provider versions; read `interface-changes.json` before upgrading.
<!-- uses-beta:end -->

<!-- live-status:start -->
Assurance: **verified offline-only**. No current live acceptance is recorded for this module.

![live: offline only](https://img.shields.io/badge/live-offline%20only-lightgrey)
<!-- live-status:end -->

Adds an Entra ID group, application (service principal), SharePoint Online site, or Azure
subscription or management group to an entitlement management catalog, via the
`microsoft/msgraph` Terraform provider. The folder mirrors the Graph collection it manages:
`identityGovernance/entitlementManagement/catalogs/{id}/resources`.

## Native request lifecycle

Graph changes catalog resources with `resourceRequests` adminAdd/adminRemove
POSTs; the request itself supports no DELETE. `add_request` sends adminAdd once
with `ignore_changes = all`. Identity changes replace destroy-first through
`add_target`; display-name-only edits no longer replay adminAdd. After the
configured delay, an independent filtered catalog GET requires exactly one
URL-safe resource ID, matching originId/originSystem and no pagination before
registering cleanup. The GET alone retries 404 / NotFound /
Request_ResourceNotFound for at most two minutes. Empty or mismatched results
fail closed when cleanup is enabled even if fail_on_verification_mismatch is
false. No existing-resource discovery or adoption guarantee is added: this is
the original adminAdd plus unique-origin ownership contract, with one writer.

The legacy `null_resource.remove_on_destroy[0]` retains its exact triggers as an
inert identity record. `msgraph_resource_action.remove[0]` saves the catalog and
internal resource ID, and sends **POST adminRemove**, never DELETE, only during
destroy/replacement with provider credentials. Bash, Azure CLI and curl are no
longer required. Registration sends no write. Removal is asynchronous; acceptance
does not prove completion. There is no destroy-time identity re-check or
absence proof. Remove access packages that use this resource first, with an
explicit depends_on on these resource modules; Graph can refuse removal while
packages remain or replication settles. Errors retain the action for another
destroy after reconciliation. The native remove action retries error-envelope
codes / explicit HTTP status diagnostics for 400, 409, 429 and 5xx (including
BadRequest, Conflict and standard transient Graph code names), bounded by
`timeouts.delete = "2m"`. The provider also retries its built-in transient set.
This replaces the old six-attempt, 20-second shell cadence; it does not retry
401, 403 or 404, suppress absence errors, or retry accepted responses. Unknown
error shapes may not match; a refusal lasting beyond the timeout needs owner
reconciliation and another destroy after the package is gone. Do not blindly
replay an ambiguous accepted adminRemove; confirm delivery first.

## Azure subscriptions and management groups

With `resource_origin_system = "AzureResources"`, the module adds an Azure subscription or
management group, so that access packages in the catalog can grant its Azure RBAC roles
([Microsoft Learn](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-azure-role-assignments)).
Grant the roles with the `access-packages/resource-role-scopes` module.

- **Origin ID:** the Azure resource ID, `/subscriptions/<subscription GUID>` or
  `/providers/Microsoft.Management/managementGroups/<management group ID>`, for example the
  `id` of an `azurerm_subscription` or `azurerm_management_group` data source. The module
  derives the request's `resourceType` (`Subscription` or `ManagementGroup`) from this format,
  as in Microsoft's
  [examples](https://learn.microsoft.com/en-us/graph/api/entitlementmanagement-post-resourcerequests?view=graph-rest-1.0#example-6-add-a-management-group-resource-to-catalog),
  and refuses any other ID before it sends a request. Graph matches origin IDs without regard
  to letter case.
- **Resource groups:** a resource group cannot be added to a catalog. Add its subscription;
  Graph then lists the subscription's resource groups as scopes that a role can target.
- **Azure permissions:** entitlement management checks that the identity adding the resource
  can manage role assignments at that scope
  (`Microsoft.Authorization/roleAssignments/read`, `write` and `delete`), for example through
  the Role Based Access Control Administrator, User Access Administrator or Owner role.
  Without them the add fails.
- **Licensing:** Azure resource roles need Microsoft Entra ID Governance or Microsoft Entra
  Suite, not Microsoft Entra ID P2 alone; see the licensing section below.

Verification remains a data source, not a one-time check. Every refresh-enabled
plan or apply runs the verification GET again, even after removal registration.
A later 404, missing or mismatched identity can therefore fail routine plans.
Failure does not revoke access or unregister an existing remove action.
Reconcile the saved identity; never taint or replay the successful POST to
repair a read. For cleanup after independently confirmed absence, use the state-
rm recovery below and finish `terraform destroy -refresh=false`; this skips
failing refresh reads and does not establish ownership or revoke access by
itself.

## Upgrade and recovery

Back up state privately and run an **unchanged apply before destroy or identity
replacement**. Verify the adminAdd and legacy null resource IDs are unchanged,
and the native remove action holds the existing catalog/resource IDs. Merely
updating configuration does not register cleanup; destroy can leave a catalog
resource with nothing in state to delete it. This sequencing is not enforced
by a state-presence check.

After successful adminAdd but failed verification, **re-run apply with unchanged
inputs; never use destroy as recovery**. Keep the saved request and retry GET
without POST replay. An ambiguous POST requires owner investigation first.
For manual cleanup, read that catalog's resources independently, require the
exact previously captured internal ID plus originId and originSystem, and send
adminRemove only for that catalog/resource pair. Never select by display name.
Confirm absence from a complete catalog listing, polling privately for delivery;
denied, incomplete or newly replicated reads do not prove absence. For a failed
registered removal of an independently confirmed absent resource only, use
`terraform state rm 'module.resource.msgraph_resource_action.remove[0]'` then
finish `terraform destroy -refresh=false`. Do not re-apply between state removal
and completing destroy. State removal itself revokes no access.

URL/identity guards protect registration; this is not a destroy-time state
integrity check. Keep state private and do not edit action URLs or bodies.
`enable_destroy_cleanup = false` is for externally owned cleanup before first
apply; disabling an already registered action runs removal.

Owner-dispatched live acceptance: confirm destroy-only provider capability on
each platform; create disposable group/application catalog resources, verify
independent origin and ID, unchanged apply and legacy upgrade without POST
replay; exercise denied/replication reads and unchanged retry; replace identity
destroy-first; remove packages before catalog resources; inspect adminRemove
delivery, independently prove exact-ID absence and unrelated resources unchanged.
Probe absent-resource errors and confirmed-absence state cleanup. Retain only
sanitized evidence. Offline mocks do not prove transport or delivery timing.

## Usage

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one.

```hcl
module "engineering_group_resource" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs/resources"
  version = "<version>"

  catalog_id             = module.engineering_catalog.id
  resource_origin_system = "AadGroup"
  resource_origin_id     = module.engineering_group.id
  resource_display_name  = module.engineering_group.display_name
}

module "engineering_sharepoint_resource" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs/resources"
  version = "<version>"

  catalog_id                 = module.engineering_catalog.id
  resource_origin_system     = "SharePointOnline"
  resource_origin_id         = "https://contoso.sharepoint.com/sites/Engineering"
  verification_delay_seconds = 90 # SharePoint site provisioning is slower than groups/apps
}

module "engineering_access_package" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/access-packages"
  version = "<version>"

  catalog_id   = module.engineering_catalog.id
  display_name = "Engineering Team Access"

  # Destroy removes the access package before the catalog resources it uses.
  depends_on = [module.engineering_group_resource, module.engineering_sharepoint_resource]
}

# An access package that grants these Azure roles needs the same depends_on.
module "platform_subscription_resource" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs/resources"
  version = "<version>"

  catalog_id             = module.engineering_catalog.id
  resource_origin_system = "AzureResources"
  resource_origin_id     = "/subscriptions/00000000-0000-0000-0000-000000000000"
  resource_display_name  = "Platform"
}

module "landing_zones_resource" {
  source  = "satolap/modules/msgraph//verified/identity-governance/entitlement-management/catalogs/resources"
  version = "<version>"

  catalog_id             = module.engineering_catalog.id
  resource_origin_system = "AzureResources"
  resource_origin_id     = "/providers/Microsoft.Management/managementGroups/landing-zones"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.11.0 |
| msgraph | >= 0.6.0, < 0.7.0 |
| time | >= 0.9.0 |
| null | >= 3.2.0 |

Permissions needed (application or delegated, in addition to
`EntitlementManagement.ReadWrite.All`), depending on `resource_origin_system`:

| resource_origin_system | Additional Graph permission |
|-------------------------|------------------------------|
| AadGroup | `Group.ReadWrite.All` |
| AadApplication | Ownership of, or a directory role permitting modification of, the application |
| SharePointOnline | `Sites.FullControl.All` |
| AzureResources | None; the identity needs Azure RBAC `Microsoft.Authorization/roleAssignments/read`, `write` and `delete` at the subscription or management group |

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `resource_origin_system` is `"SharePointOnline"` | SHAREPOINT | Internal users who access a SharePoint Online site need an assigned license that includes SharePoint Online. Entitlement management licensing does not supply the workload entitlement, and the site must already exist. All of: SharePoint Online (any plan) (`SHAREPOINTENTERPRISE`). | Internal users who will access the site | direct / per_user | documented |
| `resource_origin_system` is `"AzureResources"` | EM-AZURE-ROLES | Granting active or eligible Azure RBAC roles at a management group, subscription or resource group through entitlement management requires Microsoft Entra ID Governance or Microsoft Entra Suite. Microsoft Entra ID P2 alone is not sufficient. The Azure subscription or management group must already exist, and its Azure costs are separate. Any of: Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment that grants the Azure role; eligible roles are activated through Privileged Identity Management, whose users need the same coverage | group_based / per_user | documented |

Notes:

- Agent, API-permission or other advanced resource types need a separate reviewed rule; the module's acceptance of an origin system does not establish support.
- Adding an Azure subscription or management group also needs Azure RBAC permission to manage role assignments at that scope (Microsoft.Authorization/roleAssignments/read, write and delete); that is an Azure authorization requirement, not a license. See [Assign Azure RBAC roles](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-azure-role-assignments#azure-rbac-requirements-for-catalog-onboarding).
- The Azure resource role rules were reviewed against Microsoft Learn on 2026-10-12, which is later than the review date stated above.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [SharePoint Online service description](https://learn.microsoft.com/en-us/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-service-description), [Assign Azure role-based access control (RBAC) roles with entitlement management](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-azure-role-assignments#prerequisites), [Microsoft Entra ID Governance licensing fundamentals: Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals#privileged-identity-management).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required | On change |
|------|-------------|------|---------|----------| --- |
| catalog_id | ID of the catalog to add the resource to | `string` | n/a | yes | replaces `msgraph_resource_action.add_request`; changes `null_resource.remove_on_destroy`; see the module notes |
| resource_origin_system | `AadGroup`, `AadApplication`, `SharePointOnline`, or `AzureResources` | `string` | n/a | yes | replaces `msgraph_resource_action.add_request`; changes `null_resource.remove_on_destroy`; see the module notes |
| resource_origin_id | Group object ID / service principal object ID / SharePoint site URL / Azure subscription or management group resource ID | `string` | n/a | yes | replaces `msgraph_resource_action.add_request`; changes `null_resource.remove_on_destroy`; see the module notes |
| resource_display_name | Optional display name for the resource request | `string` | `null` | no | kept from creation: a change is refused or ignored (see notes) |
| verification_delay_seconds | Seconds to wait before verifying the add landed | `number` | `30` | no | no object change (validation or timing only) |
| fail_on_verification_mismatch | Disable only the optional gate when false; enabled cleanup still requires strict identity verification | `bool` | `true` | no | no object change (validation or timing only) |
| enable_destroy_cleanup | Register provider-native removal after independent verification; disable only before first apply for externally owned cleanup | `bool` | `true` | no | changes `null_resource.remove_on_destroy`; see the module notes; creates or deletes `msgraph_resource_action.remove` instances |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no | replaces `msgraph_resource_action.add_request`; changes `null_resource.remove_on_destroy`; see the module notes |

## Outputs

| Name | Description | Known in plan after an update |
|------|-------------| --- |
| request_id | The ID of the accessPackageResourceRequest | no |
| resource_id | The catalog-internal accessPackageResource ID — pass this as `catalog_resource_id` to the `access-packages/resource-role-scopes` module | no |
| resource_origin_id | The origin ID of the resource, as passed in | yes |
| verified | Whether the post-add verification read found the resource | no |

## Tests

`terraform test` runs offline unit tests (`tests/catalog_resource.tftest.hcl`) that mock the
providers and disable the destroy hook. They assert the adminAdd body, escaped OData
filter, captured ID, missing/ambiguous verification failures, which input changes
wait again before verifying, the Azure subscription and management group `resourceType`, and
the refusal of other Azure IDs. Native cleanup and legacy-state upgrade suites
run with cleanup enabled. Tests require Terraform 1.11 or later.

See [live test setup and lifecycle limits](../../../../../docs/test-tenant-setup.md).
