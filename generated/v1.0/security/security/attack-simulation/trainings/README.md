# /security/attackSimulation/trainings

Create new navigation property to trainings for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/training?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/attackSimulation/trainings`, `GET/PATCH/DELETE /security/attackSimulation/trainings/{training-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/attack-simulation/trainings"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `availability_status` | `availabilityStatus` | `any` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `duration_in_minutes` | `durationInMinutes` | `number` | no | no |
| `graph_source` | `source` | `any` | no | no |
| `has_evaluation` | `hasEvaluation` | `bool` | no | no |
| `language_details` | `languageDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.trainingLanguageDetail")       content = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       isDefaultLangauge = optional(bool)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       locale = optional(string)     }))` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `supported_locales` | `supportedLocales` | `list(string)` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `type` | `type` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- availabilityStatus: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- languageDetails[].createdBy: polymorphic schema; accepts an untyped value
- languageDetails[].lastModifiedBy: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- source: polymorphic schema; accepts an untyped value
- type: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
