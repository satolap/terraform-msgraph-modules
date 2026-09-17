# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/bookingBusinesses/test-parent-id/staffMembers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["availabilityIsAffectedByPersonalCalendar", "colorIndex", "createdDateTime", "displayName", "emailAddress", "isEmailNotificationEnabled", "lastUpdatedDateTime", "membershipStatus", "role", "timeZone", "useBusinessHours", "workingHours"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    booking_business_id                           = "test-parent-id"
    created_date_time                             = "2026-01-01T00:00:00Z"
    availability_is_affected_by_personal_calendar = false
    color_index                                   = -2147483648
    working_hours                                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["availabilityIsAffectedByPersonalCalendar"]) == jsonencode(false)
    error_message = "availabilityIsAffectedByPersonalCalendar must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["colorIndex"]) == jsonencode(-2147483648)
    error_message = "colorIndex must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["workingHours"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.bookingWorkHours" }])
    error_message = "workingHours must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
    membership_status   = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.membership_status]
}
