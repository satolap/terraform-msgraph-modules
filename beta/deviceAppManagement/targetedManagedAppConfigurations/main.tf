# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appGroupType"                = var.appGroupType
    "apps"                        = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                 = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"             = var.createdDateTime
    "customSettings"              = (var.customSettings == null ? null : [for item0 in var.customSettings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deployedAppCount"            = var.deployedAppCount
    "deploymentSummary"           = var.deploymentSummary
    "description"                 = var.description
    "displayName"                 = var.displayName
    "version"                     = var.graph_version
    "isAssigned"                  = var.isAssigned
    "lastModifiedDateTime"        = var.lastModifiedDateTime
    "@odata.type"                 = var.odata_type
    "roleScopeTagIds"             = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "settings"                    = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingInstance" = item0["settingInstance"] } : key1 => value1 if value1 != null }) if item0 != null])
    "targetedAppManagementLevels" = var.targetedAppManagementLevels
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/targetedManagedAppConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "assignments", "deploymentSummary", "settings"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
