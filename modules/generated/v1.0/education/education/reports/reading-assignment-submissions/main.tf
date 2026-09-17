# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accuracyScore"          = var.accuracy_score
    "action"                 = var.action
    "assignmentId"           = var.assignment_id
    "challengingWords"       = (var.challenging_words == null ? null : [for item0 in var.challenging_words : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "count" = item0["count"], "word" = item0["word"] } : key1 => value1 if value1 != null }) if item0 != null])
    "classId"                = var.class_id
    "insertions"             = var.insertions
    "mispronunciations"      = var.mispronunciations
    "missedExclamationMarks" = var.missed_exclamation_marks
    "missedPeriods"          = var.missed_periods
    "missedQuestionMarks"    = var.missed_question_marks
    "missedShorts"           = var.missed_shorts
    "monotoneScore"          = var.monotone_score
    "@odata.type"            = var.odata_type
    "omissions"              = var.omissions
    "repetitions"            = var.repetitions
    "selfCorrections"        = var.self_corrections
    "studentId"              = var.student_id
    "submissionDateTime"     = var.submission_date_time
    "submissionId"           = var.submission_id
    "unexpectedPauses"       = var.unexpected_pauses
    "wordCount"              = var.word_count
    "wordsPerMinute"         = var.words_per_minute
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/reports/readingAssignmentSubmissions"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
