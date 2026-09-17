# /teams/{team-id}/channels/{channel-id}/messages/{chatMessage-id}/replies

Send replies to a message in a channel

[Catalog](../../../../../../../../README.md) · [Teamwork and communications](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/chatmessage?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teams/{team-id}/channels/{channel-id}/messages/{chatMessage-id}/replies`, `GET/PATCH/DELETE /teams/{team-id}/channels/{channel-id}/messages/{chatMessage-id}/replies/{chatMessage-id1}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/teams/by-team-id/channels/by-channel-id/messages/by-chat-message-id/replies"
  team_id = "parent-object-id"
  channel_id = "parent-object-id"
  chat_message_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `team_id` | URL parameter `team-id` | `string` | yes | no |
| `channel_id` | URL parameter `channel-id` | `string` | yes | no |
| `chat_message_id` | URL parameter `chatMessage-id` | `string` | yes | no |
| `attachments` | `attachments` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     }))` | no | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     })` | no | no |
| `channel_identity` | `channelIdentity` | `any` | no | no |
| `chat_id` | `chatId` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `from` | `from` | `any` | no | no |
| `has_replies` | `hasReplies` | `bool` | no | no |
| `hosted_contents` | `hostedContents` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     }))` | no | no |
| `importance` | `importance` | `string` | no | no |
| `locale` | `locale` | `string` | no | no |
| `mentions` | `mentions` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(any)     }))` | no | no |
| `message_history` | `messageHistory` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(any)     }))` | no | no |
| `message_type` | `messageType` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `on_behalf_of` | `onBehalfOf` | `any` | no | no |
| `policy_violation` | `policyViolation` | `any` | no | no |
| `reactions` | `reactions` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     }))` | no | no |
| `replies` | `replies` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     })))       importance = optional(string)       locale = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(any)     })))       messageHistory = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(any)     })))       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })))       replies = optional(any)       subject = optional(string)       summary = optional(string)     }))` | no | no |
| `subject` | `subject` | `string` | no | no |
| `summary` | `summary` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- body.contentType: polymorphic schema; accepts an untyped value
- body.messageBodyContentType: polymorphic schema; accepts an untyped value
- channelIdentity: polymorphic schema; accepts an untyped value
- from: polymorphic schema; accepts an untyped value
- mentions[].mentioned: polymorphic schema; accepts an untyped value
- messageHistory[].reaction: polymorphic schema; accepts an untyped value
- onBehalfOf: polymorphic schema; accepts an untyped value
- policyViolation: polymorphic schema; accepts an untyped value
- reactions[].user.application: polymorphic schema; accepts an untyped value
- reactions[].user.device: polymorphic schema; accepts an untyped value
- reactions[].user.user: polymorphic schema; accepts an untyped value
- replies[].body.contentType: polymorphic schema; accepts an untyped value
- replies[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- replies[].channelIdentity: polymorphic schema; accepts an untyped value
- replies[].from: polymorphic schema; accepts an untyped value
- replies[].mentions[].mentioned: polymorphic schema; accepts an untyped value
- replies[].messageHistory[].reaction: polymorphic schema; accepts an untyped value
- replies[].onBehalfOf: polymorphic schema; accepts an untyped value
- replies[].policyViolation: polymorphic schema; accepts an untyped value
- replies[].reactions[].user.application: polymorphic schema; accepts an untyped value
- replies[].reactions[].user.device: polymorphic schema; accepts an untyped value
- replies[].reactions[].user.user: polymorphic schema; accepts an untyped value
- replies[].replies[]: recursive schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
