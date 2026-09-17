# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "security/threatIntelligence/vulnerabilities"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["activeExploitsObserved", "articles", "commonWeaknessEnumerationIds", "components", "createdDateTime", "cvss2Summary", "cvss3Summary", "description", "exploits", "exploitsAvailable", "hasChatter", "lastModifiedDateTime", "priorityScore", "publishedDateTime", "references", "remediation", "severity"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time        = "2026-01-01T00:00:00Z"
    active_exploits_observed = false
    priority_score           = -2147483648
    cvss2_summary            = { "score" = null }
    articles                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["activeExploitsObserved"]) == jsonencode(false)
    error_message = "activeExploitsObserved must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["priorityScore"]) == jsonencode(-2147483648)
    error_message = "priorityScore must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cvss2Summary"]) == jsonencode({ "@odata.type" = "#microsoft.graph.security.cvssSummary" })
    error_message = "cvss2Summary must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["articles"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.security.article" }])
    error_message = "articles must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    severity = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.severity]
}
