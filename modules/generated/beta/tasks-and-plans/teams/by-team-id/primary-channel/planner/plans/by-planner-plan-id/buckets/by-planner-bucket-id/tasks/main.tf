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
    "recurrence"               = var.recurrence
    "referenceCount"           = var.reference_count
    "startDateTime"            = var.start_date_time
    "title"                    = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teams/${urlencode(var.team_id)}/primaryChannel/planner/plans/${urlencode(var.planner_plan_id)}/buckets/${urlencode(var.planner_bucket_id)}/tasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
