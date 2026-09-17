# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    virtual_event_webinar_id     = "test-parent-id"
    virtual_event_session_id     = "test-parent-id"
    meeting_attendance_report_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/virtualEvents/webinars/test-parent-id/sessions/test-parent-id/attendanceReports/test-parent-id/attendanceRecords"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attendanceIntervals", "emailAddress", "externalRegistrationInformation", "identity", "registrationId", "role", "totalAttendanceInSeconds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    virtual_event_webinar_id     = "test-parent-id"
    virtual_event_session_id     = "test-parent-id"
    meeting_attendance_report_id = "test-parent-id"
    email_address                = "example"
    total_attendance_in_seconds  = -2147483648
    attendance_intervals         = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["emailAddress"]) == jsonencode("example")
    error_message = "emailAddress must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["totalAttendanceInSeconds"]) == jsonencode(-2147483648)
    error_message = "totalAttendanceInSeconds must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attendanceIntervals"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.attendanceInterval" }])
    error_message = "attendanceIntervals must preserve typed values and omit nested nulls."
  }
}
