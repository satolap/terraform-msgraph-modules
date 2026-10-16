# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    organization_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "organization/test-parent-id/branding/themes"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isDefaultTheme", "localizations", "name"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    organization_id  = "test-parent-id"
    name             = "example"
    is_default_theme = false
    localizations    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["name"]) == jsonencode("example")
    error_message = "name must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDefaultTheme"]) == jsonencode(false)
    error_message = "isDefaultTheme must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["localizations"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.organizationalBrandingThemeLocalization" }])
    error_message = "localizations must preserve typed values and omit nested nulls."
  }
}
