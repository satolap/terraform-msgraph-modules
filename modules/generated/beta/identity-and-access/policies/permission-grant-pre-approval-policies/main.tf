# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "conditions"      = (var.conditions == null ? null : [for item0 in var.conditions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "permissions" = (item0["permissions"] == null ? null : { for key2, value2 in { "@odata.type" = item0["permissions"]["odata_type"], "permissionKind" = item0["permissions"]["permissionKind"], "permissionType" = item0["permissions"]["permissionType"] } : key2 => value2 if value2 != null }), "scopeType" = item0["scopeType"], "sensitivityLabels" = (item0["sensitivityLabels"] == null ? null : { for key2, value2 in { "@odata.type" = item0["sensitivityLabels"]["odata_type"], "labelKind" = item0["sensitivityLabels"]["labelKind"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime" = var.deleted_date_time
    "@odata.type"     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "policies/permissionGrantPreApprovalPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
