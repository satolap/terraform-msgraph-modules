# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/assignments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["customExtensionCalloutInstances"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    custom_extension_callout_instances = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["customExtensionCalloutInstances"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customExtensionCalloutInstance" }])
    error_message = "customExtensionCalloutInstances must preserve typed values and omit nested nulls."
  }
}
