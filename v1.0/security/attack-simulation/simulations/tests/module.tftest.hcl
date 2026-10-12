# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/attackSimulation/simulations"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["attackTechnique", "attackType", "automationId", "completionDateTime", "createdBy", "createdDateTime", "description", "displayName", "durationInDays", "endUserNotificationSetting", "excludedAccountTarget", "includedAccountTarget", "isAutomated", "landingPage", "lastModifiedBy", "lastModifiedDateTime", "launchDateTime", "loginPage", "oAuthConsentAppDetail", "payload", "payloadDeliveryPlatform", "report", "status", "trainingSetting"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    attack_technique = "unknown"
    is_automated     = false
    duration_in_days = -2147483648
    created_by       = { "displayName" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["attackTechnique"]) == jsonencode("unknown")
    error_message = "attackTechnique must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAutomated"]) == jsonencode(false)
    error_message = "isAutomated must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["durationInDays"]) == jsonencode(-2147483648)
    error_message = "durationInDays must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdBy"]) == jsonencode({ "@odata.type" = "#microsoft.graph.emailIdentity" })
    error_message = "createdBy must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    attack_technique = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.attack_technique]
}
