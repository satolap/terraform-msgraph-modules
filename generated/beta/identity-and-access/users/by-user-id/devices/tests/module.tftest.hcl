# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/devices"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountEnabled", "alternativeNames", "alternativeSecurityIds", "commands", "deletedDateTime", "deviceCategory", "deviceId", "deviceMetadata", "deviceOwnership", "deviceVersion", "displayName", "domainName", "enrollmentProfileName", "enrollmentType", "extensionAttributes", "hostnames", "isManaged", "isRooted", "kind", "managementType", "name", "operatingSystem", "operatingSystemVersion", "physicalIds", "platform", "profileType", "status", "systemLabels", "transitiveMemberOf", "usageRights"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id           = "test-parent-id"
    deleted_date_time = "2026-01-01T00:00:00Z"
    account_enabled   = false
    device_version    = -2147483648
    alternative_names = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deletedDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "deletedDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountEnabled"]) == jsonencode(false)
    error_message = "accountEnabled must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["deviceVersion"]) == jsonencode(-2147483648)
    error_message = "deviceVersion must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alternativeNames"]) == jsonencode(["example"])
    error_message = "alternativeNames must preserve typed values and omit nested nulls."
  }
}
