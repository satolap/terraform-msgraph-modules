# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.industryData.inboundApiFlow"
  }

  assert {
    condition     = msgraph_resource.this.url == "external/industryData/inboundFlows"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["dataConnector", "dataDomain", "displayName", "effectiveDateTime", "expirationDateTime", "year"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type  = "#microsoft.graph.industryData.inboundApiFlow"
    data_domain = "educationRostering"
    year        = { "displayName" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.industryData.inboundApiFlow")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["dataDomain"]) == jsonencode("educationRostering")
    error_message = "dataDomain must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["year"]) == jsonencode({ "@odata.type" = "#microsoft.graph.industryData.yearTimePeriodDefinition" })
    error_message = "year must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
