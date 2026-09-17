# /groups/{group-id}/sites/{site-id}/termStores

Create new navigation property to termStores for groups

[Catalog](../../../../../../README.md) · [Sites and lists](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/termstore-store?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/sites/{site-id}/termStores`, `GET/PATCH/DELETE /groups/{group-id}/sites/{site-id}/termStores/{store-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./sites-and-lists/groups/by-group-id/sites/by-site-id/term-stores"
  group_id = "parent-object-id"
  site_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `site_id` | URL parameter `site-id` | `string` | yes | no |
| `default_language_tag` | `defaultLanguageTag` | `string` | no | no |
| `groups` | `groups` | `list(object({       odata_type = optional(string, "#microsoft.graph.termStore.group")       description = optional(string)       displayName = optional(string)       parentSiteId = optional(string)       scope = optional(any)       sets = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.set")       children = optional(any)       description = optional(string)       localizedNames = optional(any)       parentGroup = optional(any)       properties = optional(any)       relations = optional(any)       terms = optional(any)     })))     }))` | no | no |
| `language_tags` | `languageTags` | `list(string)` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `sets` | `sets` | `list(object({       odata_type = optional(string, "#microsoft.graph.termStore.set")       children = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.term")       children = optional(any)       descriptions = optional(any)       labels = optional(any)       properties = optional(any)       relations = optional(any)       set = optional(any)     })))       description = optional(string)       localizedNames = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.localizedName")       languageTag = optional(string)       name = optional(string)     })))       parentGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.termStore.group")       description = optional(string)       displayName = optional(string)       parentSiteId = optional(string)       scope = optional(any)       sets = optional(any)     }))       properties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       relations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.relation")       fromTerm = optional(any)       relationship = optional(any)       set = optional(any)       toTerm = optional(any)     })))       terms = optional(list(object({       odata_type = optional(string, "#microsoft.graph.termStore.term")       children = optional(any)       descriptions = optional(any)       labels = optional(any)       properties = optional(any)       relations = optional(any)       set = optional(any)     })))     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- groups[].scope: polymorphic schema; accepts an untyped value
- groups[].sets[].children[]: nested schema exceeds depth limit; accepts an untyped value
- groups[].sets[].localizedNames[]: nested schema exceeds depth limit; accepts an untyped value
- groups[].sets[].parentGroup: recursive schema; accepts an untyped value
- groups[].sets[].properties[]: nested schema exceeds depth limit; accepts an untyped value
- groups[].sets[].relations[]: nested schema exceeds depth limit; accepts an untyped value
- groups[].sets[].terms[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].children[].children[]: recursive schema; accepts an untyped value
- sets[].children[].descriptions[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].children[].labels[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].children[].properties[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].children[].relations[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].children[].set: polymorphic schema; accepts an untyped value
- sets[].parentGroup.scope: polymorphic schema; accepts an untyped value
- sets[].parentGroup.sets[]: recursive schema; accepts an untyped value
- sets[].relations[].fromTerm: polymorphic schema; accepts an untyped value
- sets[].relations[].relationship: polymorphic schema; accepts an untyped value
- sets[].relations[].set: polymorphic schema; accepts an untyped value
- sets[].relations[].toTerm: polymorphic schema; accepts an untyped value
- sets[].terms[].children[]: recursive schema; accepts an untyped value
- sets[].terms[].descriptions[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].terms[].labels[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].terms[].properties[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].terms[].relations[]: nested schema exceeds depth limit; accepts an untyped value
- sets[].terms[].set: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
