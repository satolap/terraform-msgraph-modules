# /directory/recommendations

Create new navigation property to recommendations for directory

[Catalog](../../../README.md) · [Reports](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/recommendation?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /directory/recommendations`, `GET/PATCH/DELETE /directory/recommendations/{recommendation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./reports/directory/recommendations"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `action_steps` | `actionSteps` | `list(object({       odata_type = optional(string, "#microsoft.graph.actionStep")       actionUrl = optional(any)       stepNumber = optional(number)       text = optional(string)     }))` | no | no |
| `benefits` | `benefits` | `string` | no | no |
| `category` | `category` | `string` | no | no |
| `category_group` | `categoryGroup` | `string` | no | no |
| `completed_by_system_date_time` | `completedBySystemDateTime` | `string` | no | no |
| `completed_by_user_date_time` | `completedByUserDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `current_score` | `currentScore` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `failed_review_date_time` | `failedReviewDateTime` | `string` | no | no |
| `feature_areas` | `featureAreas` | `any` | no | no |
| `impact_start_date_time` | `impactStartDateTime` | `string` | no | no |
| `impact_type` | `impactType` | `string` | no | no |
| `impacted_resources` | `impactedResources` | `list(object({       odata_type = optional(string, "#microsoft.graph.impactedResource")       addedDateTime = optional(string)       additionalDetails = optional(list(object({       odata_type = optional(string, "#microsoft.graph.keyValue")       key = optional(string)       value = optional(string)     })))       apiUrl = optional(string)       displayName = optional(string)       lastModifiedBy = optional(string)       lastModifiedDateTime = optional(string)       owner = optional(string)       portalUrl = optional(string)       postponeUntilDateTime = optional(string)       rank = optional(number)       recommendationId = optional(string)       resourceType = optional(string)       status = optional(string)       subjectId = optional(string)       tags = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recommendationTag")       displayName = optional(string)     })))     }))` | no | no |
| `insights` | `insights` | `string` | no | no |
| `last_checked_date_time` | `lastCheckedDateTime` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `max_score` | `maxScore` | `any` | no | no |
| `needs_more_action_resource_count` | `needsMoreActionResourceCount` | `number` | no | no |
| `nist_classifications` | `nistClassifications` | `list(object({       odata_type = optional(string, "#microsoft.graph.nistClassification")       category = optional(string)       description = optional(string)       function = optional(string)       name = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `postpone_until_date_time` | `postponeUntilDateTime` | `string` | no | no |
| `priority` | `priority` | `string` | no | no |
| `recommendation_type` | `recommendationType` | `any` | no | no |
| `release_type` | `releaseType` | `string` | no | no |
| `remediated_date_time` | `remediatedDateTime` | `string` | no | no |
| `remediation_impact` | `remediationImpact` | `string` | no | no |
| `required_licenses` | `requiredLicenses` | `any` | no | no |
| `status` | `status` | `string` | no | no |
| `status_modified_date_time` | `statusModifiedDateTime` | `string` | no | no |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.recommendationTag")       displayName = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- actionSteps[].actionUrl: polymorphic schema; accepts an untyped value
- currentScore: polymorphic schema; accepts an untyped value
- featureAreas[]: polymorphic schema; accepts an untyped value
- maxScore: polymorphic schema; accepts an untyped value
- recommendationType: polymorphic schema; accepts an untyped value
- requiredLicenses: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
