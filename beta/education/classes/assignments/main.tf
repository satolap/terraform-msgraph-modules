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
    "instructions"                            = (var.instructions == null ? null : { for key0, value0 in { "@odata.type" = var.instructions["odata_type"], "content" = var.instructions["content"], "contentType" = var.instructions["contentType"] } : key0 => value0 if value0 != null })
    "languageTag"                             = var.language_tag
    "moduleUrl"                               = var.module_url
    "notificationChannelUrl"                  = var.notification_channel_url
    "@odata.type"                             = var.odata_type
    "resources"                               = (var.resources == null ? null : [for item0 in var.resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "dependentResources" = (item0["dependentResources"] == null ? null : [for item2 in item0["dependentResources"] : item2 if item2 != null]), "distributeForStudentWork" = item0["distributeForStudentWork"], "resource" = item0["resource"] } : key1 => value1 if value1 != null }) if item0 != null])
    "rubric"                                  = var.rubric
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "education/classes/${urlencode(var.education_class_id)}/assignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["gradingCategory", "gradingScheme", "resources", "rubric"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
