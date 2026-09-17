# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "education/reports/readingCoachPassages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["isReadingCompleted", "languageTag", "practiceWords", "practicedAtDateTime", "storyType", "studentId", "timeSpentReadingInSeconds", "wordsAccuracyPercentage", "wordsPerMinute"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    language_tag         = "example"
    is_reading_completed = false
    practice_words       = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["languageTag"]) == jsonencode("example")
    error_message = "languageTag must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isReadingCompleted"]) == jsonencode(false)
    error_message = "isReadingCompleted must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["practiceWords"]) == jsonencode(["example"])
    error_message = "practiceWords must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    story_type = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.story_type]
}
