# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "addToCalendarAction"                     = var.addToCalendarAction
    "addedStudentAction"                      = var.addedStudentAction
    "allowLateSubmissions"                    = var.allowLateSubmissions
    "allowStudentsToAddResourcesToSubmission" = var.allowStudentsToAddResourcesToSubmission
    "assignTo"                                = var.assignTo
    "classId"                                 = var.classId
    "closeDateTime"                           = var.closeDateTime
    "displayName"                             = var.displayName
    "dueDateTime"                             = var.dueDateTime
    "grading"                                 = var.grading
    "gradingCategory"                         = var.gradingCategory
    "gradingScheme"                           = var.gradingScheme
    "instructions"                            = (var.instructions == null ? null : { for key0, value0 in { "@odata.type" = var.instructions["odata_type"], "content" = var.instructions["content"], "contentType" = var.instructions["contentType"] } : key0 => value0 if value0 != null })
    "languageTag"                             = var.languageTag
    "moduleUrl"                               = var.moduleUrl
    "notificationChannelUrl"                  = var.notificationChannelUrl
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
  url                     = "education/classes/${urlencode(var.educationClass-id)}/assignments"
  api_version             = "v1.0"
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
