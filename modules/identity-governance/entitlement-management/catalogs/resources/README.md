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
  source = "../../modules/identity-governance/entitlement-management/catalogs/resources"

  catalog_id             = module.engineering_catalog.id
  resource_origin_system = "AadGroup"
  resource_origin_id     = module.engineering_group.id
  resource_display_name  = module.engineering_group.display_name
}

module "engineering_sharepoint_resource" {
  source = "../../modules/identity-governance/entitlement-management/catalogs/resources"

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
