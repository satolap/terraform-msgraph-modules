# /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}/messages

Create new navigation property to messages for communications

[Catalog](../../../../../README.md) · [Teamwork and communications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}/messages`, `GET/PATCH/DELETE /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}/messages/{engagementConversationMessage-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/communications/online-meeting-conversations/by-online-meeting-engagement-conversation-id/messages"
  online_meeting_engagement_conversation_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `online_meeting_engagement_conversation_id` | URL parameter `onlineMeetingEngagementConversation-id` | `string` | yes | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     })` | no | no |
| `conversation` | `conversation` | `object({       odata_type = optional(string, "#microsoft.graph.engagementConversation")       creationMode = optional(string)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       conversation = optional(any)       creationMode = optional(string)       from = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")       reactionBy = optional(any)       reactionType = optional(string)     })))       replies = optional(any)       replyTo = optional(any)       replyToId = optional(string)     })))       starter = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       conversation = optional(any)       creationMode = optional(string)       from = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")       reactionBy = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     }))       reactionType = optional(string)     })))       replies = optional(any)       replyTo = optional(any)       replyToId = optional(string)     }))       starterId = optional(string)     })` | no | no |
| `creation_mode` | `creationMode` | `string` | no | no |
| `from` | `from` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `reactions` | `reactions` | `list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")       reactionBy = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     }))       reactionType = optional(string)     }))` | no | no |
| `replies` | `replies` | `list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       conversation = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementConversation")       creationMode = optional(string)       messages = optional(any)       starter = optional(any)       starterId = optional(string)     }))       creationMode = optional(string)       from = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")       reactionBy = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     }))       reactionType = optional(string)     })))       replies = optional(any)       replyTo = optional(any)       replyToId = optional(string)     }))` | no | no |
| `reply_to` | `replyTo` | `any` | no | no |
| `reply_to_id` | `replyToId` | `string` | no | no |
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
- conversation.messages[].body.contentType: polymorphic schema; accepts an untyped value
- conversation.messages[].conversation: recursive schema; accepts an untyped value
- conversation.messages[].from: polymorphic schema; accepts an untyped value
- conversation.messages[].reactions[].reactionBy: nested schema exceeds depth limit; accepts an untyped value
- conversation.messages[].replies[]: recursive schema; accepts an untyped value
- conversation.messages[].replyTo: polymorphic schema; accepts an untyped value
- conversation.starter.body.contentType: polymorphic schema; accepts an untyped value
- conversation.starter.conversation: recursive schema; accepts an untyped value
- conversation.starter.from: polymorphic schema; accepts an untyped value
- conversation.starter.reactions[].reactionBy.application: polymorphic schema; accepts an untyped value
- conversation.starter.reactions[].reactionBy.audience: polymorphic schema; accepts an untyped value
- conversation.starter.reactions[].reactionBy.device: polymorphic schema; accepts an untyped value
- conversation.starter.reactions[].reactionBy.group: polymorphic schema; accepts an untyped value
- conversation.starter.reactions[].reactionBy.user: polymorphic schema; accepts an untyped value
- conversation.starter.replies[]: recursive schema; accepts an untyped value
- conversation.starter.replyTo: polymorphic schema; accepts an untyped value
- from: polymorphic schema; accepts an untyped value
- reactions[].reactionBy.application: polymorphic schema; accepts an untyped value
- reactions[].reactionBy.audience: polymorphic schema; accepts an untyped value
- reactions[].reactionBy.device: polymorphic schema; accepts an untyped value
- reactions[].reactionBy.group: polymorphic schema; accepts an untyped value
- reactions[].reactionBy.user: polymorphic schema; accepts an untyped value
- replies[].body.contentType: polymorphic schema; accepts an untyped value
- replies[].conversation.messages[]: recursive schema; accepts an untyped value
- replies[].conversation.starter: recursive schema; accepts an untyped value
- replies[].from: polymorphic schema; accepts an untyped value
- replies[].reactions[].reactionBy.application: polymorphic schema; accepts an untyped value
- replies[].reactions[].reactionBy.audience: polymorphic schema; accepts an untyped value
- replies[].reactions[].reactionBy.device: polymorphic schema; accepts an untyped value
- replies[].reactions[].reactionBy.group: polymorphic schema; accepts an untyped value
- replies[].reactions[].reactionBy.user: polymorphic schema; accepts an untyped value
- replies[].replies[]: recursive schema; accepts an untyped value
- replies[].replyTo: polymorphic schema; accepts an untyped value
- replyTo: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
