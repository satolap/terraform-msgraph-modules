# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "subscribedSkus"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accountId", "accountName", "appliesTo", "capabilityStatus", "consumedUnits", "prepaidUnits", "servicePlans", "skuId", "skuPartNumber", "subscriptionIds"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    account_id     = "example"
    consumed_units = -2147483648
    service_plans  = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accountId"]) == jsonencode("example")
    error_message = "accountId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["consumedUnits"]) == jsonencode(-2147483648)
    error_message = "consumedUnits must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["servicePlans"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.servicePlanInfo" }])
    error_message = "servicePlans must preserve typed values and omit nested nulls."
  }
}
