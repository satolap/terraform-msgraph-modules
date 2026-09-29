# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"           = var.created_by
    "draftOpenShift"      = (var.draft_open_shift == null ? null : { for key0, value0 in { "@odata.type" = var.draft_open_shift["odata_type"], "activities" = (var.draft_open_shift["activities"] == null ? null : [for item1 in var.draft_open_shift["activities"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "displayName" = item1["displayName"], "endDateTime" = item1["endDateTime"], "isPaid" = item1["isPaid"], "startDateTime" = item1["startDateTime"], "theme" = item1["theme"] } : key2 => value2 if value2 != null }) if item1 != null]), "displayName" = var.draft_open_shift["displayName"], "endDateTime" = var.draft_open_shift["endDateTime"], "notes" = var.draft_open_shift["notes"], "openSlotCount" = var.draft_open_shift["openSlotCount"], "startDateTime" = var.draft_open_shift["startDateTime"], "theme" = var.draft_open_shift["theme"] } : key0 => value0 if value0 != null })
    "isStagedForDeletion" = var.is_staged_for_deletion
    "@odata.type"         = var.odata_type
    "schedulingGroupId"   = var.scheduling_group_id
    "sharedOpenShift"     = (var.shared_open_shift == null ? null : { for key0, value0 in { "@odata.type" = var.shared_open_shift["odata_type"], "activities" = (var.shared_open_shift["activities"] == null ? null : [for item1 in var.shared_open_shift["activities"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "code" = item1["code"], "displayName" = item1["displayName"], "endDateTime" = item1["endDateTime"], "isPaid" = item1["isPaid"], "startDateTime" = item1["startDateTime"], "theme" = item1["theme"] } : key2 => value2 if value2 != null }) if item1 != null]), "displayName" = var.shared_open_shift["displayName"], "endDateTime" = var.shared_open_shift["endDateTime"], "notes" = var.shared_open_shift["notes"], "openSlotCount" = var.shared_open_shift["openSlotCount"], "startDateTime" = var.shared_open_shift["startDateTime"], "theme" = var.shared_open_shift["theme"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "teamTemplateDefinition/${urlencode(var.team_template_definition_id)}/teamDefinition/schedule/openShifts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
