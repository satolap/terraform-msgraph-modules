# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"           = var.created_by
    "draftShift"          = var.draft_shift
    "isStagedForDeletion" = var.is_staged_for_deletion
    "@odata.type"         = var.odata_type
    "schedulingGroupId"   = var.scheduling_group_id
    "sharedShift"         = var.shared_shift
    "userId"              = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "groups/${urlencode(var.group_id)}/team/schedule/shifts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
