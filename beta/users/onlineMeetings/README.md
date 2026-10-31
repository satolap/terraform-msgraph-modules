# /users/{user-id}/onlineMeetings

Create new navigation property to onlineMeetings for users

[Catalog](../../README.md) Â· [Teamwork and communications](../../README.md#teamwork-and-communications) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/onlineMeetings`, `GET/PATCH/DELETE /users/{user-id}/onlineMeetings/{onlineMeeting-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/users/onlineMeetings"
  version = "<version>"

  user-id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `user-id` | URL parameter `user-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `allowAttendeeToEnableCamera` | `allowAttendeeToEnableCamera` | `bool` | no | no | in place |
| `allowAttendeeToEnableMic` | `allowAttendeeToEnableMic` | `bool` | no | no | in place |
| `allowBreakoutRooms` | `allowBreakoutRooms` | `bool` | no | no | in place |
| `allowCopyingAndSharingMeetingContent` | `allowCopyingAndSharingMeetingContent` | `bool` | no | no | in place |
| `allowLiveShare` | `allowLiveShare` | `string` | no | no | in place |
| `allowMeetingChat` | `allowMeetingChat` | `string` | no | no | in place |
| `allowParticipantsToChangeName` | `allowParticipantsToChangeName` | `bool` | no | no | in place |
| `allowPowerPointSharing` | `allowPowerPointSharing` | `bool` | no | no | in place |
| `allowRecording` | `allowRecording` | `bool` | no | no | in place |
| `allowTeamworkReactions` | `allowTeamworkReactions` | `bool` | no | no | in place |
| `allowTranscription` | `allowTranscription` | `bool` | no | no | in place |
| `allowWhiteboard` | `allowWhiteboard` | `bool` | no | no | in place |
| `allowedLobbyAdmitters` | `allowedLobbyAdmitters` | `string` | no | no | in place |
| `allowedPresenters` | `allowedPresenters` | `string` | no | no | in place |
| `anonymizeIdentityForRoles` | `anonymizeIdentityForRoles` | `list(string)` | no | no | in place |
| `broadcastRecording` | `broadcastRecording` | `string` | no | no | in place |
| `broadcastSettings` | `broadcastSettings` | `object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingSettings")       allowedAudience = optional(string)       captions = optional(object({       odata_type = optional(string, "#microsoft.graph.broadcastMeetingCaptionSettings")       isCaptionEnabled = optional(bool)       spokenLanguage = optional(string)       translationLanguages = optional(list(string))     }))       isAttendeeReportEnabled = optional(bool)       isQuestionAndAnswerEnabled = optional(bool)       isRecordingEnabled = optional(bool)       isVideoOnDemandEnabled = optional(bool)     })` | no | no | in place |
| `capabilities` | `capabilities` | `list(string)` | no | no | in place |
| `chatInfo` | `chatInfo` | `object({       odata_type = optional(string, "#microsoft.graph.chatInfo")       messageId = optional(string)       replyChainMessageId = optional(string)       threadId = optional(string)     })` | no | no | in place |
| `chatRestrictions` | `chatRestrictions` | `object({       odata_type = optional(string, "#microsoft.graph.chatRestrictions")       allowTextOnly = optional(bool)     })` | no | no | in place |
| `endDateTime` | `endDateTime` | `string` | no | no | in place |
| `expiryDateTime` | `expiryDateTime` | `string` | no | no | in place |
| `externalId` | `externalId` | `string` | no | no | in place |
| `isBroadcast` | `isBroadcast` | `bool` | no | no | in place |
| `isEndToEndEncryptionEnabled` | `isEndToEndEncryptionEnabled` | `bool` | no | no | in place |
| `isEntryExitAnnounced` | `isEntryExitAnnounced` | `bool` | no | no | in place |
| `joinMeetingIdSettings` | `joinMeetingIdSettings` | `object({       odata_type = optional(string, "#microsoft.graph.joinMeetingIdSettings")       isPasscodeRequired = optional(bool)     })` | no | no | in place |
| `joinUrl` | `joinUrl` | `string` | no | no | in place |
| `lobbyBypassSettings` | `lobbyBypassSettings` | `object({       odata_type = optional(string, "#microsoft.graph.lobbyBypassSettings")       isDialInBypassEnabled = optional(bool)       scope = optional(string)     })` | no | no | in place |
| `meetingOptionsWebUrl` | `meetingOptionsWebUrl` | `string` | no | no | in place |
| `meetingSpokenLanguageTag` | `meetingSpokenLanguageTag` | `string` | no | no | in place |
| `meetingTemplateId` | `meetingTemplateId` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `participants` | `participants` | `object({       odata_type = optional(string, "#microsoft.graph.meetingParticipants")       attendees = optional(any)       contributors = optional(any)       organizer = optional(any)       producers = optional(any)     })` | no | no | in place |
| `recordAutomatically` | `recordAutomatically` | `bool` | no | no | in place |
| `registration` | `registration` | `any` | no | no | in place |
| `sensitivityLabelAssignment` | `sensitivityLabelAssignment` | `object({       odata_type = optional(string, "#microsoft.graph.onlineMeetingSensitivityLabelAssignment")       sensitivityLabelId = optional(string)     })` | no | no | in place |
| `shareMeetingChatHistoryDefault` | `shareMeetingChatHistoryDefault` | `string` | no | no | in place |
| `startDateTime` | `startDateTime` | `string` | no | no | in place |
| `subject` | `subject` | `string` | no | no | in place |
| `watermarkProtection` | `watermarkProtection` | `object({       odata_type = optional(string, "#microsoft.graph.watermarkProtectionValues")       isEnabledForContentSharing = optional(bool)       isEnabledForVideo = optional(bool)     })` | no | no | in place |
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

Server-assigned properties in `response`: `aiInsights`, `alternativeRecording`, `attendanceReports`, `attendeeReport`, `audioConferencing`, `cloudVideoInteropInfo`, `creationDateTime`, `id`, `joinInformation`, `joinWebUrl`, `meetingAttendanceReport`, `meetingType`, `recording`, `recordings`, `transcripts`, `videoTeleconferenceId`.

Unique server-assigned values: `joinWebUrl` within `/users/{user-id}/onlineMeetings`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /users/{user-id}/onlineMeetings` | DelegatedWork | `OnlineMeetings.ReadWrite` | — |
| `POST /users/{user-id}/onlineMeetings` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /users/{user-id}/onlineMeetings` | Application | `OnlineMeetings.ReadWrite.All` | — |
| `GET /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedWork | `OnlineMeetings.Read` | — |
| `GET /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedWork | `OnlineMeetings.ReadWrite` | — |
| `GET /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | Application | `OnlineMeetings.Read.All` | — |
| `GET /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | Application | `OnlineMeetings.ReadWrite.All` | — |
| `PATCH /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedWork | `OnlineMeetings.ReadWrite` | — |
| `PATCH /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | Application | `OnlineMeetings.ReadWrite.All` | — |
| `DELETE /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedWork | `OnlineMeetings.ReadWrite` | — |
| `DELETE /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /users/{user-id}/onlineMeetings/{onlineMeeting-id}` | Application | `OnlineMeetings.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- anonymizeIdentityForRoles[]: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: coorganizer; excluded from typed input validation
- lobbyBypassSettings.scope: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: invited, organizationExcludingGuests; excluded from typed input validation
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
