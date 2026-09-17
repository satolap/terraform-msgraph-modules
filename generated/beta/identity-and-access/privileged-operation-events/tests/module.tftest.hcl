# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "privilegedOperationEvents"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalInformation", "creationDateTime", "expirationDateTime", "referenceKey", "referenceSystem", "requestType", "requestorId", "requestorName", "roleId", "roleName", "tenantId", "userId", "userMail", "userName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    additional_information = "example"
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInformation"]) == jsonencode("example")
    error_message = "additionalInformation must preserve typed values and omit nested nulls."
  }
}
