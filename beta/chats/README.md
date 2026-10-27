# /chats

Create chat

[Catalog](../README.md) Â· [Teamwork and communications](../README.md#teamwork-and-communications) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/chat?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /chats`, `GET/PATCH/DELETE /chats/{chat-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/chats"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `chat_type` | `chatType` | `string` | no | no | in place |
| `installed_apps` | `installedApps` | `any` | no | no | in place |
| `last_message_preview` | `lastMessagePreview` | `any` | no | no | in place |
| `members` | `members` | `any` | no | no | in place |
| `messages` | `messages` | `any` | no | no | in place |
| `migration_mode` | `migrationMode` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.operationError")       code = optional(string)       message = optional(string)     }))       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     }))` | no | no | in place |
| `original_created_date_time` | `originalCreatedDateTime` | `string` | no | no | in place |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no | in place |
| `pinned_messages` | `pinnedMessages` | `list(object({       odata_type = optional(string, "#microsoft.graph.pinnedChatMessageInfo")       message = optional(any)     }))` | no | no | in place |
| `tabs` | `tabs` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       messageId = optional(string)       sortOrderIndex = optional(string)       teamsApp = optional(any)       teamsAppId = optional(string)     }))` | no | no | in place |
| `targeted_messages` | `targetedMessages` | `list(object({       odata_type = optional(string, "#microsoft.graph.targetedChatMessage")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageBody")       content = optional(string)       contentType = optional(string)       messageBodyContentType = optional(string)     }))       channelIdentity = optional(object({       odata_type = optional(string, "#microsoft.graph.channelIdentity")       channelId = optional(string)       teamId = optional(string)     }))       chatId = optional(string)       createdDateTime = optional(string)       from = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       hasReplies = optional(bool)       hostedContents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     })))       importance = optional(string)       locale = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMentionedIdentitySet")       application = optional(any)       conversation = optional(any)       device = optional(any)       tag = optional(any)       user = optional(any)     }))     })))       messageHistory = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionId = optional(string)       reactionType = optional(string)       user = optional(any)     }))     })))       messageType = optional(string)       onBehalfOf = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageFromIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       policyViolation = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessagePolicyViolation")       dlpAction = optional(string)       justificationText = optional(string)       policyTip = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessagePolicyViolationPolicyTip")       complianceUrl = optional(string)       generalText = optional(string)       matchedConditionDescriptions = optional(list(string))     }))       userAction = optional(string)       verdictDetails = optional(string)     }))       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionId = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })))       recipient = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     }))` | no | no | in place |
| `topic` | `topic` | `string` | no | no | in place |
| `viewpoint` | `viewpoint` | `object({       odata_type = optional(string, "#microsoft.graph.chatViewpoint")       isHidden = optional(bool)       lastMessageReadDateTime = optional(string)     })` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `createdBy`, `createdDateTime`, `id`, `isHiddenForAllMembers`, `lastUpdatedDateTime`, `onlineMeetingInfo`, `tenantId`, `webUrl`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

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
- operations[].operationType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: teamifyGroup, createChannel, createChat, archiveChannel, unarchiveChannel; excluded from typed input validation
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
- targetedMessages[].messageType: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: systemEventMessage; excluded from typed input validation
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
