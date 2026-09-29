# /users/{user-id}/outlook/taskFolders/{outlookTaskFolder-id}/tasks

Create new navigation property to tasks for users

[Catalog](../../../../../../../README.md) · [To-do tasks](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/outlooktask?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/outlook/taskFolders/{outlookTaskFolder-id}/tasks`, `GET/PATCH/DELETE /users/{user-id}/outlook/taskFolders/{outlookTaskFolder-id}/tasks/{outlookTask-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./to-do-tasks/users/by-user-id/outlook/task-folders/by-outlook-task-folder-id/tasks"
  user_id = "parent-object-id"
  outlook_task_folder_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `outlook_task_folder_id` | URL parameter `outlookTaskFolder-id` | `string` | yes | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no |
| `categories` | `categories` | `list(string)` | no | no |
| `completed_date_time` | `completedDateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `due_date_time` | `dueDateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `has_attachments` | `hasAttachments` | `bool` | no | no |
| `importance` | `importance` | `string` | no | no |
| `is_reminder_on` | `isReminderOn` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `owner` | `owner` | `string` | no | no |
| `parent_folder_id` | `parentFolderId` | `string` | no | no |
| `recurrence` | `recurrence` | `object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     })` | no | no |
| `reminder_date_time` | `reminderDateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `sensitivity` | `sensitivity` | `string` | no | no |
| `start_date_time` | `startDateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `status` | `status` | `string` | no | no |
| `subject` | `subject` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
