# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatIntelligence/whoisHistoryRecords"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["abuse", "admin", "billing", "domainStatus", "expirationDateTime", "firstSeenDateTime", "host", "lastSeenDateTime", "lastUpdateDateTime", "nameservers", "noc", "rawWhoisText", "registrant", "registrar", "registrationDateTime", "technical", "whoisServer", "zone"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    domain_status = "example"
    host          = { "childHostPairs" = null }
    nameservers   = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["domainStatus"]) == jsonencode("example")
    error_message = "domainStatus must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["host"]) == jsonencode({ "@odata.type" = "#microsoft.graph.security.host" })
    error_message = "host must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["nameservers"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.whoisNameserver" }])
    error_message = "nameservers must preserve typed values and omit nested nulls."
  }
}
