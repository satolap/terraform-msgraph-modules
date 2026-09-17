# /identityGovernance/entitlementManagement/accessPackageCatalogs

Create accessPackageCatalog

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagecatalog?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/accessPackageCatalogs`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/accessPackageCatalogs/{accessPackageCatalog-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/entitlement-management/access-package-catalogs"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `access_package_custom_workflow_extensions` | `accessPackageCustomWorkflowExtensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.customCalloutExtension")       authenticationConfiguration = optional(any)       clientConfiguration = optional(any)       description = optional(string)       displayName = optional(string)       endpointConfiguration = optional(any)     }))` | no | no |
| `access_package_resource_scopes` | `accessPackageResourceScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceScope")       accessPackageResource = optional(any)       description = optional(string)       displayName = optional(string)       isRootScope = optional(bool)       originId = optional(string)       originSystem = optional(string)       roleOriginId = optional(string)       url = optional(string)     }))` | no | no |
| `access_package_resources` | `accessPackageResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResource")       accessPackageResourceEnvironment = optional(any)       attributes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceAttribute")       attributeDestination = optional(any)       attributeName = optional(string)       attributeSource = optional(any)       isEditable = optional(bool)       isPersistedOnAssignmentRemoval = optional(bool)     })))       description = optional(string)       displayName = optional(string)       originId = optional(string)       originSystem = optional(string)       resourceType = optional(string)       uploadSessions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceUploadSession")       data = optional(any)       files = optional(any)       isUploadDone = optional(bool)       referenceId = optional(string)       stats = optional(object({       odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceUploadStats")       filesUploaded = optional(number)       totalBytesUploaded = optional(number)     }))       status = optional(string)     })))       url = optional(string)     }))` | no | no |
| `catalog_status` | `catalogStatus` | `string` | no | no |
| `catalog_type` | `catalogType` | `string` | no | no |
| `custom_access_package_workflow_extensions` | `customAccessPackageWorkflowExtensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.customAccessPackageWorkflowExtension")       authenticationConfiguration = optional(any)       clientConfiguration = optional(any)       description = optional(string)       displayName = optional(string)       endpointConfiguration = optional(any)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_externally_visible` | `isExternallyVisible` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `privilege_level` | `privilegeLevel` | `string` | no | no |
| `unique_name` | `uniqueName` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- accessPackageCustomWorkflowExtensions[].authenticationConfiguration: polymorphic schema; accepts an untyped value
- accessPackageCustomWorkflowExtensions[].clientConfiguration: polymorphic schema; accepts an untyped value
- accessPackageCustomWorkflowExtensions[].endpointConfiguration: polymorphic schema; accepts an untyped value
- accessPackageResourceScopes[].accessPackageResource: polymorphic schema; accepts an untyped value
- accessPackageResources[].accessPackageResourceEnvironment: polymorphic schema; accepts an untyped value
- accessPackageResources[].attributes[].attributeDestination: polymorphic schema; accepts an untyped value
- accessPackageResources[].attributes[].attributeSource: polymorphic schema; accepts an untyped value
- accessPackageResources[].uploadSessions[].data: polymorphic schema; accepts an untyped value
- accessPackageResources[].uploadSessions[].files[]: nested schema exceeds depth limit; accepts an untyped value
- customAccessPackageWorkflowExtensions[].authenticationConfiguration: polymorphic schema; accepts an untyped value
- customAccessPackageWorkflowExtensions[].clientConfiguration: polymorphic schema; accepts an untyped value
- customAccessPackageWorkflowExtensions[].endpointConfiguration: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
