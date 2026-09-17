# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "networkAccess/forwardingProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["associations", "description", "version", "isCustomProfile", "lastModifiedDateTime", "name", "policies", "priority", "servicePrincipal", "state", "trafficForwardingType"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description       = "example"
    is_custom_profile = false
    priority          = -2147483648
    service_principal = { "accountEnabled" = null }
    associations      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isCustomProfile"]) == jsonencode(false)
    error_message = "isCustomProfile must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priority"]) == jsonencode(-2147483648)
    error_message = "priority must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["servicePrincipal"]) == jsonencode({ "@odata.type" = "#microsoft.graph.servicePrincipal" })
    error_message = "servicePrincipal must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["associations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.networkaccess.association" }])
    error_message = "associations must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    state = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.state]
}
