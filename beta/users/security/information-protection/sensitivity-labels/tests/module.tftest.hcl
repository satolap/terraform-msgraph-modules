# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/security/informationProtection/sensitivityLabels"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["color", "contentFormats", "description", "hasProtection", "isActive", "isAppliable", "name", "parent", "sensitivity", "tooltip"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id         = "test-parent-id"
    color           = "example"
    has_protection  = false
    sensitivity     = -2147483648
    content_formats = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["color"]) == jsonencode("example")
    error_message = "color must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasProtection"]) == jsonencode(false)
    error_message = "hasProtection must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sensitivity"]) == jsonencode(-2147483648)
    error_message = "sensitivity must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["contentFormats"]) == jsonencode(["example"])
    error_message = "contentFormats must preserve typed values and omit nested nulls."
  }
}
