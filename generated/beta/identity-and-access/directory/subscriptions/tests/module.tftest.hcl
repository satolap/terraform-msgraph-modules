# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "directory/subscriptions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["commerceSubscriptionId", "createdDateTime", "isTrial", "nextLifecycleDateTime", "ocpSubscriptionId", "ownerId", "ownerTenantId", "ownerType", "serviceStatus", "skuId", "skuPartNumber", "status", "totalLicenses"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    commerce_subscription_id = "example"
    is_trial                 = false
    total_licenses           = -2147483648
    service_status           = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["commerceSubscriptionId"]) == jsonencode("example")
    error_message = "commerceSubscriptionId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isTrial"]) == jsonencode(false)
    error_message = "isTrial must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["totalLicenses"]) == jsonencode(-2147483648)
    error_message = "totalLicenses must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["serviceStatus"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.servicePlanInfo" }])
    error_message = "serviceStatus must preserve typed values and omit nested nulls."
  }
}
