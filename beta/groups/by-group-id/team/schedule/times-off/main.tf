# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"           = var.created_by
    "draftTimeOff"        = (var.draft_time_off == null ? null : { for key0, value0 in { "@odata.type" = var.draft_time_off["odata_type"], "endDateTime" = var.draft_time_off["endDateTime"], "startDateTime" = var.draft_time_off["startDateTime"], "theme" = var.draft_time_off["theme"], "timeOffReasonId" = var.draft_time_off["timeOffReasonId"] } : key0 => value0 if value0 != null })
    "isStagedForDeletion" = var.is_staged_for_deletion
    "@odata.type"         = var.odata_type
    "sharedTimeOff"       = (var.shared_time_off == null ? null : { for key0, value0 in { "@odata.type" = var.shared_time_off["odata_type"], "endDateTime" = var.shared_time_off["endDateTime"], "startDateTime" = var.shared_time_off["startDateTime"], "theme" = var.shared_time_off["theme"], "timeOffReasonId" = var.shared_time_off["timeOffReasonId"] } : key0 => value0 if value0 != null })
    "userId"              = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/schedule/timesOff"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
