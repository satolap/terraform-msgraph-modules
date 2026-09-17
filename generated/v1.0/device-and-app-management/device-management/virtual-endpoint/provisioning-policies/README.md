# /deviceManagement/virtualEndpoint/provisioningPolicies

Create cloudPcProvisioningPolicy

[Catalog](../../../../README.md) · [Device and app management](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcprovisioningpolicy?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /deviceManagement/virtualEndpoint/provisioningPolicies`, `GET/PATCH/DELETE /deviceManagement/virtualEndpoint/provisioningPolicies/{cloudPcProvisioningPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/device-management/virtual-endpoint/provisioning-policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.cloudPcProvisioningPolicyAssignment")       target = optional(any)     }))` | no | no |
| `autopatch` | `autopatch` | `any` | no | no |
| `cloud_pc_naming_template` | `cloudPcNamingTemplate` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `domain_join_configurations` | `domainJoinConfigurations` | `list(object({       odata_type = optional(string, "#microsoft.graph.cloudPcDomainJoinConfiguration")       domainJoinType = optional(any)       onPremisesConnectionId = optional(string)       regionName = optional(string)     }))` | no | no |
| `enable_single_sign_on` | `enableSingleSignOn` | `bool` | no | no |
| `image_display_name` | `imageDisplayName` | `string` | no | no |
| `image_id` | `imageId` | `string` | no | no |
| `image_type` | `imageType` | `string` | no | no |
| `local_admin_enabled` | `localAdminEnabled` | `bool` | no | no |
| `microsoft_managed_desktop` | `microsoftManagedDesktop` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `provisioning_type` | `provisioningType` | `any` | no | no |
| `windows_setting` | `windowsSetting` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- assignments[].target: polymorphic schema; accepts an untyped value
- autopatch: polymorphic schema; accepts an untyped value
- domainJoinConfigurations[].domainJoinType: polymorphic schema; accepts an untyped value
- microsoftManagedDesktop: polymorphic schema; accepts an untyped value
- provisioningType: polymorphic schema; accepts an untyped value
- windowsSetting: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
