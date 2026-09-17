# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    education_class_id  = "test-parent-id"
    education_module_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "education/classes/test-parent-id/modules/test-parent-id/resources"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["resource"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}
