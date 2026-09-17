# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    sensitivity_label_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "dataClassification/sensitivityLabels/test-parent-id/sublabels"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["actionSource", "applicableTo", "applicationMode", "autoTooltip", "color", "description", "displayName", "hasProtection", "isDefault", "isEnabled", "isEndpointProtectionEnabled", "isScopedToUser", "locale", "name", "priority", "rights", "sublabels", "toolTip"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    sensitivity_label_id = "test-parent-id"
    auto_tooltip         = "example"
    has_protection       = false
    priority             = -2147483648
    sublabels            = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["autoTooltip"]) == jsonencode("example")
    error_message = "autoTooltip must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["hasProtection"]) == jsonencode(false)
    error_message = "hasProtection must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priority"]) == jsonencode(-2147483648)
    error_message = "priority must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sublabels"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.sensitivityLabel" }])
    error_message = "sublabels must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    sensitivity_label_id = "test-parent-id"
    action_source        = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action_source]
}
