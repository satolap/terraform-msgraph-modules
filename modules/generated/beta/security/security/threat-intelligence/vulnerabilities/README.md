# /security/threatIntelligence/vulnerabilities

Create new navigation property to vulnerabilities for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-vulnerability?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/threatIntelligence/vulnerabilities`, `GET/PATCH/DELETE /security/threatIntelligence/vulnerabilities/{vulnerability-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/threat-intelligence/vulnerabilities"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `active_exploits_observed` | `activeExploitsObserved` | `bool` | no | no |
| `articles` | `articles` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.article")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.security.formattedContent")       content = optional(string)       format = optional(any)     }))       createdDateTime = optional(string)       imageUrl = optional(string)       indicators = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.articleIndicator")       artifact = optional(object({       odata_type = optional(string, "#microsoft.graph.security.artifact")     }))       source = optional(string)     })))       isFeatured = optional(bool)       lastUpdatedDateTime = optional(string)       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.security.formattedContent")       content = optional(string)       format = optional(any)     }))       tags = optional(list(string))       title = optional(string)     }))` | no | no |
| `common_weakness_enumeration_ids` | `commonWeaknessEnumerationIds` | `list(string)` | no | no |
| `components` | `components` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.vulnerabilityComponent")       name = optional(string)     }))` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `cvss2_summary` | `cvss2Summary` | `object({       odata_type = optional(string, "#microsoft.graph.security.cvssSummary")       score = optional(any)       severity = optional(any)       vectorString = optional(string)     })` | no | no |
| `cvss3_summary` | `cvss3Summary` | `object({       odata_type = optional(string, "#microsoft.graph.security.cvssSummary")       score = optional(any)       severity = optional(any)       vectorString = optional(string)     })` | no | no |
| `description` | `description` | `object({       odata_type = optional(string, "#microsoft.graph.security.formattedContent")       content = optional(string)       format = optional(any)     })` | no | no |
| `exploits` | `exploits` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hyperlink")       name = optional(string)       url = optional(string)     }))` | no | no |
| `exploits_available` | `exploitsAvailable` | `bool` | no | no |
| `has_chatter` | `hasChatter` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `priority_score` | `priorityScore` | `number` | no | no |
| `published_date_time` | `publishedDateTime` | `string` | no | no |
| `references` | `references` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hyperlink")       name = optional(string)       url = optional(string)     }))` | no | no |
| `remediation` | `remediation` | `any` | no | no |
| `severity` | `severity` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- articles[].body.format: polymorphic schema; accepts an untyped value
- articles[].summary.format: polymorphic schema; accepts an untyped value
- cvss2Summary.score: polymorphic schema; accepts an untyped value
- cvss2Summary.severity: polymorphic schema; accepts an untyped value
- cvss3Summary.score: polymorphic schema; accepts an untyped value
- cvss3Summary.severity: polymorphic schema; accepts an untyped value
- description.format: polymorphic schema; accepts an untyped value
- remediation: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
