# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"         = var.content
    "createdBy"       = var.created_by
    "createdDateTime" = var.created_date_time
    "deletedDateTime" = var.deleted_date_time
    "editedDateTime"  = var.edited_date_time
    "mentions"        = (var.mentions == null ? null : [for item0 in var.mentions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mentionType" = item0["mentionType"], "mentioned" = item0["mentioned"], "position" = item0["position"] } : key1 => value1 if value1 != null }) if item0 != null])
    "messageType"     = var.message_type
    "@odata.type"     = var.odata_type
    "parentEntityId"  = var.parent_entity_id
    "reactions"       = (var.reactions == null ? null : [for item0 in var.reactions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "reactionEvents" = (item0["reactionEvents"] == null ? null : [for item2 in item0["reactionEvents"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "createdBy" = item2["createdBy"], "createdDateTime" = item2["createdDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "reactionType" = item0["reactionType"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/primaryChannel/planner/plans/${urlencode(var.planner_plan_id)}/buckets/${urlencode(var.planner_bucket_id)}/tasks/${urlencode(var.planner_task_id)}/messages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
