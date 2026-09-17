# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/tiIndicators"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["action", "activityGroupNames", "additionalInformation", "azureTenantId", "confidence", "description", "diamondModel", "domainName", "emailEncoding", "emailLanguage", "emailRecipient", "emailSenderAddress", "emailSenderName", "emailSourceDomain", "emailSourceIpAddress", "emailSubject", "emailXMailer", "expirationDateTime", "externalId", "fileCompileDateTime", "fileCreatedDateTime", "fileHashType", "fileHashValue", "fileMutexName", "fileName", "filePacker", "filePath", "fileSize", "fileType", "ingestedDateTime", "isActive", "killChain", "knownFalsePositives", "lastReportedDateTime", "malwareFamilyNames", "networkCidrBlock", "networkDestinationAsn", "networkDestinationCidrBlock", "networkDestinationIPv4", "networkDestinationIPv6", "networkDestinationPort", "networkIPv4", "networkIPv6", "networkPort", "networkProtocol", "networkSourceAsn", "networkSourceCidrBlock", "networkSourceIPv4", "networkSourceIPv6", "networkSourcePort", "passiveOnly", "severity", "tags", "targetProduct", "threatType", "tlpLevel", "url", "userAgent"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    additional_information = "example"
    is_active              = false
    confidence             = -2147483648
    activity_group_names   = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInformation"]) == jsonencode("example")
    error_message = "additionalInformation must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isActive"]) == jsonencode(false)
    error_message = "isActive must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["confidence"]) == jsonencode(-2147483648)
    error_message = "confidence must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activityGroupNames"]) == jsonencode(["example"])
    error_message = "activityGroupNames must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    action = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.action]
}
