# /solutions/virtualEvents/townhalls

Create virtualEventTownhall

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventtownhall?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /solutions/virtualEvents/townhalls`, `GET/PATCH/DELETE /solutions/virtualEvents/townhalls/{virtualEventTownhall-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/solutions/virtual-events/townhalls"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `audience` | `audience` | `any` | no | no |
| `capacity` | `capacity` | `number` | no | no |
| `co_organizers` | `coOrganizers` | `list(object({       odata_type = optional(string, "#microsoft.graph.communicationsUserIdentity")       displayName = optional(string)       id = optional(string)       tenantId = optional(string)     }))` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `description` | `description` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `end_date_time` | `endDateTime` | `any` | no | no |
| `external_event_information` | `externalEventInformation` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventExternalInformation")       externalEventId = optional(string)     }))` | no | no |
| `invited_attendees` | `invitedAttendees` | `list(object({       odata_type = optional(string, "#microsoft.graph.identity")       displayName = optional(string)       id = optional(string)     }))` | no | no |
| `is_invite_only` | `isInviteOnly` | `bool` | no | no |
| `is_registration_enabled` | `isRegistrationEnabled` | `bool` | no | no |
| `is_registration_required` | `isRegistrationRequired` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `presenters` | `presenters` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventPresenter")       email = optional(string)       identity = optional(any)       presenterDetails = optional(any)       sessions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventSession")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       capacity = optional(number)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(any)       expiryDateTime = optional(string)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       presenters = optional(any)       recordAutomatically = optional(bool)       registrations = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(any)       subject = optional(string)       videoOnDemandWebUrl = optional(string)       watermarkProtection = optional(any)     })))     }))` | no | no |
| `registration_configuration` | `registrationConfiguration` | `any` | no | no |
| `registrations` | `registrations` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistration")       cancelationDateTime = optional(string)       email = optional(string)       externalRegistrationInformation = optional(any)       firstName = optional(string)       lastName = optional(string)       preferredLanguage = optional(string)       preferredTimezone = optional(string)       registrantVideoOnDemandWebUrl = optional(string)       registrationDateTime = optional(string)       registrationQuestionAnswers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistrationQuestionAnswer")       booleanValue = optional(bool)       displayName = optional(string)       multiChoiceValues = optional(list(string))       questionId = optional(string)       value = optional(string)     })))       sessions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventSession")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       capacity = optional(number)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(any)       expiryDateTime = optional(string)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       presenters = optional(any)       recordAutomatically = optional(bool)       registrations = optional(any)       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(any)       subject = optional(string)       videoOnDemandWebUrl = optional(string)       watermarkProtection = optional(any)     })))       userId = optional(string)     }))` | no | no |
| `sessions` | `sessions` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventSession")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(any)       allowMeetingChat = optional(any)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(any)       allowedPresenters = optional(any)       anonymizeIdentityForRoles = optional(any)       capacity = optional(number)       chatInfo = optional(any)       chatRestrictions = optional(any)       endDateTime = optional(any)       expiryDateTime = optional(string)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(any)       lobbyBypassSettings = optional(any)       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       presenters = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventPresenter")       email = optional(string)       identity = optional(any)       presenterDetails = optional(any)       sessions = optional(any)     })))       recordAutomatically = optional(bool)       registrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistration")       cancelationDateTime = optional(string)       email = optional(string)       externalRegistrationInformation = optional(any)       firstName = optional(string)       lastName = optional(string)       preferredLanguage = optional(string)       preferredTimezone = optional(string)       registrantVideoOnDemandWebUrl = optional(string)       registrationDateTime = optional(string)       registrationQuestionAnswers = optional(any)       sessions = optional(any)       userId = optional(string)     })))       sensitivityLabelAssignment = optional(any)       shareMeetingChatHistoryDefault = optional(any)       startDateTime = optional(any)       subject = optional(string)       videoOnDemandWebUrl = optional(string)       watermarkProtection = optional(any)     }))` | no | no |
| `settings` | `settings` | `any` | no | no |
| `start_date_time` | `startDateTime` | `any` | no | no |
| `status` | `status` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- audience: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- description: polymorphic schema; accepts an untyped value
- endDateTime: polymorphic schema; accepts an untyped value
- presenters[].identity: polymorphic schema; accepts an untyped value
- presenters[].presenterDetails: polymorphic schema; accepts an untyped value
- presenters[].sessions[].allowLiveShare: polymorphic schema; accepts an untyped value
- presenters[].sessions[].allowMeetingChat: polymorphic schema; accepts an untyped value
- presenters[].sessions[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- presenters[].sessions[].allowedPresenters: polymorphic schema; accepts an untyped value
- presenters[].sessions[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- presenters[].sessions[].chatInfo: polymorphic schema; accepts an untyped value
- presenters[].sessions[].chatRestrictions: polymorphic schema; accepts an untyped value
- presenters[].sessions[].endDateTime: polymorphic schema; accepts an untyped value
- presenters[].sessions[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- presenters[].sessions[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- presenters[].sessions[].presenters[]: recursive schema; accepts an untyped value
- presenters[].sessions[].registrations[]: nested schema exceeds depth limit; accepts an untyped value
- presenters[].sessions[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- presenters[].sessions[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- presenters[].sessions[].startDateTime: polymorphic schema; accepts an untyped value
- presenters[].sessions[].watermarkProtection: polymorphic schema; accepts an untyped value
- registrationConfiguration: polymorphic schema; accepts an untyped value
- registrations[].externalRegistrationInformation: polymorphic schema; accepts an untyped value
- registrations[].sessions[].allowLiveShare: polymorphic schema; accepts an untyped value
- registrations[].sessions[].allowMeetingChat: polymorphic schema; accepts an untyped value
- registrations[].sessions[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- registrations[].sessions[].allowedPresenters: polymorphic schema; accepts an untyped value
- registrations[].sessions[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- registrations[].sessions[].chatInfo: polymorphic schema; accepts an untyped value
- registrations[].sessions[].chatRestrictions: polymorphic schema; accepts an untyped value
- registrations[].sessions[].endDateTime: polymorphic schema; accepts an untyped value
- registrations[].sessions[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- registrations[].sessions[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- registrations[].sessions[].presenters[]: nested schema exceeds depth limit; accepts an untyped value
- registrations[].sessions[].registrations[]: recursive schema; accepts an untyped value
- registrations[].sessions[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- registrations[].sessions[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- registrations[].sessions[].startDateTime: polymorphic schema; accepts an untyped value
- registrations[].sessions[].watermarkProtection: polymorphic schema; accepts an untyped value
- sessions[].allowLiveShare: polymorphic schema; accepts an untyped value
- sessions[].allowMeetingChat: polymorphic schema; accepts an untyped value
- sessions[].allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- sessions[].allowedPresenters: polymorphic schema; accepts an untyped value
- sessions[].anonymizeIdentityForRoles[]: polymorphic schema; accepts an untyped value
- sessions[].chatInfo: polymorphic schema; accepts an untyped value
- sessions[].chatRestrictions: polymorphic schema; accepts an untyped value
- sessions[].endDateTime: polymorphic schema; accepts an untyped value
- sessions[].joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- sessions[].lobbyBypassSettings: polymorphic schema; accepts an untyped value
- sessions[].presenters[].identity: polymorphic schema; accepts an untyped value
- sessions[].presenters[].presenterDetails: polymorphic schema; accepts an untyped value
- sessions[].presenters[].sessions[]: recursive schema; accepts an untyped value
- sessions[].registrations[].externalRegistrationInformation: polymorphic schema; accepts an untyped value
- sessions[].registrations[].registrationQuestionAnswers[]: nested schema exceeds depth limit; accepts an untyped value
- sessions[].registrations[].sessions[]: recursive schema; accepts an untyped value
- sessions[].sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- sessions[].shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- sessions[].startDateTime: polymorphic schema; accepts an untyped value
- sessions[].watermarkProtection: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value
- startDateTime: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
