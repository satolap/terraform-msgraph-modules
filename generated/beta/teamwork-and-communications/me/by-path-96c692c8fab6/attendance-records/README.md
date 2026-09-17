# /me/onlineMeetings/{onlineMeeting-id}/attendanceReports/{meetingAttendanceReport-id}/attendanceRecords

Create new navigation property to attendanceRecords for me

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/attendancerecord?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /me/onlineMeetings/{onlineMeeting-id}/attendanceReports/{meetingAttendanceReport-id}/attendanceRecords`, `GET/PATCH/DELETE /me/onlineMeetings/{onlineMeeting-id}/attendanceReports/{meetingAttendanceReport-id}/attendanceRecords/{attendanceRecord-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/me/by-path-96c692c8fab6/attendance-records"
  online_meeting_id = "parent-object-id"
  meeting_attendance_report_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `online_meeting_id` | URL parameter `onlineMeeting-id` | `string` | yes | no |
| `meeting_attendance_report_id` | URL parameter `meetingAttendanceReport-id` | `string` | yes | no |
| `attendance_intervals` | `attendanceIntervals` | `list(object({       odata_type = optional(string, "#microsoft.graph.attendanceInterval")       durationInSeconds = optional(number)       joinDateTime = optional(string)       leaveDateTime = optional(string)     }))` | no | no |
| `email_address` | `emailAddress` | `string` | no | no |
| `engagements` | `engagements` | `list(object({       odata_type = optional(string, "#microsoft.graph.meetingEngagement")       dateTime = optional(string)       engagementSubType = optional(string)       engagementType = optional(any)     }))` | no | no |
| `external_registration_information` | `externalRegistrationInformation` | `any` | no | no |
| `identity` | `identity` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `registrant_id` | `registrantId` | `string` | no | no |
| `registration_id` | `registrationId` | `string` | no | no |
| `role` | `role` | `string` | no | no |
| `total_attendance_in_seconds` | `totalAttendanceInSeconds` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- engagements[].engagementType: polymorphic schema; accepts an untyped value
- externalRegistrationInformation: polymorphic schema; accepts an untyped value
- identity: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
