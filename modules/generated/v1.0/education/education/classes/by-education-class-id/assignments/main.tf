# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addToCalendarAction"                     = var.add_to_calendar_action
    "addedStudentAction"                      = var.added_student_action
    "allowLateSubmissions"                    = var.allow_late_submissions
    "allowStudentsToAddResourcesToSubmission" = var.allow_students_to_add_resources_to_submission
    "assignTo"                                = var.assign_to
    "classId"                                 = var.class_id
    "closeDateTime"                           = var.close_date_time
    "displayName"                             = var.display_name
    "dueDateTime"                             = var.due_date_time
    "grading"                                 = var.grading
    "gradingCategory"                         = var.grading_category
    "gradingScheme"                           = var.grading_scheme
    "instructions"                            = var.instructions
    "languageTag"                             = var.language_tag
    "moduleUrl"                               = var.module_url
    "notificationChannelUrl"                  = var.notification_channel_url
    "@odata.type"                             = var.odata_type
    "resources"                               = (var.resources == null ? null : [for item0 in var.resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "dependentResources" = (item0["dependentResources"] == null ? null : [for item2 in item0["dependentResources"] : item2 if item2 != null]), "distributeForStudentWork" = item0["distributeForStudentWork"], "resource" = item0["resource"] } : key1 => value1 if value1 != null }) if item0 != null])
    "rubric"                                  = var.rubric
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/classes/${urlencode(var.education_class_id)}/assignments"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
