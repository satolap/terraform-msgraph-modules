# /groups/{group-id}/sites/{site-id}/termStores/{store-id}/sets/{set-id}/terms

Create new navigation property to terms for groups

[Catalog](../../../../../../../../../../README.md) · [Sites and lists](../../../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/termstore-term?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/sites/{site-id}/termStores/{store-id}/sets/{set-id}/terms`, `GET/PATCH/DELETE /groups/{group-id}/sites/{site-id}/termStores/{store-id}/sets/{set-id}/terms/{term-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./sites-and-lists/groups/by-group-id/sites/by-site-id/term-stores/by-store-id/sets/by-set-id/terms"
  group_id = "parent-object-id"
  site_id = "parent-object-id"
  store_id = "parent-object-id"
  set_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `site_id` | URL parameter `site-id` | `string` | yes | no |
| `store_id` | URL parameter `store-id` | `string` | yes | no |
| `set_id` | URL parameter `set-id` | `string` | yes | no |
| `children` | `children` | `list(object({       odata_type = optional(string, "#microsoft.graph.termStore.term")       children = optional(any)       descriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.localizedDescription")       description = optional(string)       languageTag = optional(string)     })))       labels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.localizedLabel")       isDefault = optional(bool)       languageTag = optional(string)       name = optional(string)     })))       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       relations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.relation")       fromTerm = optional(any)       relationship = optional(any)       set = optional(any)       toTerm = optional(any)     })))       set = optional(any)     }))` | no | no |
| `descriptions` | `descriptions` | `list(object({       odata_type = optional(string, "#microsoft.graph.termStore.localizedDescription")       description = optional(string)       languageTag = optional(string)     }))` | no | no |
| `labels` | `labels` | `list(object({       odata_type = optional(string, "#microsoft.graph.termStore.localizedLabel")       isDefault = optional(bool)       languageTag = optional(string)       name = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `properties` | `properties` | `list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     }))` | no | no |
| `relations` | `relations` | `list(object({       odata_type = optional(string, "#microsoft.graph.termStore.relation")       fromTerm = optional(any)       relationship = optional(any)       set = optional(any)       toTerm = optional(any)     }))` | no | no |
| `set` | `set` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- children[].children[]: recursive schema; accepts an untyped value
- children[].relations[].fromTerm: polymorphic schema; accepts an untyped value
- children[].relations[].relationship: polymorphic schema; accepts an untyped value
- children[].relations[].set: polymorphic schema; accepts an untyped value
- children[].relations[].toTerm: polymorphic schema; accepts an untyped value
- children[].set: polymorphic schema; accepts an untyped value
- relations[].fromTerm: polymorphic schema; accepts an untyped value
- relations[].relationship: polymorphic schema; accepts an untyped value
- relations[].set: polymorphic schema; accepts an untyped value
- relations[].toTerm: polymorphic schema; accepts an untyped value
- set: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
