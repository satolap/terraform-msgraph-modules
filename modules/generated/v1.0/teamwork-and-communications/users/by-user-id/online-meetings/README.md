# /users/{user-id}/onlineMeetings

Create new navigation property to onlineMeetings for users

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/onlineMeetings`, `GET/PATCH/DELETE /users/{user-id}/onlineMeetings/{onlineMeeting-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/users/by-user-id/online-meetings"
  user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `allow_attendee_to_enable_camera` | `allowAttendeeToEnableCamera` | `bool` | no | no |
| `allow_attendee_to_enable_mic` | `allowAttendeeToEnableMic` | `bool` | no | no |
| `allow_breakout_rooms` | `allowBreakoutRooms` | `bool` | no | no |
| `allow_copying_and_sharing_meeting_content` | `allowCopyingAndSharingMeetingContent` | `bool` | no | no |
| `allow_live_share` | `allowLiveShare` | `any` | no | no |
| `allow_meeting_chat` | `allowMeetingChat` | `any` | no | no |
| `allow_participants_to_change_name` | `allowParticipantsToChangeName` | `bool` | no | no |
| `allow_power_point_sharing` | `allowPowerPointSharing` | `bool` | no | no |
| `allow_recording` | `allowRecording` | `bool` | no | no |
| `allow_teamwork_reactions` | `allowTeamworkReactions` | `bool` | no | no |
| `allow_transcription` | `allowTranscription` | `bool` | no | no |
| `allow_whiteboard` | `allowWhiteboard` | `bool` | no | no |
| `allowed_lobby_admitters` | `allowedLobbyAdmitters` | `any` | no | no |
| `allowed_presenters` | `allowedPresenters` | `any` | no | no |
| `broadcast_settings` | `broadcastSettings` | `any` | no | no |
| `chat_info` | `chatInfo` | `any` | no | no |
| `chat_restrictions` | `chatRestrictions` | `any` | no | no |
| `end_date_time` | `endDateTime` | `string` | no | no |
| `expiry_date_time` | `expiryDateTime` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `is_broadcast` | `isBroadcast` | `bool` | no | no |
| `is_end_to_end_encryption_enabled` | `isEndToEndEncryptionEnabled` | `bool` | no | no |
| `is_entry_exit_announced` | `isEntryExitAnnounced` | `bool` | no | no |
| `join_meeting_id_settings` | `joinMeetingIdSettings` | `any` | no | no |
| `lobby_bypass_settings` | `lobbyBypassSettings` | `any` | no | no |
| `meeting_options_web_url` | `meetingOptionsWebUrl` | `string` | no | no |
| `meeting_spoken_language_tag` | `meetingSpokenLanguageTag` | `string` | no | no |
| `meeting_template_id` | `meetingTemplateId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `participants` | `participants` | `any` | no | no |
| `record_automatically` | `recordAutomatically` | `bool` | no | no |
| `sensitivity_label_assignment` | `sensitivityLabelAssignment` | `any` | no | no |
| `share_meeting_chat_history_default` | `shareMeetingChatHistoryDefault` | `any` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `subject` | `subject` | `string` | no | no |
| `watermark_protection` | `watermarkProtection` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- allowLiveShare: polymorphic schema; accepts an untyped value
- allowMeetingChat: polymorphic schema; accepts an untyped value
- allowedLobbyAdmitters: polymorphic schema; accepts an untyped value
- allowedPresenters: polymorphic schema; accepts an untyped value
- broadcastSettings: polymorphic schema; accepts an untyped value
- chatInfo: polymorphic schema; accepts an untyped value
- chatRestrictions: polymorphic schema; accepts an untyped value
- joinMeetingIdSettings: polymorphic schema; accepts an untyped value
- lobbyBypassSettings: polymorphic schema; accepts an untyped value
- participants: polymorphic schema; accepts an untyped value
- sensitivityLabelAssignment: polymorphic schema; accepts an untyped value
- shareMeetingChatHistoryDefault: polymorphic schema; accepts an untyped value
- watermarkProtection: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
