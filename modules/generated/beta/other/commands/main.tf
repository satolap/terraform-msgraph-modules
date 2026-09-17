# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appServiceName"    = var.app_service_name
    "error"             = var.error
    "@odata.type"       = var.odata_type
    "packageFamilyName" = var.package_family_name
    "payload"           = var.payload
    "permissionTicket"  = var.permission_ticket
    "postBackUri"       = var.post_back_uri
    "responsepayload"   = var.responsepayload
    "status"            = var.status
    "type"              = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "commands"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
