# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "categories"        = (var.categories == null ? null : [for item0 in var.categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "hasRequiredSetting" = item0["hasRequiredSetting"], "recommendedSettings" = (item0["recommendedSettings"] == null ? null : [for item2 in item0["recommendedSettings"] : item2 if item2 != null]), "settingDefinitions" = (item0["settingDefinitions"] == null ? null : [for item2 in item0["settingDefinitions"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "description"       = var.description
    "displayName"       = var.display_name
    "intentCount"       = var.intent_count
    "isDeprecated"      = var.is_deprecated
    "migratableTo"      = (var.migratable_to == null ? null : [for item0 in var.migratable_to : item0 if item0 != null])
    "@odata.type"       = var.odata_type
    "platformType"      = var.platform_type
    "publishedDateTime" = var.published_date_time
    "settings"          = (var.settings == null ? null : [for item0 in var.settings : item0 if item0 != null])
    "templateSubtype"   = var.template_subtype
    "templateType"      = var.template_type
    "versionInfo"       = var.version_info
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templates/${urlencode(var.device_management_template_id)}/migratableTo"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["categories", "migratableTo", "settings"], name)])]))))] } : null

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
