# /groups/{group-id}/conversations/{conversation-id}/threads

Create thread

[Catalog](../../../../../../README.md) · [Groups](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /groups/{group-id}/conversations/{conversation-id}/threads`, `GET/PATCH/DELETE /groups/{group-id}/conversations/{conversation-id}/threads/{conversationThread-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./groups/groups/by-group-id/conversations/by-conversation-id/threads"
  group_id = "parent-object-id"
  conversation_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `group_id` | URL parameter `group-id` | `string` | yes | no |
| `conversation_id` | URL parameter `conversation-id` | `string` | yes | no |
| `cc_recipients` | `ccRecipients` | `list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     }))` | no | no |
| `has_attachments` | `hasAttachments` | `bool` | no | no |
| `is_locked` | `isLocked` | `bool` | no | no |
| `last_delivered_date_time` | `lastDeliveredDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `posts` | `posts` | `list(object({       odata_type = optional(string, "#microsoft.graph.post")       body = optional(any)       categories = optional(list(string))       createdDateTime = optional(string)       from = optional(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     }))       hasAttachments = optional(bool)       importance = optional(any)       lastModifiedDateTime = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mention")       application = optional(string)       clientReference = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       deepLink = optional(string)       mentionText = optional(string)       mentioned = optional(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))       serverCreatedDateTime = optional(string)     })))       newParticipants = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       receivedDateTime = optional(string)       sender = optional(any)     }))` | no | no |
| `preview` | `preview` | `string` | no | no |
| `to_recipients` | `toRecipients` | `list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     }))` | no | no |
| `topic` | `topic` | `string` | no | no |
| `unique_senders` | `uniqueSenders` | `list(string)` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- ccRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- posts[].body: polymorphic schema; accepts an untyped value
- posts[].from.emailAddress: polymorphic schema; accepts an untyped value
- posts[].importance: polymorphic schema; accepts an untyped value
- posts[].mentions[].createdBy: polymorphic schema; accepts an untyped value
- posts[].newParticipants[].emailAddress: polymorphic schema; accepts an untyped value
- posts[].sender: polymorphic schema; accepts an untyped value
- toRecipients[].emailAddress: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
