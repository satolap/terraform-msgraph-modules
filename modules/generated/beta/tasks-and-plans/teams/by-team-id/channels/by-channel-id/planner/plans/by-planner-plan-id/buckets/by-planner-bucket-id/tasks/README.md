# /teams/{team-id}/channels/{channel-id}/planner/plans/{plannerPlan-id}/buckets/{plannerBucket-id}/tasks

Create new navigation property to tasks for teams

[Catalog](../../../../../../../../../../../README.md) · [Tasks and plans](../../../../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/plannertask?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teams/{team-id}/channels/{channel-id}/planner/plans/{plannerPlan-id}/buckets/{plannerBucket-id}/tasks`, `GET/PATCH/DELETE /teams/{team-id}/channels/{channel-id}/planner/plans/{plannerPlan-id}/buckets/{plannerBucket-id}/tasks/{plannerTask-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/tasks-and-plans/teams/by-team-id/channels/by-channel-id/planner/plans/by-planner-plan-id/buckets/by-planner-bucket-id/tasks?ref=<release-tag>"
  team_id = "parent-object-id"
  channel_id = "parent-object-id"
  planner_plan_id = "parent-object-id"
  planner_bucket_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `team_id` | URL parameter `team-id` | `string` | yes | no |
| `channel_id` | URL parameter `channel-id` | `string` | yes | no |
| `planner_plan_id` | URL parameter `plannerPlan-id` | `string` | yes | no |
| `planner_bucket_id` | URL parameter `plannerBucket-id` | `string` | yes | no |
| `active_checklist_item_count` | `activeChecklistItemCount` | `number` | no | no |
| `applied_categories` | `appliedCategories` | `any` | no | no |
| `assignee_priority` | `assigneePriority` | `string` | no | no |
| `assignments` | `assignments` | `any` | no | no |
| `bucket_id` | `bucketId` | `string` | no | no |
| `checklist_item_count` | `checklistItemCount` | `number` | no | no |
| `completed_by` | `completedBy` | `any` | no | no |
| `conversation_thread_id` | `conversationThreadId` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `creation_source` | `creationSource` | `any` | no | no |
| `due_date_time` | `dueDateTime` | `string` | no | no |
| `is_on_my_day` | `isOnMyDay` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `order_hint` | `orderHint` | `string` | no | no |
| `percent_complete` | `percentComplete` | `number` | no | no |
| `plan_id` | `planId` | `string` | no | no |
| `preview_type` | `previewType` | `string` | no | no |
| `priority` | `priority` | `number` | no | no |
| `recurrence` | `recurrence` | `object({       odata_type = optional(string, "#microsoft.graph.plannerTaskRecurrence")       nextInSeriesTaskId = optional(string)       occurrenceId = optional(number)       previousInSeriesTaskId = optional(string)       recurrenceStartDateTime = optional(string)       schedule = optional(object({       odata_type = optional(string, "#microsoft.graph.plannerRecurrenceSchedule")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       patternStartDateTime = optional(string)     }))       seriesId = optional(string)     })` | no | no |
| `reference_count` | `referenceCount` | `number` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `title` | `title` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- appliedCategories: polymorphic schema; accepts an untyped value
- assignments: polymorphic schema; accepts an untyped value
- completedBy: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- creationSource: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
