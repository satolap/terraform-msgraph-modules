# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/payloads"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["brand", "complexity", "createdBy", "createdDateTime", "description", "detail", "displayName", "source", "industry", "isAutomated", "isControversial", "isCurrentEvent", "language", "lastModifiedBy", "lastModifiedDateTime", "payloadTags", "platform", "predictedCompromiseRate", "simulationAttackType", "status", "technique", "theme"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    brand        = "unknown"
    is_automated = false
    created_by   = { "displayName" = null }
    payload_tags = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["brand"]) == jsonencode("unknown")
    error_message = "brand must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAutomated"]) == jsonencode(false)
    error_message = "isAutomated must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.emailIdentity" })
    error_message = "createdBy must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["payloadTags"]) == jsonencode(["example"])
    error_message = "payloadTags must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    brand = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.brand]
}
