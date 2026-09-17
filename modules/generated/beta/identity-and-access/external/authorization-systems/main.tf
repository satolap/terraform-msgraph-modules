# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authorizationSystemId"   = var.authorization_system_id
    "authorizationSystemName" = var.authorization_system_name
    "authorizationSystemType" = var.authorization_system_type
    "dataCollectionInfo"      = var.data_collection_info
    "@odata.type"             = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "external/authorizationSystems"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
