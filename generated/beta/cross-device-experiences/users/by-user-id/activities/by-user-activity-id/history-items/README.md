# /users/{user-id}/activities/{userActivity-id}/historyItems

Create new navigation property to historyItems for users

[Catalog](../../../../../../README.md) · [Cross-device experiences](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/project-rome-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/activities/{userActivity-id}/historyItems`, `GET/PATCH/DELETE /users/{user-id}/activities/{userActivity-id}/historyItems/{activityHistoryItem-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./cross-device-experiences/users/by-user-id/activities/by-user-activity-id/history-items"
  user_id = "parent-object-id"
  user_activity_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `user_activity_id` | URL parameter `userActivity-id` | `string` | yes | no |
| `active_duration_seconds` | `activeDurationSeconds` | `number` | no | no |
| `activity` | `activity` | `object({       odata_type = optional(string, "#microsoft.graph.userActivity")       activationUrl = optional(string)       activitySourceHost = optional(string)       appActivityId = optional(string)       appDisplayName = optional(string)       contentInfo = optional(any)       contentUrl = optional(string)       createdDateTime = optional(string)       expirationDateTime = optional(string)       fallbackUrl = optional(string)       historyItems = optional(list(object({       odata_type = optional(string, "#microsoft.graph.activityHistoryItem")       activeDurationSeconds = optional(number)       activity = optional(any)       createdDateTime = optional(string)       expirationDateTime = optional(string)       lastActiveDateTime = optional(string)       lastModifiedDateTime = optional(string)       startedDateTime = optional(string)       status = optional(any)       userTimezone = optional(string)     })))       lastModifiedDateTime = optional(string)       status = optional(any)       userTimezone = optional(string)       visualElements = optional(object({       odata_type = optional(string, "#microsoft.graph.visualInfo")       attribution = optional(any)       backgroundColor = optional(string)       content = optional(any)       description = optional(string)       displayText = optional(string)     }))     })` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `last_active_date_time` | `lastActiveDateTime` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `started_date_time` | `startedDateTime` | `string` | no | no |
| `status` | `status` | `any` | no | no |
| `user_timezone` | `userTimezone` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- activity.historyItems[].activity: recursive schema; accepts an untyped value
- activity.historyItems[].status: polymorphic schema; accepts an untyped value
- activity.status: polymorphic schema; accepts an untyped value
- activity.visualElements.attribution: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
