# /solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrations

Create virtualEventRegistration

[Catalog](../../../../../../README.md) · [Teamwork and communications](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventregistration?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrations`, `GET/PATCH/DELETE /solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrations/{virtualEventRegistration-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/solutions/virtual-events/webinars/by-virtual-event-webinar-id/registrations"
  virtual_event_webinar_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `virtual_event_webinar_id` | URL parameter `virtualEventWebinar-id` | `string` | yes | no |
| `cancelation_date_time` | `cancelationDateTime` | `string` | no | no |
| `email` | `email` | `string` | no | no |
| `external_registration_information` | `externalRegistrationInformation` | `object({       odata_type = optional(string, "#microsoft.graph.virtualEventExternalRegistrationInformation")       referrer = optional(string)       registrationId = optional(string)     })` | no | no |
| `first_name` | `firstName` | `string` | no | no |
| `last_name` | `lastName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `preferred_language` | `preferredLanguage` | `string` | no | no |
| `preferred_timezone` | `preferredTimezone` | `string` | no | no |
| `registrant_video_on_demand_web_url` | `registrantVideoOnDemandWebUrl` | `string` | no | no |
| `registration_date_time` | `registrationDateTime` | `string` | no | no |
| `registration_question_answers` | `registrationQuestionAnswers` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistrationQuestionAnswer")       booleanValue = optional(bool)       displayName = optional(string)       multiChoiceValues = optional(list(string))       questionId = optional(string)       value = optional(string)     }))` | no | no |
| `sessions` | `sessions` | `list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventSession")       allowAttendeeToEnableCamera = optional(bool)       allowAttendeeToEnableMic = optional(bool)       allowBreakoutRooms = optional(bool)       allowCopyingAndSharingMeetingContent = optional(bool)       allowLiveShare = optional(string)       allowMeetingChat = optional(string)       allowParticipantsToChangeName = optional(bool)       allowPowerPointSharing = optional(bool)       allowRecording = optional(bool)       allowTeamworkReactions = optional(bool)       allowTranscription = optional(bool)       allowWhiteboard = optional(bool)       allowedLobbyAdmitters = optional(string)       allowedPresenters = optional(string)       anonymizeIdentityForRoles = optional(list(string))       capacity = optional(number)       chatInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     }))       chatRestrictions = optional(object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     }))       endDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       expiryDateTime = optional(string)       isEndToEndEncryptionEnabled = optional(bool)       isEntryExitAnnounced = optional(bool)       joinMeetingIdSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     }))       lobbyBypassSettings = optional(object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     }))       meetingOptionsWebUrl = optional(string)       meetingSpokenLanguageTag = optional(string)       presenters = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventPresenter")       email = optional(string)       identity = optional(any)       presenterDetails = optional(object({       odata_type = optional(string, "#microsoft.graph.virtualEventPresenterDetails")       bio = optional(any)       company = optional(string)       jobTitle = optional(string)       linkedInProfileWebUrl = optional(string)       personalSiteWebUrl = optional(string)       photo = optional(string)       twitterProfileWebUrl = optional(string)     }))       sessions = optional(any)     })))       recordAutomatically = optional(bool)       registrations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.virtualEventRegistration")       cancelationDateTime = optional(string)       email = optional(string)       externalRegistrationInformation = optional(object({       odata_type = optional(string, "#microsoft.graph.virtualEventExternalRegistrationInformation")       referrer = optional(string)       registrationId = optional(string)     }))       firstName = optional(string)       lastName = optional(string)       preferredLanguage = optional(string)       preferredTimezone = optional(string)       registrantVideoOnDemandWebUrl = optional(string)       registrationDateTime = optional(string)       registrationQuestionAnswers = optional(any)       sessions = optional(any)       userId = optional(string)     })))       sensitivityLabelAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     }))       shareMeetingChatHistoryDefault = optional(string)       startDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       videoOnDemandWebUrl = optional(string)       watermarkProtection = optional(object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     }))     }))` | no | no |
| `user_id` | `userId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- sessions[].presenters[].identity: polymorphic schema; accepts an untyped value
- sessions[].presenters[].presenterDetails.bio: nested schema exceeds depth limit; accepts an untyped value
- sessions[].presenters[].sessions[]: recursive schema; accepts an untyped value
- sessions[].registrations[].registrationQuestionAnswers[]: nested schema exceeds depth limit; accepts an untyped value
- sessions[].registrations[].sessions[]: recursive schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
