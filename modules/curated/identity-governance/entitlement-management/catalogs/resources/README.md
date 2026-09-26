# identity-governance/entitlement-management/catalogs/resources

Adds an Entra ID group, application (service principal), or SharePoint Online site to an
entitlement management catalog, via the `microsoft/msgraph` Terraform provider. The folder
mirrors the Graph collection it manages:
`identityGovernance/entitlementManagement/catalogs/{id}/resources`.

## Why this module looks different from the others

Microsoft Graph has no stable REST object for "a resource that belongs to a catalog" — it's
managed entirely through **action-style** `accessPackageResourceRequest` calls
(`POST identityGovernance/entitlementManagement/resourceRequests`): `requestType: "adminAdd"`
to add a resource, `"adminRemove"` to remove one. The request object supports neither PATCH
nor DELETE, so it can't be mapped onto standard Terraform create/read/update/delete, and
provisioning is asynchronous (a SharePoint Online site in particular can take a while to
appear). To handle this within a generic `msgraph`-provider-based module, this module:

1. Submits the `adminAdd` request as a one-shot **action**
   (`msgraph_resource_action.add_request`) rather than a CRUD-managed `msgraph_resource` —
   a CRUD-managed request would make `terraform destroy` fail when the provider attempts the
   unsupported `DELETE resourceRequests/{id}`.
2. Waits `verification_delay_seconds` (`time_sleep.wait_for_delivery`).
3. Reads the catalog's resources back, filtered by `originId` via `query_parameters`
   (`data.msgraph_resource.verify`), to confirm the add landed **and** to capture the
   resource's catalog-internal `id` (different from `resource_origin_id`) that role scopes
   and a later removal need.
4. Gates `apply` on that verification via a `precondition` (`fail_on_verification_mismatch`).
5. On `terraform destroy`, submits an `adminRemove` request from a destroy-time
   `local-exec` provisioner, using the internal resource `id` captured in step 3 (the
   provider's own resource lifecycle has no concept of "run a different request on destroy").

**Because of step 5, this module requires Bash, the Azure CLI (`az`), and `curl` 7.76+ to be available and
already logged in (`az login`) on the machine running `terraform destroy`** — it reuses that
session in the same public-cloud tenant as the `msgraph` provider. Missing IDs, credentials,
and HTTP failures cause destroy to fail so state can be retained for retry. Request delivery
is asynchronous; verify removal in the Microsoft Entra admin center afterward.

## Usage

```hcl
module "engineering_group_resource" {
  source = "../../modules/curated/identity-governance/entitlement-management/catalogs/resources"

  catalog_id             = module.engineering_catalog.id
  resource_origin_system = "AadGroup"
  resource_origin_id     = module.engineering_group.id
  resource_display_name  = module.engineering_group.display_name
}

module "engineering_sharepoint_resource" {
  source = "../../modules/curated/identity-governance/entitlement-management/catalogs/resources"

  catalog_id                 = module.engineering_catalog.id
  resource_origin_system     = "SharePointOnline"
  resource_origin_id         = "https://contoso.sharepoint.com/sites/Engineering"
  verification_delay_seconds = 90 # SharePoint site provisioning is slower than groups/apps
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| msgraph | >= 0.3.0 |
| time | >= 0.9.0 |
| null | >= 3.2.0 |
| Azure CLI (`az`) + `curl` | Required on the machine running `terraform destroy` |

Permissions needed (application or delegated, in addition to
`EntitlementManagement.ReadWrite.All`), depending on `resource_origin_system`:

| resource_origin_system | Additional Graph permission |
|-------------------------|------------------------------|
| AadGroup | `Group.ReadWrite.All` |
| AadApplication | Ownership of, or a directory role permitting modification of, the application |
| SharePointOnline | `Sites.FullControl.All` |

<!-- licensing:begin -->
## Licensing and prerequisites

Reviewed against public Microsoft documentation on 2026-09-18. Requirements depend on the features an input enables and on who benefits; a successful API call does not establish entitlement. Live test status: not verified in a licensed tenant.

| Applies when | Feature | Requirement | Who needs coverage | Assignment / capacity | Confidence |
| --- | --- | --- | --- | --- | --- |
| Always | EM-CORE | Catalogs, access packages with group, application and SharePoint resources, standard approval stages, requestor questions and expiration are included in Microsoft Entra ID P2, Microsoft Entra ID Governance and Microsoft Entra Suite. Evaluate the exact feature combination; not every accepted policy option is core. Any of: Microsoft Entra ID P2 (`AAD_PREMIUM_P2`); Microsoft Entra ID Governance (`Entra_Identity_Governance`); Microsoft Entra Suite (`Entra_Identity_Governance`). | Every user who can request or receive an access package assignment, including everyone covered by an all-member policy scope; guest scenarios can involve billing | direct / per_user | documented |
| `resource_origin_system` is `"SharePointOnline"` | SHAREPOINT | Internal users who access a SharePoint Online site need an assigned license that includes SharePoint Online. Entitlement management licensing does not supply the workload entitlement, and the site must already exist. All of: SharePoint Online (any plan) (`SHAREPOINTENTERPRISE`). | Internal users who will access the site | direct / per_user | documented |

Notes:

- Agent, API-permission or other advanced resource types need a separate reviewed rule; the module's acceptance of an origin system does not establish support.

Sources: [Entitlement management license requirements](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview#license-requirements), [Microsoft Entra features by license](https://learn.microsoft.com/en-us/entra/fundamentals/licensing#features-by-license), [SharePoint Online service description](https://learn.microsoft.com/en-us/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-service-description).
<!-- licensing:end -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| catalog_id | ID of the catalog to add the resource to | `string` | n/a | yes |
| resource_origin_system | `AadGroup`, `AadApplication`, or `SharePointOnline` | `string` | n/a | yes |
| resource_origin_id | Group object ID / service principal object ID / SharePoint site URL | `string` | n/a | yes |
| resource_display_name | Optional display name for the resource request | `string` | `null` | no |
| verification_delay_seconds | Seconds to wait before verifying the add landed | `number` | `30` | no |
| fail_on_verification_mismatch | Fail apply if verification doesn't find the resource | `bool` | `true` | no |
| enable_destroy_cleanup | Create the Azure CLI removal hook; disable only before first apply for tests or externally managed cleanup | `bool` | `true` | no |
| api_version | Graph API version (`v1.0` or `beta`) | `string` | `"v1.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| request_id | The ID of the accessPackageResourceRequest |
| resource_id | The catalog-internal accessPackageResource ID — pass this as `catalog_resource_id` to the `access-packages/resource-role-scopes` module |
| resource_origin_id | The origin ID of the resource, as passed in |
| verified | Whether the post-add verification read found the resource |

## Tests

`terraform test` runs offline unit tests (`tests/catalog_resource.tftest.hcl`) that mock the
providers and disable the destroy hook. They assert the adminAdd body, escaped OData
filter, captured ID, and missing/ambiguous verification failures. Terraform mocking does
not suppress provisioners by itself. Tests require Terraform 1.7 or later.

See [live test setup and lifecycle limits](../../../../../docs/test-tenant-setup.md).
