# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "tenantRelationships/managedTenants/managedTenantEmailNotifications"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alert", "createdByUserId", "createdDateTime", "emailAddresses", "emailBody", "lastActionByUserId", "lastActionDateTime", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_by_user_id = "example"
    email_addresses    = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdByUserId"]) == jsonencode("example")
    error_message = "createdByUserId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["emailAddresses"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.managedTenants.email" }])
    error_message = "emailAddresses must preserve typed values and omit nested nulls."
  }
}
