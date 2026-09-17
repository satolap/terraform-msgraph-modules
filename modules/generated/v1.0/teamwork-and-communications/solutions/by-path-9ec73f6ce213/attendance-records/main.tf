# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "attendanceIntervals"             = (var.attendance_intervals == null ? null : [for item0 in var.attendance_intervals : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "durationInSeconds" = item0["durationInSeconds"], "joinDateTime" = item0["joinDateTime"], "leaveDateTime" = item0["leaveDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "emailAddress"                    = var.email_address
    "externalRegistrationInformation" = var.external_registration_information
    "identity"                        = var.identity
    "@odata.type"                     = var.odata_type
    "registrationId"                  = var.registration_id
    "role"                            = var.role
    "totalAttendanceInSeconds"        = var.total_attendance_in_seconds
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/virtualEvents/events/${urlencode(var.virtual_event_id)}/sessions/${urlencode(var.virtual_event_session_id)}/attendanceReports/${urlencode(var.meeting_attendance_report_id)}/attendanceRecords"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
