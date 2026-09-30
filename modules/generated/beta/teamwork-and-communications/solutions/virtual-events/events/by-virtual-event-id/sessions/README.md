# /solutions/virtualEvents/events/{virtualEvent-id}/sessions

Create new navigation property to sessions for solutions

[Catalog](../../../../../../README.md) · [Teamwork and communications](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventsession?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /solutions/virtualEvents/events/{virtualEvent-id}/sessions`, `GET/PATCH/DELETE /solutions/virtualEvents/events/{virtualEvent-id}/sessions/{virtualEventSession-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/teamwork-and-communications/solutions/virtual-events/events/by-virtual-event-id/sessions?ref=<release-tag>"
  virtual_event_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `virtual_event_id` | URL parameter `virtualEvent-id` | `string` | yes | no |
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
| `capacity` | `capacity` | `number` | no | no |
| `chat_info` | `chatInfo` | `object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     })` | no | no |
| `chat_restrictions` | `chatRestrictions` | `object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     })` | no | no |
| `end_date_time` | `endDateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `expiry_date_time` | `expiryDateTime` | `string` | no | no |
| `is_end_to_end_encryption_enabled` | `isEndToEndEncryptionEnabled` | `bool` | no | no |
| `is_entry_exit_announced` | `isEntryExitAnnounced` | `bool` | no | no |
| `join_meeting_id_settings` | `joinMeetingIdSettings` | `object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     })` | no | no |
| `lobby_bypass_settings` | `lobbyBypassSettings` | `object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     })` | no | no |
| `meeting_options_web_url` | `meetingOptionsWebUrl` | `string` | no | no |
| `meeting_spoken_language_tag` | `meetingSpokenLanguageTag` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `presenters` | `presenters` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventPresenter")       email = optional(string)       identity = optional(any)       presenterDetails = optional(object({       odata_type = optional(string, "#microsoft.graph.virtualEventPresenterDetails")       bio = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       company = optional(string)       jobTitle = optional(string)       linkedInProfileWebUrl = optional(string)       personalSiteWebUrl = optional(string)       photo = optional(string)       twitterProfileWebUrl = optional(string)     }))       sessions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventSession")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       anonymizeIdentityForRoles = optional(list(string))       capacity = optional(number)       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       expiryDateTime = optional(string)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       presenters = optional(any)       recordAutomatically = optional(bool)       registrations = optional(any)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       videoOnDemandWebUrl = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     })))     }))` | no | no |
| `record_automatically` | `recordAutomatically` | `bool` | no | no |
| `registrations` | `registrations` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistration")       cancelationDateTime = optional(string)       email = optional(string)       externalRegistrationInformation = optional(object({       odata_type = optional(string, "#microsoft.graph.virtualEventExternalRegistrationInformation")       referrer = optional(string)       registrationId = optional(string)     }))       firstName = optional(string)       lastName = optional(string)       preferredLanguage = optional(string)       preferredTimezone = optional(string)       registrantVideoOnDemandWebUrl = optional(string)       registrationDateTime = optional(string)       registrationQuestionAnswers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistrationQuestionAnswer")       booleanValue = optional(bool)       displayName = optional(string)       multiChoiceValues = optional(list(string))       questionId = optional(string)       value = optional(string)     })))       sessions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventSession")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       anonymizeIdentityForRoles = optional(list(string))       capacity = optional(number)       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       expiryDateTime = optional(string)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       presenters = optional(any)       recordAutomatically = optional(bool)       registrations = optional(any)       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       videoOnDemandWebUrl = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     })))       userId = optional(string)     }))` | no | no |
| `sensitivity_label_assignment` | `sensitivityLabelAssignment` | `object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     })` | no | no |
| `share_meeting_chat_history_default` | `shareMeetingChatHistoryDefault` | `string` | no | no |
| `start_date_time` | `startDateTime` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `subject` | `subject` | `string` | no | no |
| `video_on_demand_web_url` | `videoOnDemandWebUrl` | `string` | no | no |
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
- presenters[].identity: polymorphic schema; accepts an untyped value
- presenters[].sessions[].presenters[]: recursive schema; accepts an untyped value
- presenters[].sessions[].registrations[]: nested schema exceeds depth limit; accepts an untyped value
- registrations[].sessions[].presenters[]: nested schema exceeds depth limit; accepts an untyped value
- registrations[].sessions[].registrations[]: recursive schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
