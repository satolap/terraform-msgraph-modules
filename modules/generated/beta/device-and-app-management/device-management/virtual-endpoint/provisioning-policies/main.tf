# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                          = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"], "userSettingsPersistenceDetail" = item0["userSettingsPersistenceDetail"] } : key1 => value1 if value1 != null }) if item0 != null])
    "autopatch"                            = var.autopatch
    "autopilotConfiguration"               = var.autopilot_configuration
    "cloudPcNamingTemplate"                = var.cloud_pc_naming_template
    "description"                          = var.description
    "displayName"                          = var.display_name
    "domainJoinConfigurations"             = (var.domain_join_configurations == null ? null : [for item0 in var.domain_join_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "domainJoinType" = item0["domainJoinType"], "onPremisesConnectionId" = item0["onPremisesConnectionId"], "regionName" = item0["regionName"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "enableSingleSignOn"                   = var.enable_single_sign_on
    "imageDisplayName"                     = var.image_display_name
    "imageId"                              = var.image_id
    "imageType"                            = var.image_type
    "localAdminEnabled"                    = var.local_admin_enabled
    "managedBy"                            = var.managed_by
    "microsoftManagedDesktop"              = var.microsoft_managed_desktop
    "@odata.type"                          = var.odata_type
    "provisioningType"                     = var.provisioning_type
    "snapshotResetMode"                    = var.snapshot_reset_mode
    "userExperienceType"                   = var.user_experience_type
    "userSettingsPersistenceConfiguration" = var.user_settings_persistence_configuration
    "windowsSetting"                       = var.windows_setting
    "windowsSettings"                      = var.windows_settings
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/provisioningPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
