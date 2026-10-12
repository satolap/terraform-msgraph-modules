# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"       = var.odata_type
    "applicableContent" = (var.applicable_content == null ? null : [for item0 in var.applicable_content : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "catalogEntry" = item0["catalogEntry"], "catalogEntryId" = item0["catalogEntryId"], "matchedDevices" = (item0["matchedDevices"] == null ? null : [for item2 in item0["matchedDevices"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deviceId" = item2["deviceId"], "recommendedBy" = (item2["recommendedBy"] == null ? null : [for item4 in item2["recommendedBy"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "approvalRules"     = (var.approval_rules == null ? null : [for item0 in var.approval_rules : item0 if item0 != null])
    "approvals"         = (var.approvals == null ? null : [for item0 in var.approvals : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "catalogEntryId" = item0["catalogEntryId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"       = var.description
    "displayName"       = var.display_name
    "rings"             = (var.rings == null ? null : [for item0 in var.rings : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/windows/updates/policies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
