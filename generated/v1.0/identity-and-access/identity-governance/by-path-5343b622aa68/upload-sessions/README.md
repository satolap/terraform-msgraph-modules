# /identityGovernance/entitlementManagement/resourceRequests/{accessPackageResourceRequest-id}/resource/scopes/{accessPackageResourceScope-id}/resource/roles/{accessPackageResourceRole-id}/resource/uploadSessions

Create new navigation property to uploadSessions for identityGovernance

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/customdataprovidedresourceuploadsession?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/resourceRequests/{accessPackageResourceRequest-id}/resource/scopes/{accessPackageResourceScope-id}/resource/roles/{accessPackageResourceRole-id}/resource/uploadSessions`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/resourceRequests/{accessPackageResourceRequest-id}/resource/scopes/{accessPackageResourceScope-id}/resource/roles/{accessPackageResourceRole-id}/resource/uploadSessions/{customDataProvidedResourceUploadSession-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/by-path-5343b622aa68/upload-sessions"
  access_package_resource_request_id = "parent-object-id"
  access_package_resource_scope_id = "parent-object-id"
  access_package_resource_role_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `access_package_resource_request_id` | URL parameter `accessPackageResourceRequest-id` | `string` | yes | no |
| `access_package_resource_scope_id` | URL parameter `accessPackageResourceScope-id` | `string` | yes | no |
| `access_package_resource_role_id` | URL parameter `accessPackageResourceRole-id` | `string` | yes | no |
| `data` | `data` | `any` | no | no |
| `files` | `files` | `list(object({       odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceFile")       name = optional(string)     }))` | no | no |
| `is_upload_done` | `isUploadDone` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `reference_id` | `referenceId` | `string` | no | no |
| `stats` | `stats` | `object({       odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceUploadStats")       filesUploaded = optional(number)       totalBytesUploaded = optional(number)     })` | no | no |
| `status` | `status` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- data: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
