# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/identities/sensorCandidates"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["computerDnsName", "domainName", "lastSeenDateTime", "senseClientVersion", "sensorTypes"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    computer_dns_name = "example"
    sensor_types      = ["domainController"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["computerDnsName"]) == jsonencode("example")
    error_message = "computerDnsName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sensorTypes"]) == jsonencode(["domainController"])
    error_message = "sensorTypes must preserve typed values and omit nested nulls."
  }
}
