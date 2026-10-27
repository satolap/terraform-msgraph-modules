# /users/{user-id}/calendars/{calendar-id}/events

Create new navigation property to events for users

[Catalog](../../../README.md) Â· [Calendars](../../../README.md#calendars) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/calendars/{calendar-id}/events`, `GET/PATCH/DELETE /users/{user-id}/calendars/{calendar-id}/events/{event-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/users/calendars/events"
  version = "<version>"

  user_id = "parent-object-id"
  calendar_id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `cancelledOccurrences`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `calendar_id` | URL parameter `calendar-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `allow_new_time_proposals` | `allowNewTimeProposals` | `bool` | no | no | in place |
| `attendees` | `attendees` | `list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))       proposedNewTime = optional(object({       odata_type = optional(string, "#microsoft.graph.timeSlot")       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     }))` | no | no | in place |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no | in place |
| `body_preview` | `bodyPreview` | `string` | no | no | in place |
| `cancelled_occurrences` | `cancelledOccurrences` | `list(string)` | no | no | in place |
| `categories` | `categories` | `list(string)` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `end` | `end` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no | in place |
| `exception_occurrences` | `exceptionOccurrences` | `list(object({       odata_type = optional(string, "#microsoft.graph.event")       allowNewTimeProposals = optional(bool)       attendees = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attendee")       emailAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))       proposedNewTime = optional(object({       odata_type = optional(string, "#microsoft.graph.timeSlot")       end = optional(any)       start = optional(any)     }))       status = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       type = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     }))       bodyPreview = optional(string)       cancelledOccurrences = optional(list(string))       categories = optional(list(string))       createdDateTime = optional(string)       end = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       exceptionOccurrences = optional(any)       extensions = optional(any)       hasAttachments = optional(bool)       hideAttendees = optional(bool)       importance = optional(string)       isAllDay = optional(bool)       isCancelled = optional(bool)       isDraft = optional(bool)       isOnlineMeeting = optional(bool)       isOrganizer = optional(bool)       isReminderOn = optional(bool)       lastModifiedDateTime = optional(string)       location = optional(any)       locations = optional(any)       onlineMeetingProvider = optional(string)       organizer = optional(any)       originalEndTimeZone = optional(string)       originalStart = optional(string)       originalStartTimeZone = optional(string)       recurrence = optional(object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     }))       reminderMinutesBeforeStart = optional(number)       responseRequested = optional(bool)       responseStatus = optional(object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     }))       sensitivity = optional(string)       seriesMasterId = optional(string)       showAs = optional(string)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       subject = optional(string)       transactionId = optional(string)       webLink = optional(string)     }))` | no | no | in place |
| `extensions` | `extensions` | `any` | no | no | in place |
| `has_attachments` | `hasAttachments` | `bool` | no | no | in place |
| `hide_attendees` | `hideAttendees` | `bool` | no | no | in place |
| `importance` | `importance` | `string` | no | no | in place |
| `is_all_day` | `isAllDay` | `bool` | no | no | in place |
| `is_cancelled` | `isCancelled` | `bool` | no | no | in place |
| `is_draft` | `isDraft` | `bool` | no | no | in place |
| `is_online_meeting` | `isOnlineMeeting` | `bool` | no | no | in place |
| `is_organizer` | `isOrganizer` | `bool` | no | no | in place |
| `is_reminder_on` | `isReminderOn` | `bool` | no | no | in place |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no | in place |
| `location` | `location` | `any` | no | no | in place |
| `locations` | `locations` | `any` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `online_meeting_provider` | `onlineMeetingProvider` | `string` | no | no | in place |
| `organizer` | `organizer` | `any` | no | no | in place |
| `original_end_time_zone` | `originalEndTimeZone` | `string` | no | no | in place |
| `original_start` | `originalStart` | `string` | no | no | in place |
| `original_start_time_zone` | `originalStartTimeZone` | `string` | no | no | in place |
| `recurrence` | `recurrence` | `object({       odata_type = optional(string, "#microsoft.graph.patternedRecurrence")       pattern = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrencePattern")       dayOfMonth = optional(number)       daysOfWeek = optional(list(string))       firstDayOfWeek = optional(string)       index = optional(string)       interval = optional(number)       month = optional(number)       type = optional(string)     }))       range = optional(object({       odata_type = optional(string, "#microsoft.graph.recurrenceRange")       endDate = optional(string)       numberOfOccurrences = optional(number)       recurrenceTimeZone = optional(string)       startDate = optional(string)       type = optional(string)     }))     })` | no | no | in place |
| `reminder_minutes_before_start` | `reminderMinutesBeforeStart` | `number` | no | no | in place |
| `response_requested` | `responseRequested` | `bool` | no | no | in place |
| `response_status` | `responseStatus` | `object({       odata_type = optional(string, "#microsoft.graph.responseStatus")       response = optional(string)       time = optional(string)     })` | no | no | in place |
| `sensitivity` | `sensitivity` | `string` | no | no | in place |
| `series_master_id` | `seriesMasterId` | `string` | no | no | in place |
| `show_as` | `showAs` | `string` | no | no | in place |
| `start` | `start` | `object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     })` | no | no | in place |
| `subject` | `subject` | `string` | no | no | in place |
| `transaction_id` | `transactionId` | `string` | no | no | in place |
| `web_link` | `webLink` | `string` | no | no | in place |
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

Server-assigned properties in `response`: `attachments`, `calendar`, `changeKey`, `iCalUId`, `id`, `instances`, `multiValueExtendedProperties`, `onlineMeeting`, `onlineMeetingUrl`, `singleValueExtendedProperties`, `type`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

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
