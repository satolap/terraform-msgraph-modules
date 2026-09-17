# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"   = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "appId" = var.created_by["appId"], "displayName" = var.created_by["displayName"], "servicePrincipalId" = var.created_by["servicePrincipalId"], "servicePrincipalName" = var.created_by["servicePrincipalName"] } : key0 => value0 if value0 != null })
    "displayName" = var.display_name
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "print/taskDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
