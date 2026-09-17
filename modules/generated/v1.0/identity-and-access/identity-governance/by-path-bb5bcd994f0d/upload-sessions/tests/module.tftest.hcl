# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    access_package_resource_id       = "test-parent-id"
    access_package_resource_role_id  = "test-parent-id"
    access_package_resource_scope_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/resources/test-parent-id/roles/test-parent-id/resource/scopes/test-parent-id/resource/uploadSessions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["data", "files", "isUploadDone", "referenceId", "stats", "status"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_package_resource_id       = "test-parent-id"
    access_package_resource_role_id  = "test-parent-id"
    access_package_resource_scope_id = "test-parent-id"
    reference_id                     = "example"
    is_upload_done                   = false
    stats                            = { "filesUploaded" = null }
    files                            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["referenceId"]) == jsonencode("example")
    error_message = "referenceId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isUploadDone"]) == jsonencode(false)
    error_message = "isUploadDone must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["stats"]) == jsonencode({ "@odata.type" = "#microsoft.graph.customDataProvidedResourceUploadStats" })
    error_message = "stats must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["files"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.customDataProvidedResourceFile" }])
    error_message = "files must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_package_resource_id       = "test-parent-id"
    access_package_resource_role_id  = "test-parent-id"
    access_package_resource_scope_id = "test-parent-id"
    status                           = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.status]
}
