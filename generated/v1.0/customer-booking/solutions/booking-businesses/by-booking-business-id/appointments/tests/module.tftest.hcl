# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "solutions/bookingBusinesses/test-parent-id/appointments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalInformation", "anonymousJoinWebUrl", "appointmentLabel", "createdDateTime", "customerEmailAddress", "customerName", "customerNotes", "customerPhone", "customerTimeZone", "customers", "endDateTime", "isCustomerAllowedToManageBooking", "isLocationOnline", "joinWebUrl", "lastUpdatedDateTime", "maximumAttendeesCount", "optOutOfCustomerEmail", "postBuffer", "preBuffer", "price", "priceType", "reminders", "selfServiceAppointmentId", "serviceId", "serviceLocation", "serviceName", "serviceNotes", "smsNotificationsEnabled", "staffMemberIds", "startDateTime"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    booking_business_id                   = "test-parent-id"
    additional_information                = "example"
    is_customer_allowed_to_manage_booking = false
    maximum_attendees_count               = -2147483648
    end_date_time                         = { "dateTime" = null }
    customers                             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInformation"]) == jsonencode("example")
    error_message = "additionalInformation must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCustomerAllowedToManageBooking"]) == jsonencode(false)
    error_message = "isCustomerAllowedToManageBooking must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["maximumAttendeesCount"]) == jsonencode(-2147483648)
    error_message = "maximumAttendeesCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["endDateTime"]) == jsonencode({ "@odata.type" = "#microsoft.graph.dateTimeTimeZone" })
    error_message = "endDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.bookingCustomerInformationBase" }])
    error_message = "customers must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    booking_business_id = "test-parent-id"
    price_type          = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.price_type]
}
