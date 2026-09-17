# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/people/profileCardProperties"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["annotations", "directoryPropertyName", "isVisible"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    directory_property_name = "example"
    is_visible              = false
    annotations             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["directoryPropertyName"]) == jsonencode("example")
    error_message = "directoryPropertyName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isVisible"]) == jsonencode(false)
    error_message = "isVisible must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["annotations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.profileCardAnnotation" }])
    error_message = "annotations must preserve typed values and omit nested nulls."
  }
}
