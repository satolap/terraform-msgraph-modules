# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/partners/billing/manifests"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["blobCount", "blobs", "createdDateTime", "dataFormat", "eTag", "partitionType", "partnerTenantId", "rootDirectory", "sasToken", "schemaVersion"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time = "2026-01-01T00:00:00Z"
    blob_count        = -2147483648
    blobs             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blobCount"]) == jsonencode(-2147483648)
    error_message = "blobCount must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blobs"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.partners.billing.blob" }])
    error_message = "blobs must preserve typed values and omit nested nulls."
  }
}
