# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "admin/exchange/messageTraces"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["destinationIPAddress", "messageId", "receivedDateTime", "recipients", "senderEmail", "size", "sourceIPAddress", "subject"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    destination_ip_address = "example"
    size                   = -2147483648
    recipients             = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["destinationIPAddress"]) == jsonencode("example")
    error_message = "destinationIPAddress must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["size"]) == jsonencode(-2147483648)
    error_message = "size must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["recipients"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.messageRecipient" }])
    error_message = "recipients must preserve typed values and omit nested nulls."
  }
}
