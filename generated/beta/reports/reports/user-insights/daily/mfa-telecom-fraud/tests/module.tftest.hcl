# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/userInsights/daily/mfaTelecomFraud"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["captchaFailureCount", "captchaNotTriggeredUserCount", "captchaShownUserCount", "captchaSuccessCount", "factDate", "telecomBlockedUserCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    fact_date             = "2026-01-01"
    captcha_failure_count = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["factDate"]) == jsonencode("2026-01-01")
    error_message = "factDate must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["captchaFailureCount"]) == jsonencode(0)
    error_message = "captchaFailureCount must preserve typed values and omit nested nulls."
  }
}
