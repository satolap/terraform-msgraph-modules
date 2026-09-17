# /teamTemplateDefinition/{teamTemplateDefinition-id}/teamDefinition/channels/{channel-id}/planner/plans/{plannerPlan-id}/tasks/{plannerTask-id}/messages

Create new navigation property to messages for teamTemplateDefinition

[Catalog](../../../../README.md) · [Tasks and plans](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/plannertaskchatmessage?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teamTemplateDefinition/{teamTemplateDefinition-id}/teamDefinition/channels/{channel-id}/planner/plans/{plannerPlan-id}/tasks/{plannerTask-id}/messages`, `GET/PATCH/DELETE /teamTemplateDefinition/{teamTemplateDefinition-id}/teamDefinition/channels/{channel-id}/planner/plans/{plannerPlan-id}/tasks/{plannerTask-id}/messages/{plannerTaskChatMessage-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./tasks-and-plans/team-template-definition/by-path-139a0b1c6251/messages"
  team_template_definition_id = "parent-object-id"
  channel_id = "parent-object-id"
  planner_plan_id = "parent-object-id"
  planner_task_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `team_template_definition_id` | URL parameter `teamTemplateDefinition-id` | `string` | yes | no |
| `channel_id` | URL parameter `channel-id` | `string` | yes | no |
| `planner_plan_id` | URL parameter `plannerPlan-id` | `string` | yes | no |
| `planner_task_id` | URL parameter `plannerTask-id` | `string` | yes | no |
| `content` | `content` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `edited_date_time` | `editedDateTime` | `string` | no | no |
| `mentions` | `mentions` | `list(object({       odata_type = optional(string, "#microsoft.graph.plannerTaskChatMention")       mentionType = optional(string)       mentioned = optional(string)       position = optional(number)     }))` | no | no |
| `message_type` | `messageType` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `parent_entity_id` | `parentEntityId` | `string` | no | no |
| `reactions` | `reactions` | `list(object({       odata_type = optional(string, "#microsoft.graph.plannerTaskChatReaction")       reactionEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.plannerTaskChatReactionEvent")       createdBy = optional(any)       createdDateTime = optional(string)     })))       reactionType = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- createdBy: polymorphic schema; accepts an untyped value
- reactions[].reactionEvents[].createdBy: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
