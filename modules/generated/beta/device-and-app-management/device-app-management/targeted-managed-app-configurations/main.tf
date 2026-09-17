# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appGroupType"                = var.app_group_type
    "apps"                        = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"             = var.created_date_time
    "customSettings"              = (var.custom_settings == null ? null : [for item0 in var.custom_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deployedAppCount"            = var.deployed_app_count
    "deploymentSummary"           = var.deployment_summary
    "description"                 = var.description
    "displayName"                 = var.display_name
    "version"                     = var.graph_version
    "isAssigned"                  = var.is_assigned
    "lastModifiedDateTime"        = var.last_modified_date_time
    "@odata.type"                 = var.odata_type
    "roleScopeTagIds"             = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "settings"                    = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingInstance" = (item0["settingInstance"] == null ? null : { for key2, value2 in { "@odata.type" = item0["settingInstance"]["odata_type"], "settingDefinitionId" = item0["settingInstance"]["settingDefinitionId"], "settingInstanceTemplateReference" = item0["settingInstance"]["settingInstanceTemplateReference"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "targetedAppManagementLevels" = var.targeted_app_management_levels
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/targetedManagedAppConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
