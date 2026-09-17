# /groups/{group-id}/sites/{site-id}/lists/{list-id}/contentTypes

Create new navigation property to contentTypes for groups

[Catalog](../../../../../../../../README.md) · [Sites and lists](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/contenttype?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/sites/{site-id}/lists/{list-id}/contentTypes`, `GET/PATCH/DELETE /groups/{group-id}/sites/{site-id}/lists/{list-id}/contentTypes/{contentType-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./sites-and-lists/groups/by-group-id/sites/by-site-id/lists/by-list-id/content-types"
  group_id = "parent-object-id"
  site_id = "parent-object-id"
  list_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `site_id` | URL parameter `site-id` | `string` | yes | no |
| `list_id` | URL parameter `list-id` | `string` | yes | no |
| `associated_hubs_urls` | `associatedHubsUrls` | `list(string)` | no | no |
| `base` | `base` | `any` | no | no |
| `base_types` | `baseTypes` | `list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnLink")       name = optional(string)     })))       columnPositions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     }))` | no | no |
| `column_links` | `columnLinks` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnLink")       name = optional(string)     }))` | no | no |
| `column_positions` | `columnPositions` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     }))` | no | no |
| `columns` | `columns` | `list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `document_set` | `documentSet` | `any` | no | no |
| `document_template` | `documentTemplate` | `any` | no | no |
| `group` | `group` | `string` | no | no |
| `hidden` | `hidden` | `bool` | no | no |
| `inherited_from` | `inheritedFrom` | `any` | no | no |
| `is_built_in` | `isBuiltIn` | `bool` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `order` | `order` | `any` | no | no |
| `parent_id` | `parentId` | `string` | no | no |
| `propagate_changes` | `propagateChanges` | `bool` | no | no |
| `read_only` | `readOnly` | `bool` | no | no |
| `sealed` | `sealed` | `bool` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- base: polymorphic schema; accepts an untyped value
- baseTypes[].base: polymorphic schema; accepts an untyped value
- baseTypes[].baseTypes[]: recursive schema; accepts an untyped value
- baseTypes[].columnPositions[].boolean: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].calculated: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].choice: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].currency: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].dateTime: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].defaultValue: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].geolocation: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].lookup: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].number: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].personOrGroup: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].sourceColumn: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].term: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].text: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].thumbnail: polymorphic schema; accepts an untyped value
- baseTypes[].columnPositions[].validation: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].boolean: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].calculated: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].choice: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].currency: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].dateTime: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].defaultValue: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].geolocation: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].lookup: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].number: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].personOrGroup: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].sourceColumn: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].term: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].text: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- baseTypes[].columns[].validation: polymorphic schema; accepts an untyped value
- baseTypes[].documentSet: polymorphic schema; accepts an untyped value
- baseTypes[].documentTemplate: polymorphic schema; accepts an untyped value
- baseTypes[].inheritedFrom: polymorphic schema; accepts an untyped value
- baseTypes[].order: polymorphic schema; accepts an untyped value
- columnPositions[].boolean: polymorphic schema; accepts an untyped value
- columnPositions[].calculated: polymorphic schema; accepts an untyped value
- columnPositions[].choice: polymorphic schema; accepts an untyped value
- columnPositions[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- columnPositions[].currency: polymorphic schema; accepts an untyped value
- columnPositions[].dateTime: polymorphic schema; accepts an untyped value
- columnPositions[].defaultValue: polymorphic schema; accepts an untyped value
- columnPositions[].geolocation: polymorphic schema; accepts an untyped value
- columnPositions[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- columnPositions[].lookup: polymorphic schema; accepts an untyped value
- columnPositions[].number: polymorphic schema; accepts an untyped value
- columnPositions[].personOrGroup: polymorphic schema; accepts an untyped value
- columnPositions[].sourceColumn: polymorphic schema; accepts an untyped value
- columnPositions[].term: polymorphic schema; accepts an untyped value
- columnPositions[].text: polymorphic schema; accepts an untyped value
- columnPositions[].thumbnail: polymorphic schema; accepts an untyped value
- columnPositions[].validation: polymorphic schema; accepts an untyped value
- columns[].boolean: polymorphic schema; accepts an untyped value
- columns[].calculated: polymorphic schema; accepts an untyped value
- columns[].choice: polymorphic schema; accepts an untyped value
- columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- columns[].currency: polymorphic schema; accepts an untyped value
- columns[].dateTime: polymorphic schema; accepts an untyped value
- columns[].defaultValue: polymorphic schema; accepts an untyped value
- columns[].geolocation: polymorphic schema; accepts an untyped value
- columns[].hyperlinkOrPicture: polymorphic schema; accepts an untyped value
- columns[].lookup: polymorphic schema; accepts an untyped value
- columns[].number: polymorphic schema; accepts an untyped value
- columns[].personOrGroup: polymorphic schema; accepts an untyped value
- columns[].sourceColumn: polymorphic schema; accepts an untyped value
- columns[].term: polymorphic schema; accepts an untyped value
- columns[].text: polymorphic schema; accepts an untyped value
- columns[].thumbnail: polymorphic schema; accepts an untyped value
- columns[].validation: polymorphic schema; accepts an untyped value
- documentSet: polymorphic schema; accepts an untyped value
- documentTemplate: polymorphic schema; accepts an untyped value
- inheritedFrom: polymorphic schema; accepts an untyped value
- order: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
