# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/bookingBusinesses/test-parent-id/services"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalInformation", "createdDateTime", "customQuestions", "defaultDuration", "defaultLocation", "defaultPrice", "defaultPriceType", "defaultReminders", "description", "displayName", "isAnonymousJoinEnabled", "isCustomerAllowedToManageBooking", "isHiddenFromCustomers", "isLocationOnline", "languageTag", "lastUpdatedDateTime", "maximumAttendeesCount", "notes", "postBuffer", "preBuffer", "schedulingPolicy", "smsNotificationsEnabled", "staffMemberIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    booking_business_id       = "test-parent-id"
    additional_information    = "example"
    is_anonymous_join_enabled = false
    maximum_attendees_count   = -2147483648
    custom_questions          = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInformation"]) == jsonencode("example")
    error_message = "additionalInformation must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAnonymousJoinEnabled"]) == jsonencode(false)
    error_message = "isAnonymousJoinEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["maximumAttendeesCount"]) == jsonencode(-2147483648)
    error_message = "maximumAttendeesCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customQuestions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.bookingQuestionAssignment" }])
    error_message = "customQuestions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
    default_price_type  = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.default_price_type]
}
