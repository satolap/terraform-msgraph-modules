# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "capabilities"         = (var.capabilities == null ? null : { for key0, value0 in { "@odata.type" = var.capabilities["odata_type"] } : key0 => value0 if value0 != null })
    "cloudPcConfiguration" = (var.cloud_pc_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.cloud_pc_configuration["odata_type"], "imageId" = var.cloud_pc_configuration["imageId"], "imageType" = var.cloud_pc_configuration["imageType"], "osLocale" = var.cloud_pc_configuration["osLocale"] } : key0 => value0 if value0 != null })
    "description"          = var.description
    "displayName"          = var.display_name
    "networkConfiguration" = (var.network_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.network_configuration["odata_type"] } : key0 => value0 if value0 != null })
    "@odata.type"          = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/cloudPcPools"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
