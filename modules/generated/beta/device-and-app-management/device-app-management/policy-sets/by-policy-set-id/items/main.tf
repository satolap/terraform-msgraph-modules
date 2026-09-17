# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "errorCode"            = var.error_code
    "guidedDeploymentTags" = (var.guided_deployment_tags == null ? null : [for item0 in var.guided_deployment_tags : item0 if item0 != null])
    "itemType"             = var.item_type
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "payloadId"            = var.payload_id
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/policySets/${urlencode(var.policy_set_id)}/items"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
