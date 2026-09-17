# /identityGovernance/catalogs

Create new navigation property to catalogs for identityGovernance

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagecatalog?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/catalogs`, `GET/PATCH/DELETE /identityGovernance/catalogs/{accessPackageCatalog-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/catalogs"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `catalog_type` | `catalogType` | `any` | no | no |
| `custom_workflow_extensions` | `customWorkflowExtensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.customCalloutExtension")       authenticationConfiguration = optional(any)       clientConfiguration = optional(any)       description = optional(string)       displayName = optional(string)       endpointConfiguration = optional(any)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_externally_visible` | `isExternallyVisible` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resource_roles` | `resourceRoles` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceRole")       description = optional(string)       displayName = optional(string)       originId = optional(string)       originSystem = optional(string)       resource = optional(any)       type = optional(any)     }))` | no | no |
| `resource_scopes` | `resourceScopes` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceScope")       description = optional(string)       displayName = optional(string)       isRootScope = optional(bool)       originId = optional(string)       originSystem = optional(string)       resource = optional(any)     }))` | no | no |
| `resources` | `resources` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResource")       attributes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageResourceAttribute")       destination = optional(any)       isEditable = optional(bool)       isPersistedOnAssignmentRemoval = optional(bool)       name = optional(string)       source = optional(any)     })))       description = optional(string)       displayName = optional(string)       environment = optional(any)       originId = optional(string)       originSystem = optional(string)       uploadSessions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceUploadSession")       data = optional(any)       files = optional(any)       isUploadDone = optional(bool)       referenceId = optional(string)       stats = optional(object({       odata_type = optional(string, "#microsoft.graph.customDataProvidedResourceUploadStats")       filesUploaded = optional(number)       totalBytesUploaded = optional(number)     }))       status = optional(string)     })))     }))` | no | no |
| `state` | `state` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- catalogType: polymorphic schema; accepts an untyped value
- customWorkflowExtensions[].authenticationConfiguration: polymorphic schema; accepts an untyped value
- customWorkflowExtensions[].clientConfiguration: polymorphic schema; accepts an untyped value
- customWorkflowExtensions[].endpointConfiguration: polymorphic schema; accepts an untyped value
- resourceRoles[].resource: polymorphic schema; accepts an untyped value
- resourceRoles[].type: polymorphic schema; accepts an untyped value
- resourceScopes[].resource: polymorphic schema; accepts an untyped value
- resources[].attributes[].destination: polymorphic schema; accepts an untyped value
- resources[].attributes[].source: polymorphic schema; accepts an untyped value
- resources[].environment: polymorphic schema; accepts an untyped value
- resources[].uploadSessions[].data: polymorphic schema; accepts an untyped value
- resources[].uploadSessions[].files[]: nested schema exceeds depth limit; accepts an untyped value
- state: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
