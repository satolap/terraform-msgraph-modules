# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/zebraFotaDeployments"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["deploymentSettings", "deploymentStatus", "description", "displayName", "roleScopeTagIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description         = "example"
    deployment_settings = { "batteryRuleMinimumBatteryLevelPercentage" = null }
    role_scope_tag_ids  = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deploymentSettings"]) == jsonencode({ "@odata.type" = "#microsoft.graph.zebraFotaDeploymentSettings" })
    error_message = "deploymentSettings must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleScopeTagIds"]) == jsonencode(["example"])
    error_message = "roleScopeTagIds must preserve typed values and omit nested nulls."
  }
}
