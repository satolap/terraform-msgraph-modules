# /communications/onlineMeetingConversations

Create new navigation property to onlineMeetingConversations for communications

[Catalog](../../../README.md) · [Teamwork and communications](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeetingengagementconversation?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/onlineMeetingConversations`, `GET/PATCH/DELETE /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/communications/online-meeting-conversations"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `creation_mode` | `creationMode` | `string` | no | no |
| `messages` | `messages` | `list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       conversation = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementConversation")       creationMode = optional(string)       messages = optional(any)       starter = optional(any)       starterId = optional(string)     }))       creationMode = optional(string)       from = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")       reactionBy = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     }))       reactionType = optional(string)     })))       replies = optional(any)       replyTo = optional(any)       replyToId = optional(string)     }))` | no | no |
| `moderation_state` | `moderationState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `online_meeting` | `onlineMeeting` | `object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       broadcastSettings = optional(any)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(any)       recordAutomatically = optional(bool)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(any)     })` | no | no |
| `online_meeting_id` | `onlineMeetingId` | `string` | no | no |
| `organizer` | `organizer` | `object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     })` | no | no |
| `starter` | `starter` | `object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessage")       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       conversation = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementConversation")       creationMode = optional(string)       messages = optional(any)       starter = optional(any)       starterId = optional(string)     }))       creationMode = optional(string)       from = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")       reactionBy = optional(object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     }))       reactionType = optional(string)     })))       replies = optional(any)       replyTo = optional(any)       replyToId = optional(string)     })` | no | no |
| `starter_id` | `starterId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- messages[].body.contentType: polymorphic schema; accepts an untyped value
- messages[].conversation.messages[]: recursive schema; accepts an untyped value
- messages[].conversation.starter: recursive schema; accepts an untyped value
- messages[].from: polymorphic schema; accepts an untyped value
- messages[].reactions[].reactionBy.application: polymorphic schema; accepts an untyped value
- messages[].reactions[].reactionBy.audience: polymorphic schema; accepts an untyped value
- messages[].reactions[].reactionBy.device: polymorphic schema; accepts an untyped value
- messages[].reactions[].reactionBy.group: polymorphic schema; accepts an untyped value
- messages[].reactions[].reactionBy.user: polymorphic schema; accepts an untyped value
- messages[].replies[]: recursive schema; accepts an untyped value
- messages[].replyTo: polymorphic schema; accepts an untyped value
- onlineMeeting.allowLiveShare: polymorphic schema; accepts an untyped value
- onlineMeeting.allowMeetingChat: polymorphic schema; accepts an untyped value
- onlineMeeting.allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- onlineMeeting.allowedPresenters: polymorphic schema; accepts an untyped value
- onlineMeeting.broadcastSettings: polymorphic schema; accepts an untyped value
- onlineMeeting.chatInfo: polymorphic schema; accepts an untyped value
- onlineMeeting.chatRestrictions: polymorphic schema; accepts an untyped value
- onlineMeeting.joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- onlineMeeting.lobbyBypassSettings: polymorphic schema; accepts an untyped value
- onlineMeeting.participants: polymorphic schema; accepts an untyped value
- onlineMeeting.sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- onlineMeeting.shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- onlineMeeting.watermarkProtection: polymorphic schema; accepts an untyped value
- organizer.application: polymorphic schema; accepts an untyped value
- organizer.audience: polymorphic schema; accepts an untyped value
- organizer.device: polymorphic schema; accepts an untyped value
- organizer.group: polymorphic schema; accepts an untyped value
- organizer.user: polymorphic schema; accepts an untyped value
- starter.body.contentType: polymorphic schema; accepts an untyped value
- starter.conversation.messages[]: recursive schema; accepts an untyped value
- starter.conversation.starter: recursive schema; accepts an untyped value
- starter.from: polymorphic schema; accepts an untyped value
- starter.reactions[].reactionBy.application: polymorphic schema; accepts an untyped value
- starter.reactions[].reactionBy.audience: polymorphic schema; accepts an untyped value
- starter.reactions[].reactionBy.device: polymorphic schema; accepts an untyped value
- starter.reactions[].reactionBy.group: polymorphic schema; accepts an untyped value
- starter.reactions[].reactionBy.user: polymorphic schema; accepts an untyped value
- starter.replies[]: recursive schema; accepts an untyped value
- starter.replyTo: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
