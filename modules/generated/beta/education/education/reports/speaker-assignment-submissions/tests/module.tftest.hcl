# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "education/reports/speakerAssignmentSubmissions"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignmentId", "averageWordsPerMinutePace", "classId", "fillerWordsOccurrencesCount", "incorrectCameraDistanceOccurrencesCount", "lengthOfSubmissionInSeconds", "lostEyeContactOccurrencesCount", "monotoneOccurrencesCount", "nonInclusiveLanguageOccurrencesCount", "obstructedViewOccurrencesCount", "repetitiveLanguageOccurrencesCount", "studentId", "submissionDateTime", "submissionId", "topFillerWords", "topMispronouncedWords", "topNonInclusiveWordsAndPhrases", "topRepetitiveWordsAndPhrases", "wordsSpokenCount"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    assignment_id                 = "example"
    average_words_per_minute_pace = 0
    top_filler_words              = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignmentId"]) == jsonencode("example")
    error_message = "assignmentId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["averageWordsPerMinutePace"]) == jsonencode(0)
    error_message = "averageWordsPerMinutePace must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["topFillerWords"]) == jsonencode(["example"])
    error_message = "topFillerWords must preserve typed values and omit nested nulls."
  }
}
