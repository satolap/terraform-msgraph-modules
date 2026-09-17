# /identityGovernance/accessReviews/unified/definitions

Create accessReviewScheduleDefinition

[Catalog](../../../../../README.md) · [Identity and access](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accessreviewscheduledefinition?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/accessReviews/unified/definitions`, `GET/PATCH/DELETE /identityGovernance/accessReviews/unified/definitions/{accessReviewScheduleDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/access-reviews/unified/definitions"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `additional_notification_recipients` | `additionalNotificationRecipients` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewNotificationRecipientItem")       notificationRecipientScope = optional(any)       notificationTemplateType = optional(string)     }))` | no | no |
| `description_for_admins` | `descriptionForAdmins` | `string` | no | no |
| `description_for_reviewers` | `descriptionForReviewers` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `fallback_reviewers` | `fallbackReviewers` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     }))` | no | no |
| `instance_enumeration_scope` | `instanceEnumerationScope` | `any` | no | no |
| `instances` | `instances` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstance")       decisions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewInstanceDecisionItem")       decision = optional(string)       insights = optional(any)       justification = optional(string)       permission = optional(any)     })))       fallbackReviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       reviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       stages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewStage")       decisions = optional(any)       fallbackReviewers = optional(any)       reviewers = optional(any)     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `reviewers` | `reviewers` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     }))` | no | no |
| `scope` | `scope` | `any` | no | no |
| `settings` | `settings` | `any` | no | no |
| `stage_settings` | `stageSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewStageSettings")       decisionsThatWillMoveToNextStage = optional(list(string))       dependsOn = optional(list(string))       durationInDays = optional(number)       fallbackReviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       recommendationInsightSettings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewRecommendationInsightSetting")     })))       recommendationsEnabled = optional(bool)       reviewers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessReviewReviewerScope")       query = optional(string)       queryRoot = optional(string)       queryType = optional(string)       reviewerId = optional(string)       scopeType = optional(string)     })))       stageId = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- additionalNotificationRecipients[].notificationRecipientScope: polymorphic schema; accepts an untyped value
- instanceEnumerationScope: polymorphic schema; accepts an untyped value
- instances[].decisions[].insights[]: nested schema exceeds depth limit; accepts an untyped value
- instances[].decisions[].permission: polymorphic schema; accepts an untyped value
- instances[].stages[].decisions[]: nested schema exceeds depth limit; accepts an untyped value
- instances[].stages[].fallbackReviewers[]: nested schema exceeds depth limit; accepts an untyped value
- instances[].stages[].reviewers[]: nested schema exceeds depth limit; accepts an untyped value
- scope: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
