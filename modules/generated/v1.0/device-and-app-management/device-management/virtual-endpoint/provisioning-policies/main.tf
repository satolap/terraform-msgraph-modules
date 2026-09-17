# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"              = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "autopatch"                = var.autopatch
    "cloudPcNamingTemplate"    = var.cloud_pc_naming_template
    "description"              = var.description
    "displayName"              = var.display_name
    "domainJoinConfigurations" = (var.domain_join_configurations == null ? null : [for item0 in var.domain_join_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "domainJoinType" = item0["domainJoinType"], "onPremisesConnectionId" = item0["onPremisesConnectionId"], "regionName" = item0["regionName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "enableSingleSignOn"       = var.enable_single_sign_on
    "imageDisplayName"         = var.image_display_name
    "imageId"                  = var.image_id
    "imageType"                = var.image_type
    "localAdminEnabled"        = var.local_admin_enabled
    "microsoftManagedDesktop"  = var.microsoft_managed_desktop
    "@odata.type"              = var.odata_type
    "provisioningType"         = var.provisioning_type
    "windowsSetting"           = var.windows_setting
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/provisioningPolicies"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
