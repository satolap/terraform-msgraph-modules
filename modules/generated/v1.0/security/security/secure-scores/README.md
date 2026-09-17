# /security/secureScores

Create new navigation property to secureScores for security

[Catalog](../../../README.md) · [Security](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/securescore?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/secureScores`, `GET/PATCH/DELETE /security/secureScores/{secureScore-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/secure-scores"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `active_user_count` | `activeUserCount` | `number` | no | no |
| `average_comparative_scores` | `averageComparativeScores` | `list(object({       odata_type = optional(string, "#microsoft.graph.averageComparativeScore")       averageScore = optional(any)       basis = optional(string)     }))` | no | no |
| `azure_tenant_id` | `azureTenantId` | `string` | no | no |
| `control_scores` | `controlScores` | `list(object({       odata_type = optional(string, "#microsoft.graph.controlScore")       controlCategory = optional(string)       controlName = optional(string)       description = optional(string)       score = optional(any)     }))` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `current_score` | `currentScore` | `any` | no | no |
| `enabled_services` | `enabledServices` | `list(string)` | no | no |
| `licensed_user_count` | `licensedUserCount` | `number` | no | no |
| `max_score` | `maxScore` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `vendor_information` | `vendorInformation` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- averageComparativeScores[].averageScore: polymorphic schema; accepts an untyped value
- controlScores[].score: polymorphic schema; accepts an untyped value
- currentScore: polymorphic schema; accepts an untyped value
- maxScore: polymorphic schema; accepts an untyped value
- vendorInformation: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
