# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "administrativeUnitId" = var.administrative_unit_id
    "@odata.type"          = var.odata_type
    "roleId"               = var.role_id
    "roleMemberInfo"       = (var.role_member_info == null ? null : { for key0, value0 in { "@odata.type" = var.role_member_info["odata_type"], "displayName" = var.role_member_info["displayName"], "id" = var.role_member_info["id"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "scopedRoleMemberships"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
