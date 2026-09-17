# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/catalogs"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageCustomWorkflowExtensions", "accessPackageResourceScopes", "accessPackageResources", "catalogStatus", "catalogType", "customAccessPackageWorkflowExtensions", "description", "displayName", "isExternallyVisible", "privilegeLevel", "uniqueName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    catalog_status                            = "example"
    is_externally_visible                     = false
    access_package_custom_workflow_extensions = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["catalogStatus"]) == jsonencode("example")
    error_message = "catalogStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isExternallyVisible"]) == jsonencode(false)
    error_message = "isExternallyVisible must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessPackageCustomWorkflowExtensions"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customCalloutExtension" }])
    error_message = "accessPackageCustomWorkflowExtensions must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    privilege_level = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.privilege_level]
}
