# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "completedDateTime"        = var.completed_date_time
    "completionPercentage"     = var.completion_percentage
    "externalcourseActivityId" = var.externalcourse_activity_id
    "learnerUserId"            = var.learner_user_id
    "learningContentId"        = var.learning_content_id
    "learningProviderId"       = var.learning_provider_id
    "@odata.type"              = var.odata_type
    "status"                   = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "employeeExperience/learningCourseActivities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
