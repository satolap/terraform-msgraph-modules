# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatIntelligence/hosts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["childHostPairs", "components", "cookies", "firstSeenDateTime", "hostPairs", "lastSeenDateTime", "parentHostPairs", "passiveDns", "passiveDnsReverse", "ports", "reputation", "sslCertificates", "subdomains", "trackers", "whois"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    first_seen_date_time = "2026-01-01T00:00:00Z"
    child_host_pairs     = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["firstSeenDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "firstSeenDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["childHostPairs"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.hostPair" }])
    error_message = "childHostPairs must preserve typed values and omit nested nulls."
  }
}
