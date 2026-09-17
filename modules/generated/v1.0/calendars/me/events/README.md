# /me/events

Create multi-value extended property

[Catalog](../../../README.md) · [Calendars](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /me/events`, `GET/PATCH/DELETE /me/events/{event-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./calendars/me/events"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allow_new_time_proposals` | `allowNewTimeProposals` | `bool` | no | no |
| `attendees` | `attendees` | `list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(any)       type = optional(any)     }))` | no | no |
| `body` | `body` | `any` | no | no |
| `body_preview` | `bodyPreview` | `string` | no | no |
| `cancelled_occurrences` | `cancelledOccurrences` | `list(string)` | no | no |
| `categories` | `categories` | `list(string)` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `end` | `end` | `any` | no | no |
| `exception_occurrences` | `exceptionOccurrences` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(any)       proposedNewTime = optional(any)       status = optional(any)       type = optional(any)     })))       body = optional(any)       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(any)       exceptionOccurrences = optional(any)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(any)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.location")       address = optional(any)       coordinates = optional(any)       displayName = optional(string)       locationEmailAddress = optional(string)       locationUri = optional(string)       uniqueId = optional(string)       uniqueIdType = optional(any)     })))       onlineMeetingProvider = optional(any)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(any)       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(any)       sensitivity = optional(any)       seriesMasterId = optional(string)       showAs = optional(any)       start = optional(any)       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     }))` | no | no |
| `extensions` | `extensions` | `list(object({       odata_type = optional(string, "#microsoft.graph.extension")     }))` | no | no |
| `has_attachments` | `hasAttachments` | `bool` | no | no |
| `hide_attendees` | `hideAttendees` | `bool` | no | no |
| `importance` | `importance` | `any` | no | no |
| `is_all_day` | `isAllDay` | `bool` | no | no |
| `is_cancelled` | `isCancelled` | `bool` | no | no |
| `is_draft` | `isDraft` | `bool` | no | no |
| `is_online_meeting` | `isOnlineMeeting` | `bool` | no | no |
| `is_organizer` | `isOrganizer` | `bool` | no | no |
| `is_reminder_on` | `isReminderOn` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `location` | `location` | `any` | no | no |
| `locations` | `locations` | `list(object({       odata_type = optional(string, "#microsoft.graph.location")       address = optional(any)       coordinates = optional(any)       displayName = optional(string)       locationEmailAddress = optional(string)       locationUri = optional(string)       uniqueId = optional(string)       uniqueIdType = optional(any)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `online_meeting_provider` | `onlineMeetingProvider` | `any` | no | no |
| `organizer` | `organizer` | `any` | no | no |
| `original_end_time_zone` | `originalEndTimeZone` | `string` | no | no |
| `original_start` | `originalStart` | `string` | no | no |
| `original_start_time_zone` | `originalStartTimeZone` | `string` | no | no |
| `recurrence` | `recurrence` | `any` | no | no |
| `reminder_minutes_before_start` | `reminderMinutesBeforeStart` | `number` | no | no |
| `response_requested` | `responseRequested` | `bool` | no | no |
| `response_status` | `responseStatus` | `any` | no | no |
| `sensitivity` | `sensitivity` | `any` | no | no |
| `series_master_id` | `seriesMasterId` | `string` | no | no |
| `show_as` | `showAs` | `any` | no | no |
| `start` | `start` | `any` | no | no |
| `subject` | `subject` | `string` | no | no |
| `transaction_id` | `transactionId` | `string` | no | no |
| `web_link` | `webLink` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- attendees[].emailAddress: polymorphic schema; accepts an untyped value
- attendees[].proposedNewTime: polymorphic schema; accepts an untyped value
- attendees[].status: polymorphic schema; accepts an untyped value
- attendees[].type: polymorphic schema; accepts an untyped value
- body: polymorphic schema; accepts an untyped value
- end: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].attendees[].emailAddress: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].attendees[].proposedNewTime: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].attendees[].status: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].attendees[].type: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].body: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].end: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- exceptionOccurrences[].importance: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].location: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].locations[].address: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].locations[].coordinates: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].locations[].uniqueIdType: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].onlineMeetingProvider: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].organizer: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].recurrence: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].responseStatus: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].sensitivity: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].showAs: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].start: polymorphic schema; accepts an untyped value
- importance: polymorphic schema; accepts an untyped value
- location: polymorphic schema; accepts an untyped value
- locations[].address: polymorphic schema; accepts an untyped value
- locations[].coordinates: polymorphic schema; accepts an untyped value
- locations[].uniqueIdType: polymorphic schema; accepts an untyped value
- onlineMeetingProvider: polymorphic schema; accepts an untyped value
- organizer: polymorphic schema; accepts an untyped value
- recurrence: polymorphic schema; accepts an untyped value
- responseStatus: polymorphic schema; accepts an untyped value
- sensitivity: polymorphic schema; accepts an untyped value
- showAs: polymorphic schema; accepts an untyped value
- start: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
