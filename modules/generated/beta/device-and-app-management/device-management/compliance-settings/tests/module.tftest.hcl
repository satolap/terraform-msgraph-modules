# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/complianceSettings"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessTypes", "applicability", "baseUri", "categoryId", "description", "displayName", "version", "helpText", "infoUrls", "keywords", "name", "occurrence", "offsetUri", "referredSettingInformationList", "riskLevel", "rootDefinitionId", "settingUsage", "uxBehavior", "visibility"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    access_types = "none"
    info_urls    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessTypes"]) == jsonencode("none")
    error_message = "accessTypes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["infoUrls"]) == jsonencode(["example"])
    error_message = "infoUrls must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    access_types = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.access_types]
}
