# /users/{user-id}/chats

Create new navigation property to chats for users

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/chat?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/chats`, `GET/PATCH/DELETE /users/{user-id}/chats/{chat-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/users/by-user-id/chats"
  user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `chat_type` | `chatType` | `string` | no | no |
| `installed_apps` | `installedApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppInstallation")       consentedPermissionSet = optional(any)       scopeInfo = optional(any)       teamsApp = optional(any)       teamsAppDefinition = optional(any)     }))` | no | no |
| `last_message_preview` | `lastMessagePreview` | `any` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     }))` | no | no |
| `messages` | `messages` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     })))       importance = optional(string)       locale = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(any)     })))       messageHistory = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(any)     })))       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })))       replies = optional(any)       subject = optional(string)       summary = optional(string)     }))` | no | no |
| `migration_mode` | `migrationMode` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     }))` | no | no |
| `original_created_date_time` | `originalCreatedDateTime` | `string` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `pinned_messages` | `pinnedMessages` | `list(object({       odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")       message = optional(any)     }))` | no | no |
| `tabs` | `tabs` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     }))` | no | no |
| `targeted_messages` | `targetedMessages` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedChatMessage")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     })))       importance = optional(string)       locale = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(any)     })))       messageHistory = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(any)     })))       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })))       recipient = optional(any)       replies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(any)       messageBodyContentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hasReplies = optional(bool)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       onBehalfOf = optional(any)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       subject = optional(string)       summary = optional(string)     }))` | no | no |
| `topic` | `topic` | `string` | no | no |
| `viewpoint` | `viewpoint` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- installedApps[].consentedPermissionSet: polymorphic schema; accepts an untyped value
- installedApps[].scopeInfo: polymorphic schema; accepts an untyped value
- installedApps[].teamsApp: polymorphic schema; accepts an untyped value
- installedApps[].teamsAppDefinition: polymorphic schema; accepts an untyped value
- lastMessagePreview: polymorphic schema; accepts an untyped value
- messages[].body.contentType: polymorphic schema; accepts an untyped value
- messages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- messages[].channelIdentity: polymorphic schema; accepts an untyped value
- messages[].from: polymorphic schema; accepts an untyped value
- messages[].mentions[].mentioned: polymorphic schema; accepts an untyped value
- messages[].messageHistory[].reaction: polymorphic schema; accepts an untyped value
- messages[].onBehalfOf: polymorphic schema; accepts an untyped value
- messages[].policyViolation: polymorphic schema; accepts an untyped value
- messages[].reactions[].user.application: polymorphic schema; accepts an untyped value
- messages[].reactions[].user.device: polymorphic schema; accepts an untyped value
- messages[].reactions[].user.user: polymorphic schema; accepts an untyped value
- messages[].replies[]: recursive schema; accepts an untyped value
- migrationMode: polymorphic schema; accepts an untyped value
- operations[].error: polymorphic schema; accepts an untyped value
- pinnedMessages[].message: polymorphic schema; accepts an untyped value
- tabs[].configuration: polymorphic schema; accepts an untyped value
- tabs[].teamsApp: polymorphic schema; accepts an untyped value
- targetedMessages[].body.contentType: polymorphic schema; accepts an untyped value
- targetedMessages[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- targetedMessages[].channelIdentity: polymorphic schema; accepts an untyped value
- targetedMessages[].from: polymorphic schema; accepts an untyped value
- targetedMessages[].mentions[].mentioned: polymorphic schema; accepts an untyped value
- targetedMessages[].messageHistory[].reaction: polymorphic schema; accepts an untyped value
- targetedMessages[].onBehalfOf: polymorphic schema; accepts an untyped value
- targetedMessages[].policyViolation: polymorphic schema; accepts an untyped value
- targetedMessages[].reactions[].user.application: polymorphic schema; accepts an untyped value
- targetedMessages[].reactions[].user.device: polymorphic schema; accepts an untyped value
- targetedMessages[].reactions[].user.user: polymorphic schema; accepts an untyped value
- targetedMessages[].recipient: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].replies[].body.contentType: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].body.messageBodyContentType: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].channelIdentity: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].from: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].replies[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].replies[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].replies[].onBehalfOf: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].policyViolation: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].replies[].replies[]: recursive schema; accepts an untyped value
- viewpoint: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
