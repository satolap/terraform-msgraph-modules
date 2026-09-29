# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.androidAospReferencedApp"
  }

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/mobileApps"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "categories", "description", "developer", "displayName", "informationUrl", "isFeatured", "largeIcon", "notes", "owner", "privacyInformationUrl", "publisher", "relationships", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type  = "#microsoft.graph.androidAospReferencedApp"
    description = "example"
    is_featured = false
    large_icon  = { "type" = null }
    assignments = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.androidAospReferencedApp")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isFeatured"]) == jsonencode(false)
    error_message = "isFeatured must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["largeIcon"]) == jsonencode({ "@odata.type" = "#microsoft.graph.mimeContent" })
    error_message = "largeIcon must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.mobileAppAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
