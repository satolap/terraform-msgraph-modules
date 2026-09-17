# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "onPremisesPublishingProfiles"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["applicationSegments", "hybridAgentUpdaterConfiguration", "isDefaultAccessEnabled", "isEnabled", "sensors"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    is_default_access_enabled = false
    application_segments      = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefaultAccessEnabled"]) == jsonencode(false)
    error_message = "isDefaultAccessEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["applicationSegments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.ipApplicationSegment" }])
    error_message = "applicationSegments must preserve typed values and omit nested nulls."
  }
}
