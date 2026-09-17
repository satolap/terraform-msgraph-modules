# /security/labels/retentionLabels

Create retentionLabel

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-retentionlabel?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/labels/retentionLabels`, `GET/PATCH/DELETE /security/labels/retentionLabels/{retentionLabel-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/labels/retention-labels"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `action_after_retention_period` | `actionAfterRetentionPeriod` | `any` | no | no |
| `behavior_during_retention_period` | `behaviorDuringRetentionPeriod` | `any` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `default_record_behavior` | `defaultRecordBehavior` | `any` | no | no |
| `description_for_admins` | `descriptionForAdmins` | `string` | no | no |
| `description_for_users` | `descriptionForUsers` | `string` | no | no |
| `descriptors` | `descriptors` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `disposition_review_stages` | `dispositionReviewStages` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.dispositionReviewStage")       name = optional(string)       reviewersEmailAddresses = optional(list(string))       stageNumber = optional(string)     }))` | no | no |
| `is_in_use` | `isInUse` | `bool` | no | no |
| `label_to_be_applied` | `labelToBeApplied` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `retention_duration` | `retentionDuration` | `any` | no | no |
| `retention_event_type` | `retentionEventType` | `any` | no | no |
| `retention_trigger` | `retentionTrigger` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- actionAfterRetentionPeriod: polymorphic schema; accepts an untyped value
- behaviorDuringRetentionPeriod: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- defaultRecordBehavior: polymorphic schema; accepts an untyped value
- descriptors: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- retentionDuration: polymorphic schema; accepts an untyped value
- retentionEventType: polymorphic schema; accepts an untyped value
- retentionTrigger: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
