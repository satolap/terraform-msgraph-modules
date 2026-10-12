# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    odata_type = "#microsoft.graph.security.emailContentThreatSubmission"
  }

  assert {
    condition     = msgraph_resource.this.url == "security/threatSubmission/emailThreats"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["adminReview", "attackSimulationInfo", "category", "clientSource", "contentType", "createdBy", "createdDateTime", "source", "internetMessageId", "originalCategory", "receivedDateTime", "recipientEmailAddress", "result", "sender", "senderIP", "status", "subject", "tenantAllowOrBlockListAction", "tenantId"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    odata_type   = "#microsoft.graph.security.emailContentThreatSubmission"
    category     = "notJunk"
    admin_review = { "reviewBy" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["@odata.type"]) == jsonencode("#microsoft.graph.security.emailContentThreatSubmission")
    error_message = "@odata.type must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["category"]) == jsonencode("notJunk")
    error_message = "category must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["adminReview"]) == jsonencode({ "@odata.type" = "#microsoft.graph.security.submissionAdminReview" })
    error_message = "adminReview must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    odata_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.odata_type]
}
