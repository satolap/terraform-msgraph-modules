# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"           = var.created_by
    "draftTimeOff"        = var.draft_time_off
    "isStagedForDeletion" = var.is_staged_for_deletion
    "@odata.type"         = var.odata_type
    "sharedTimeOff"       = var.shared_time_off
    "userId"              = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/joinedTeams/${urlencode(var.team_id)}/schedule/timesOff"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
