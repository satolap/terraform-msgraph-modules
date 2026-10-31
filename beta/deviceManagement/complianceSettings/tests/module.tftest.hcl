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

  assert {
    condition     = msgraph_resource.this.ignore_missing_property == true
    error_message = "Default reads must retain the provider missing-property suppression."
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters == null
    error_message = "Default reads must keep the full default GET response."
  }
}

run "selected_response_is_opt_in" {
  command = plan

  variables {
    select_response = true
  }

  assert {
    condition     = msgraph_resource.this.read_query_parameters["$select"][0] == join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))
    error_message = "Only the explicit selection opt-in may narrow the response."
  }
}

run "typed_request" {
  command = plan

  variables {
    accessTypes = "none"
    occurrence  = { "maxDeviceOccurrence" = null }
    infoUrls    = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessTypes"]) == jsonencode("none")
    error_message = "accessTypes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["occurrence"]) == jsonencode({ "@odata.type" = "#microsoft.graph.deviceManagementConfigurationSettingOccurrence" })
    error_message = "occurrence must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["infoUrls"]) == jsonencode(["example"])
    error_message = "infoUrls must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    accessTypes = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.accessTypes]
}

run "flags_enum_combination" {
  command = plan

  variables {
    accessTypes  = "none, Add"
    riskLevel    = "low, Medium"
    settingUsage = "none, Configuration"
    visibility   = "none, SettingsCatalog"
  }

  assert {
    condition     = msgraph_resource.this.body["accessTypes"] == "none, Add"
    error_message = "accessTypes must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["riskLevel"] == "low, Medium"
    error_message = "riskLevel must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["settingUsage"] == "none, Configuration"
    error_message = "settingUsage must accept combined flags enum members."
  }

  assert {
    condition     = msgraph_resource.this.body["visibility"] == "none, SettingsCatalog"
    error_message = "visibility must accept combined flags enum members."
  }
}

run "invalid_flags_member" {
  command = plan

  variables {
    accessTypes = "none,__graphmodules_invalid_enum__"
  }

  expect_failures = [var.accessTypes]
}

run "timeouts_unset_sends_no_block" {
  command = plan

  assert {
    condition     = msgraph_resource.this.timeouts == null
    error_message = "Unset timeouts must send no timeouts block."
  }
}

run "timeouts_are_passed_through" {
  command = plan

  variables {
    timeouts = { create = "45m", update = "20m", read = "7m" }
  }

  assert {
    condition     = alltrue([msgraph_resource.this.timeouts.create == "45m", msgraph_resource.this.timeouts.update == "20m", msgraph_resource.this.timeouts.read == "7m", msgraph_resource.this.timeouts.delete == null])
    error_message = "Timeouts must reach the provider resource unchanged."
  }
}

run "timeouts_below_the_minimum" {
  command = plan

  variables {
    timeouts = { create = "10s" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_with_an_invalid_duration" {
  command = plan

  variables {
    timeouts = { update = "soon" }
  }

  expect_failures = [var.timeouts]
}

run "timeouts_of_zero" {
  command = plan

  variables {
    timeouts = { delete = "0s" }
  }

  expect_failures = [var.timeouts]
}
