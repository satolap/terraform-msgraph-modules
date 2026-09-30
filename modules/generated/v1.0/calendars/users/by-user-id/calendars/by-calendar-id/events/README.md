# /users/{user-id}/calendars/{calendar-id}/events

Create new navigation property to events for users

[Catalog](../../../../../../README.md) · [Calendars](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/calendars/{calendar-id}/events`, `GET/PATCH/DELETE /users/{user-id}/calendars/{calendar-id}/events/{event-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/calendars/users/by-user-id/calendars/by-calendar-id/events?ref=<release-tag>"
  user_id = "parent-object-id"
  calendar_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `calendar_id` | URL parameter `calendar-id` | `string` | yes | no |
| `allow_new_time_proposals` | `allowNewTimeProposals` | `bool` | no | no |
| `attendees` | `attendees` | `list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))       proposedNewTime = optional(object({       odata_type = optional(string, "#microsoft.graph.timeSlot")       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     }))` | no | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no |
| `body_preview` | `bodyPreview` | `string` | no | no |
| `cancelled_occurrences` | `cancelledOccurrences` | `list(string)` | no | no |
| `categories` | `categories` | `list(string)` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `end` | `end` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
| `exception_occurrences` | `exceptionOccurrences` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))       proposedNewTime = optional(object({       odata_type = optional(string, "#microsoft.graph.timeSlot")       end = optional(any)       start = optional(any)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     }))` | no | no |
| `extensions` | `extensions` | `any` | no | no |
| `has_attachments` | `hasAttachments` | `bool` | no | no |
| `hide_attendees` | `hideAttendees` | `bool` | no | no |
| `importance` | `importance` | `string` | no | no |
| `is_all_day` | `isAllDay` | `bool` | no | no |
| `is_cancelled` | `isCancelled` | `bool` | no | no |
| `is_draft` | `isDraft` | `bool` | no | no |
| `is_online_meeting` | `isOnlineMeeting` | `bool` | no | no |
| `is_organizer` | `isOrganizer` | `bool` | no | no |
| `is_reminder_on` | `isReminderOn` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `location` | `location` | `any` | no | no |
| `locations` | `locations` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `online_meeting_provider` | `onlineMeetingProvider` | `string` | no | no |
| `organizer` | `organizer` | `any` | no | no |
| `original_end_time_zone` | `originalEndTimeZone` | `string` | no | no |
| `original_start` | `originalStart` | `string` | no | no |
| `original_start_time_zone` | `originalStartTimeZone` | `string` | no | no |
| `recurrence` | `recurrence` | `object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     })` | no | no |
| `reminder_minutes_before_start` | `reminderMinutesBeforeStart` | `number` | no | no |
| `response_requested` | `responseRequested` | `bool` | no | no |
| `response_status` | `responseStatus` | `object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     })` | no | no |
| `sensitivity` | `sensitivity` | `string` | no | no |
| `series_master_id` | `seriesMasterId` | `string` | no | no |
| `show_as` | `showAs` | `string` | no | no |
| `start` | `start` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no |
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

- exceptionOccurrences[].attendees[].proposedNewTime.end: nested schema exceeds depth limit; accepts an untyped value
- exceptionOccurrences[].attendees[].proposedNewTime.start: nested schema exceeds depth limit; accepts an untyped value
- exceptionOccurrences[].exceptionOccurrences[]: recursive schema; accepts an untyped value
- exceptionOccurrences[].extensions[]: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].location: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].locations[]: polymorphic schema; accepts an untyped value
- exceptionOccurrences[].organizer: polymorphic schema; accepts an untyped value
- extensions[]: polymorphic schema; accepts an untyped value
- location: polymorphic schema; accepts an untyped value
- locations[]: polymorphic schema; accepts an untyped value
- organizer: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
