# /me/activities

Create new navigation property to activities for me

[Catalog](../../../README.md) · [Cross-device experiences](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/project-rome-overview?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /me/activities`, `GET/PATCH/DELETE /me/activities/{userActivity-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./cross-device-experiences/me/activities"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `activation_url` | `activationUrl` | `string` | no | no |
| `activity_source_host` | `activitySourceHost` | `string` | no | no |
| `app_activity_id` | `appActivityId` | `string` | no | no |
| `app_display_name` | `appDisplayName` | `string` | no | no |
| `content_info` | `contentInfo` | `any` | no | no |
| `content_url` | `contentUrl` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `fallback_url` | `fallbackUrl` | `string` | no | no |
| `history_items` | `historyItems` | `list(object({       odata_type = optional(string, "#microsoft.graph.activityHistoryItem")       activeDurationSeconds = optional(number)       activity = optional(object({       odata_type = optional(string, "#microsoft.graph.userActivity")       activationUrl = optional(string)       activitySourceHost = optional(string)       appActivityId = optional(string)       appDisplayName = optional(string)       contentInfo = optional(any)       contentUrl = optional(string)       createdDateTime = optional(string)       expirationDateTime = optional(string)       fallbackUrl = optional(string)       historyItems = optional(any)       lastModifiedDateTime = optional(string)       status = optional(any)       userTimezone = optional(string)       visualElements = optional(object({       odata_type = optional(string, "#microsoft.graph.visualInfo")       attribution = optional(any)       backgroundColor = optional(string)       content = optional(any)       description = optional(string)       displayText = optional(string)     }))     }))       createdDateTime = optional(string)       expirationDateTime = optional(string)       lastActiveDateTime = optional(string)       lastModifiedDateTime = optional(string)       startedDateTime = optional(string)       status = optional(any)       userTimezone = optional(string)     }))` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `status` | `status` | `any` | no | no |
| `user_timezone` | `userTimezone` | `string` | no | no |
| `visual_elements` | `visualElements` | `object({       odata_type = optional(string, "#microsoft.graph.visualInfo")       attribution = optional(any)       backgroundColor = optional(string)       content = optional(any)       description = optional(string)       displayText = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- historyItems[].activity.historyItems[]: recursive schema; accepts an untyped value
- historyItems[].activity.status: polymorphic schema; accepts an untyped value
- historyItems[].activity.visualElements.attribution: polymorphic schema; accepts an untyped value
- historyItems[].status: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- visualElements.attribution: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
