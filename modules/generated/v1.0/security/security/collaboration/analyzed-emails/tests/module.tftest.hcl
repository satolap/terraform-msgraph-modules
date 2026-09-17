# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/collaboration/analyzedEmails"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["alertIds", "attachments", "authenticationDetails", "bulkComplaintLevel", "clientType", "contexts", "detectionMethods", "directionality", "distributionList", "dlpRules", "emailClusterId", "exchangeTransportRules", "forwardingDetail", "inboundConnectorFormattedName", "internetMessageId", "language", "latestDelivery", "loggedDateTime", "networkMessageId", "originalDelivery", "overrideSources", "phishConfidenceLevel", "policy", "policyAction", "policyType", "primaryOverrideSource", "recipientDetail", "recipientEmailAddress", "returnPath", "senderDetail", "sizeInBytes", "spamConfidenceLevel", "subject", "threatDetectionDetails", "threatTypes", "timelineEvents", "urls"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    bulk_complaint_level = "example"
    size_in_bytes        = -2147483648
    alert_ids            = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["bulkComplaintLevel"]) == jsonencode("example")
    error_message = "bulkComplaintLevel must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["sizeInBytes"]) == jsonencode(-2147483648)
    error_message = "sizeInBytes must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["alertIds"]) == jsonencode(["example"])
    error_message = "alertIds must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    directionality = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.directionality]
}
