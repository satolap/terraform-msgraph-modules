# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayTimeToLive"  = var.display_time_to_live
    "expirationDateTime" = var.expiration_date_time
    "groupName"          = var.group_name
    "@odata.type"        = var.odata_type
    "payload"            = (var.payload == null ? null : { for key0, value0 in { "@odata.type" = var.payload["odata_type"], "rawContent" = var.payload["rawContent"], "visualContent" = var.payload["visualContent"] } : key0 => value0 if value0 != null })
    "priority"           = var.priority
    "targetHostName"     = var.target_host_name
    "targetPolicy"       = var.target_policy
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/notifications"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
