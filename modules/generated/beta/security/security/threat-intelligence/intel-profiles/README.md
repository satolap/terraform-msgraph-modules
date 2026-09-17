# /security/threatIntelligence/intelProfiles

Create new navigation property to intelProfiles for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-intelligenceprofile?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/threatIntelligence/intelProfiles`, `GET/PATCH/DELETE /security/threatIntelligence/intelProfiles/{intelligenceProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/threat-intelligence/intel-profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `aliases` | `aliases` | `list(string)` | no | no |
| `countries_or_regions_of_origin` | `countriesOrRegionsOfOrigin` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.intelligenceProfileCountryOrRegionOfOrigin")       code = optional(string)       label = optional(string)     }))` | no | no |
| `description` | `description` | `object({       odata_type = optional(string, "#microsoft.graph.security.formattedContent")       content = optional(string)       format = optional(any)     })` | no | no |
| `first_active_date_time` | `firstActiveDateTime` | `string` | no | no |
| `indicators` | `indicators` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.intelligenceProfileIndicator")       artifact = optional(object({       odata_type = optional(string, "#microsoft.graph.security.artifact")     }))       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       source = optional(string)     }))` | no | no |
| `kind` | `kind` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `summary` | `summary` | `object({       odata_type = optional(string, "#microsoft.graph.security.formattedContent")       content = optional(string)       format = optional(any)     })` | no | no |
| `targets` | `targets` | `list(string)` | no | no |
| `title` | `title` | `string` | no | no |
| `tradecraft` | `tradecraft` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- description.format: polymorphic schema; accepts an untyped value
- summary.format: polymorphic schema; accepts an untyped value
- tradecraft: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
