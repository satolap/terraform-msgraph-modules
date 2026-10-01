# /app/onlineMeetings

Create new navigation property to onlineMeetings for app

[Catalog](../../../README.md) · [Teamwork and communications](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /app/onlineMeetings`, `GET/PATCH/DELETE /app/onlineMeetings/{onlineMeeting-id}`.

This module manages the same `microsoft.graph.onlineMeeting` objects as the canonical module [`/me/onlineMeetings`](../../me/online-meetings/README.md); manage each object through only one of them.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/teamwork-and-communications/app/online-meetings?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allow_attendee_to_enable_camera` | `allowAttendeeToEnableCamera` | `bool` | no | no |
| `allow_attendee_to_enable_mic` | `allowAttendeeToEnableMic` | `bool` | no | no |
| `allow_breakout_rooms` | `allowBreakoutRooms` | `bool` | no | no |
| `allow_copying_and_sharing_meeting_content` | `allowCopyingAndSharingMeetingContent` | `bool` | no | no |
| `allow_live_share` | `allowLiveShare` | `string` | no | no |
| `allow_meeting_chat` | `allowMeetingChat` | `string` | no | no |
| `allow_participants_to_change_name` | `allowParticipantsToChangeName` | `bool` | no | no |
| `allow_power_point_sharing` | `allowPowerPointSharing` | `bool` | no | no |
| `allow_recording` | `allowRecording` | `bool` | no | no |
| `allow_teamwork_reactions` | `allowTeamworkReactions` | `bool` | no | no |
| `allow_transcription` | `allowTranscription` | `bool` | no | no |
| `allow_whiteboard` | `allowWhiteboard` | `bool` | no | no |
| `allowed_lobby_admitters` | `allowedLobbyAdmitters` | `string` | no | no |
| `allowed_presenters` | `allowedPresenters` | `string` | no | no |
| `anonymize_identity_for_roles` | `anonymizeIdentityForRoles` | `list(string)` | no | no |
| `broadcast_recording` | `broadcastRecording` | `string` | no | no |
| `broadcast_settings` | `broadcastSettings` | `object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingCaptionSettings")       isCaptionEnabled = optional(bool)       spokenLanguage = optional(string)       translationLanguages = optional(list(string))     }))       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     })` | no | no |
| `capabilities` | `capabilities` | `list(string)` | no | no |
| `chat_info` | `chatInfo` | `object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     })` | no | no |
| `chat_restrictions` | `chatRestrictions` | `object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     })` | no | no |
| `end_date_time` | `endDateTime` | `string` | no | no |
| `expiry_date_time` | `expiryDateTime` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `is_broadcast` | `isBroadcast` | `bool` | no | no |
| `is_end_to_end_encryption_enabled` | `isEndToEndEncryptionEnabled` | `bool` | no | no |
| `is_entry_exit_announced` | `isEntryExitAnnounced` | `bool` | no | no |
| `join_meeting_id_settings` | `joinMeetingIdSettings` | `object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     })` | no | no |
| `join_url` | `joinUrl` | `string` | no | no |
| `lobby_bypass_settings` | `lobbyBypassSettings` | `object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     })` | no | no |
| `meeting_options_web_url` | `meetingOptionsWebUrl` | `string` | no | no |
| `meeting_spoken_language_tag` | `meetingSpokenLanguageTag` | `string` | no | no |
| `meeting_template_id` | `meetingTemplateId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `participants` | `participants` | `object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       contributors = optional(any)       organizer = optional(any)       producers = optional(any)     })` | no | no |
| `record_automatically` | `recordAutomatically` | `bool` | no | no |
| `registration` | `registration` | `any` | no | no |
| `sensitivity_label_assignment` | `sensitivityLabelAssignment` | `object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     })` | no | no |
| `share_meeting_chat_history_default` | `shareMeetingChatHistoryDefault` | `string` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `subject` | `subject` | `string` | no | no |
| `watermark_protection` | `watermarkProtection` | `object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     })` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- participants.attendees[]: polymorphic schema; accepts an untyped value
- participants.contributors[]: polymorphic schema; accepts an untyped value
- participants.organizer: polymorphic schema; accepts an untyped value
- participants.producers[]: polymorphic schema; accepts an untyped value
- registration: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
