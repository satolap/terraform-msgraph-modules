# /communications/onlineMeetingConversations

Create new navigation property to onlineMeetingConversations for communications

[Catalog](../../../README.md) · [Teamwork and communications](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeetingengagementconversation?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/onlineMeetingConversations`, `GET/PATCH/DELETE /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/teamwork-and-communications/communications/online-meeting-conversations?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `creation_mode` | `creationMode` | `string` | no | no |
| `messages` | `messages` | `any` | no | no |
| `moderation_state` | `moderationState` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `online_meeting` | `onlineMeeting` | `object({       odata_type = optional(string, "#microsoft.graph.onlineMeeting")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       anonymizeIdentityForRoles = optional(list(string))       broadcastRecording = optional(string)       broadcastSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingCaptionSettings")       isCaptionEnabled = optional(bool)       spokenLanguage = optional(string)       translationLanguages = optional(list(string))     }))       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     }))       capabilities = optional(list(string))       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(string)       expiryDateTime = optional(string)       externalId = optional(string)       isBroadcast = optional(bool)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       joinUrl = optional(string)       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       meetingTemplateId = optional(string)       participants = optional(object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       contributors = optional(any)       organizer = optional(any)       producers = optional(any)     }))       recordAutomatically = optional(bool)       registration = optional(any)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(string)       subject = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     })` | no | no |
| `online_meeting_id` | `onlineMeetingId` | `string` | no | no |
| `starter` | `starter` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- messages[]: polymorphic schema; accepts an untyped value
- onlineMeeting.participants.attendees[]: polymorphic schema; accepts an untyped value
- onlineMeeting.participants.contributors[]: polymorphic schema; accepts an untyped value
- onlineMeeting.participants.organizer: polymorphic schema; accepts an untyped value
- onlineMeeting.participants.producers[]: polymorphic schema; accepts an untyped value
- onlineMeeting.registration: navigation property; accepts an untyped value
- starter: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
