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
| `installed_apps` | `installedApps` | `any` | no | no |
| `last_message_preview` | `lastMessagePreview` | `any` | no | no |
| `members` | `members` | `any` | no | no |
| `messages` | `messages` | `any` | no | no |
| `migration_mode` | `migrationMode` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.operationError")       code = optional(string)       message = optional(string)     }))       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     }))` | no | no |
| `original_created_date_time` | `originalCreatedDateTime` | `string` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `pinned_messages` | `pinnedMessages` | `list(object({       odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")       message = optional(any)     }))` | no | no |
| `tabs` | `tabs` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     }))` | no | no |
| `targeted_messages` | `targetedMessages` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedChatMessage")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(string)       messageBodyContentType = optional(string)     }))       channelIdentity = optional(object({       odata_type = optional(string, "#microsoft.graph.channelIdentity")       channelId = optional(string)       teamId = optional(string)     }))       chatId = optional(string)       createdDateTime = optional(string)       from = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       hasReplies = optional(bool)       hostedContents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     })))       importance = optional(string)       locale = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMentionedIdentitySet")       application = optional(any)       conversation = optional(any)       device = optional(any)       tag = optional(any)       user = optional(any)     }))     })))       messageHistory = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(any)     }))     })))       messageType = optional(string)       onBehalfOf = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       policyViolation = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessagePolicyViolation")       dlpAction = optional(string)       justificationText = optional(string)       policyTip = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessagePolicyViolationPolicyTip")       complianceUrl = optional(string)       generalText = optional(string)       matchedConditionDescriptions = optional(list(string))     }))       userAction = optional(string)       verdictDetails = optional(string)     }))       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })))       recipient = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     }))` | no | no |
| `topic` | `topic` | `string` | no | no |
| `viewpoint` | `viewpoint` | `object({       odata_type = optional(string, "#microsoft.graph.chatViewpoint")       isHidden = optional(bool)       lastMessageReadDateTime = optional(string)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- installedApps[]: polymorphic schema; accepts an untyped value
- lastMessagePreview: navigation property; accepts an untyped value
- members[]: polymorphic schema; accepts an untyped value
- messages[]: polymorphic schema; accepts an untyped value
- pinnedMessages[].message: polymorphic schema; accepts an untyped value
- tabs[].teamsApp: navigation property; accepts an untyped value
- targetedMessages[].from.application: polymorphic schema; accepts an untyped value
- targetedMessages[].from.device: polymorphic schema; accepts an untyped value
- targetedMessages[].from.user: polymorphic schema; accepts an untyped value
- targetedMessages[].mentions[].mentioned.application: polymorphic schema; accepts an untyped value
- targetedMessages[].mentions[].mentioned.conversation: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].mentions[].mentioned.device: polymorphic schema; accepts an untyped value
- targetedMessages[].mentions[].mentioned.tag: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].mentions[].mentioned.user: polymorphic schema; accepts an untyped value
- targetedMessages[].messageHistory[].reaction.user: nested schema exceeds depth limit; accepts an untyped value
- targetedMessages[].onBehalfOf.application: polymorphic schema; accepts an untyped value
- targetedMessages[].onBehalfOf.device: polymorphic schema; accepts an untyped value
- targetedMessages[].onBehalfOf.user: polymorphic schema; accepts an untyped value
- targetedMessages[].reactions[].user.application: polymorphic schema; accepts an untyped value
- targetedMessages[].reactions[].user.device: polymorphic schema; accepts an untyped value
- targetedMessages[].reactions[].user.user: polymorphic schema; accepts an untyped value
- targetedMessages[].recipient: polymorphic schema; accepts an untyped value
- targetedMessages[].replies[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
