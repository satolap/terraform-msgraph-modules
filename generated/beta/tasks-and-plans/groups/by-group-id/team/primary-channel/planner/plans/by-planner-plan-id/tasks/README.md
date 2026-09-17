# /groups/{group-id}/team/primaryChannel/planner/plans/{plannerPlan-id}/tasks

Create new navigation property to tasks for groups

[Catalog](../../../../../../../../../README.md) · [Tasks and plans](../../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/plannertask?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/team/primaryChannel/planner/plans/{plannerPlan-id}/tasks`, `GET/PATCH/DELETE /groups/{group-id}/team/primaryChannel/planner/plans/{plannerPlan-id}/tasks/{plannerTask-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tasks-and-plans/groups/by-group-id/team/primary-channel/planner/plans/by-planner-plan-id/tasks"
  group_id = "parent-object-id"
  planner_plan_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `planner_plan_id` | URL parameter `plannerPlan-id` | `string` | yes | no |
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
| `preview_type` | `previewType` | `any` | no | no |
| `priority` | `priority` | `number` | no | no |
| `recurrence` | `recurrence` | `any` | no | no |
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
- previewType: polymorphic schema; accepts an untyped value
- recurrence: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
