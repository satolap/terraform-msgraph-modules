# /external/connections/{externalConnection-id}/items

Create new navigation property to items for external

[Catalog](../../../../../README.md) · [External data connections](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/externalconnectors-externalitem?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /external/connections/{externalConnection-id}/items`, `GET/PUT/DELETE /external/connections/{externalConnection-id}/items/{externalItem-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./external-data-connections/external/connections/by-external-connection-id/items"
  external_connection_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `external_connection_id` | URL parameter `externalConnection-id` | `string` | yes | no |
| `acl` | `acl` | `list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.acl")       accessType = optional(string)       type = optional(string)       value = optional(string)     }))` | no | no |
| `activities` | `activities` | `list(object({       odata_type = optional(string, "#microsoft.graph.externalConnectors.externalActivity")       performedBy = optional(any)       startDateTime = optional(string)       type = optional(string)     }))` | no | no |
| `content` | `content` | `any` | no | no |
| `information_protection_label` | `informationProtectionLabel` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `properties` | `properties` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- activities[].performedBy: polymorphic schema; accepts an untyped value
- content: polymorphic schema; accepts an untyped value
- informationProtectionLabel: polymorphic schema; accepts an untyped value
- properties: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
