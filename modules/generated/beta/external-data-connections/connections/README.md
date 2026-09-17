# /connections

Add new entity to connections

[Catalog](../../README.md) · [External data connections](../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/externalconnectors-externalconnection?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /connections`, `GET/PATCH/DELETE /connections/{externalConnection-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./external-data-connections/connections"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `activity_settings` | `activitySettings` | `any` | no | no |
| `compliance_settings` | `complianceSettings` | `any` | no | no |
| `configuration` | `configuration` | `any` | no | no |
| `connector_id` | `connectorId` | `string` | no | no |
| `content_category` | `contentCategory` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `enabled_content_experiences` | `enabledContentExperiences` | `any` | no | no |
| `groups` | `groups` | `list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.externalGroup")       description = optional(string)       displayName = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.identity")       type = optional(any)     })))     }))` | no | no |
| `ingested_items_count` | `ingestedItemsCount` | `number` | no | no |
| `items` | `items` | `list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.externalItem")       acl = optional(list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.acl")       accessType = optional(string)       identitySource = optional(any)       type = optional(string)       value = optional(string)     })))       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.externalActivity")       performedBy = optional(any)       startDateTime = optional(string)       type = optional(string)     })))       content = optional(any)       informationProtectionLabel = optional(any)       properties = optional(any)     }))` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.connectionOperation")       error = optional(any)       status = optional(any)     }))` | no | no |
| `quota` | `quota` | `any` | no | no |
| `schema` | `schema` | `any` | no | no |
| `search_settings` | `searchSettings` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- activitySettings: polymorphic schema; accepts an untyped value
- complianceSettings: polymorphic schema; accepts an untyped value
- configuration: polymorphic schema; accepts an untyped value
- enabledContentExperiences: polymorphic schema; accepts an untyped value
- groups[].members[].type: polymorphic schema; accepts an untyped value
- items[].acl[].identitySource: polymorphic schema; accepts an untyped value
- items[].activities[].performedBy: polymorphic schema; accepts an untyped value
- items[].content: polymorphic schema; accepts an untyped value
- items[].informationProtectionLabel: polymorphic schema; accepts an untyped value
- items[].properties: polymorphic schema; accepts an untyped value
- operations[].error: polymorphic schema; accepts an untyped value
- operations[].status: polymorphic schema; accepts an untyped value
- quota: polymorphic schema; accepts an untyped value
- schema: polymorphic schema; accepts an untyped value
- searchSettings: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
