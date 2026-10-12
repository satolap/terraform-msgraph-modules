# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityProtection/riskyAgents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalInfo", "agentDisplayName", "agentPlatform", "associatedUserId", "blastRadiusRisk", "blueprintId", "deviceId", "exposureRisk", "identityType", "isDeleted", "isEnabled", "isProcessing", "machineId", "riskDetail", "riskLastModifiedDateTime", "riskLevel", "riskState", "runtimeRisk", "sources"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    additional_info   = "example"
    is_deleted        = false
    blast_radius_risk = { "riskIndicators" = null }
    sources           = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInfo"]) == jsonencode("example")
    error_message = "additionalInfo must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isDeleted"]) == jsonencode(false)
    error_message = "isDeleted must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blastRadiusRisk"]) == jsonencode({ "@odata.type" = "#microsoft.graph.blastRadiusRisk" })
    error_message = "blastRadiusRisk must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sources"]) == jsonencode(["example"])
    error_message = "sources must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    identity_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.identity_type]
}
