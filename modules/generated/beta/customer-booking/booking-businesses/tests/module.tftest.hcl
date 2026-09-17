# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "bookingBusinesses"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["address", "bookingPageSettings", "businessHours", "businessType", "createdDateTime", "customQuestions", "defaultCurrencyIso", "displayName", "email", "languageTag", "lastUpdatedDateTime", "phone", "schedulingPolicy", "webSiteUrl"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    business_type  = "example"
    business_hours = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["businessType"]) == jsonencode("example")
    error_message = "businessType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["businessHours"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.bookingWorkHours" }])
    error_message = "businessHours must preserve typed values and omit nested nulls."
  }
}
