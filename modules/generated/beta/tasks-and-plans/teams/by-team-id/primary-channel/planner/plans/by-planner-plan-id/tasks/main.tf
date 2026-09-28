# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activeChecklistItemCount" = var.active_checklist_item_count
    "appliedCategories"        = var.applied_categories
    "assigneePriority"         = var.assignee_priority
    "assignments"              = var.assignments
    "bucketId"                 = var.bucket_id
    "checklistItemCount"       = var.checklist_item_count
    "completedBy"              = var.completed_by
    "conversationThreadId"     = var.conversation_thread_id
    "createdBy"                = var.created_by
    "creationSource"           = var.creation_source
    "dueDateTime"              = var.due_date_time
    "isOnMyDay"                = var.is_on_my_day
    "@odata.type"              = var.odata_type
    "orderHint"                = var.order_hint
    "percentComplete"          = var.percent_complete
    "planId"                   = var.plan_id
    "previewType"              = var.preview_type
    "priority"                 = var.priority
    "recurrence"               = (var.recurrence == null ? null : { for key0, value0 in { "@odata.type" = var.recurrence["odata_type"], "nextInSeriesTaskId" = var.recurrence["nextInSeriesTaskId"], "occurrenceId" = var.recurrence["occurrenceId"], "previousInSeriesTaskId" = var.recurrence["previousInSeriesTaskId"], "recurrenceStartDateTime" = var.recurrence["recurrenceStartDateTime"], "schedule" = (var.recurrence["schedule"] == null ? null : { for key1, value1 in { "@odata.type" = var.recurrence["schedule"]["odata_type"], "pattern" = (var.recurrence["schedule"]["pattern"] == null ? null : { for key2, value2 in { "@odata.type" = var.recurrence["schedule"]["pattern"]["odata_type"], "dayOfMonth" = var.recurrence["schedule"]["pattern"]["dayOfMonth"], "daysOfWeek" = (var.recurrence["schedule"]["pattern"]["daysOfWeek"] == null ? null : [for item3 in var.recurrence["schedule"]["pattern"]["daysOfWeek"] : item3 if item3 != null]), "firstDayOfWeek" = var.recurrence["schedule"]["pattern"]["firstDayOfWeek"], "index" = var.recurrence["schedule"]["pattern"]["index"], "interval" = var.recurrence["schedule"]["pattern"]["interval"], "month" = var.recurrence["schedule"]["pattern"]["month"], "type" = var.recurrence["schedule"]["pattern"]["type"] } : key2 => value2 if value2 != null }), "patternStartDateTime" = var.recurrence["schedule"]["patternStartDateTime"] } : key1 => value1 if value1 != null }), "seriesId" = var.recurrence["seriesId"] } : key0 => value0 if value0 != null })
    "referenceCount"           = var.reference_count
    "startDateTime"            = var.start_date_time
    "title"                    = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teams/${urlencode(var.team_id)}/primaryChannel/planner/plans/${urlencode(var.planner_plan_id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
