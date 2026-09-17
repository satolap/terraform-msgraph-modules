# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignmentId"                            = var.assignment_id
    "averageWordsPerMinutePace"               = var.average_words_per_minute_pace
    "classId"                                 = var.class_id
    "fillerWordsOccurrencesCount"             = var.filler_words_occurrences_count
    "incorrectCameraDistanceOccurrencesCount" = var.incorrect_camera_distance_occurrences_count
    "lengthOfSubmissionInSeconds"             = var.length_of_submission_in_seconds
    "lostEyeContactOccurrencesCount"          = var.lost_eye_contact_occurrences_count
    "monotoneOccurrencesCount"                = var.monotone_occurrences_count
    "nonInclusiveLanguageOccurrencesCount"    = var.non_inclusive_language_occurrences_count
    "obstructedViewOccurrencesCount"          = var.obstructed_view_occurrences_count
    "@odata.type"                             = var.odata_type
    "repetitiveLanguageOccurrencesCount"      = var.repetitive_language_occurrences_count
    "studentId"                               = var.student_id
    "submissionDateTime"                      = var.submission_date_time
    "submissionId"                            = var.submission_id
    "topFillerWords"                          = (var.top_filler_words == null ? null : [for item0 in var.top_filler_words : item0 if item0 != null])
    "topMispronouncedWords"                   = (var.top_mispronounced_words == null ? null : [for item0 in var.top_mispronounced_words : item0 if item0 != null])
    "topNonInclusiveWordsAndPhrases"          = (var.top_non_inclusive_words_and_phrases == null ? null : [for item0 in var.top_non_inclusive_words_and_phrases : item0 if item0 != null])
    "topRepetitiveWordsAndPhrases"            = (var.top_repetitive_words_and_phrases == null ? null : [for item0 in var.top_repetitive_words_and_phrases : item0 if item0 != null])
    "wordsSpokenCount"                        = var.words_spoken_count
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/reports/speakerAssignmentSubmissions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
