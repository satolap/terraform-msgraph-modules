# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "lastSharedMethod" = var.last_shared_method
    "@odata.type"      = var.odata_type
    "resource"         = var.resource
    "sharingHistory"   = (var.sharing_history == null ? null : [for item0 in var.sharing_history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "sharedBy" = item0["sharedBy"], "sharingSubject" = item0["sharingSubject"], "sharingType" = item0["sharingType"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/insights/shared"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
