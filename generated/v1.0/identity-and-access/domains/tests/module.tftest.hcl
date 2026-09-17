# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "domains"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["authenticationType", "availabilityStatus", "federationConfiguration", "isAdminManaged", "isDefault", "isInitial", "isRoot", "isVerified", "manufacturer", "model", "passwordNotificationWindowInDays", "passwordValidityPeriodInDays", "state", "supportedServices"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    authentication_type                  = "example"
    is_admin_managed                     = false
    password_notification_window_in_days = -2147483648
    federation_configuration             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["authenticationType"]) == jsonencode("example")
    error_message = "authenticationType must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isAdminManaged"]) == jsonencode(false)
    error_message = "isAdminManaged must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["passwordNotificationWindowInDays"]) == jsonencode(-2147483648)
    error_message = "passwordNotificationWindowInDays must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["federationConfiguration"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.internalDomainFederation" }])
    error_message = "federationConfiguration must preserve typed values and omit nested nulls."
  }
}
