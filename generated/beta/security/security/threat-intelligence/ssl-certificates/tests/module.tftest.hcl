# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatIntelligence/sslCertificates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["expirationDateTime", "fingerprint", "firstSeenDateTime", "issueDateTime", "issuer", "lastSeenDateTime", "relatedHosts", "serialNumber", "sha1", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    expiration_date_time = "2026-01-01T00:00:00Z"
    related_hosts        = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["expirationDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "expirationDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["relatedHosts"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.host" }])
    error_message = "relatedHosts must preserve typed values and omit nested nulls."
  }
}
