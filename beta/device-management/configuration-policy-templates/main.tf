# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowUnmanagedSettings"            = var.allow_unmanaged_settings
    "baseId"                            = var.base_id
    "description"                       = var.description
    "disableEntraGroupPolicyAssignment" = var.disable_entra_group_policy_assignment
    "displayName"                       = var.display_name
    "displayVersion"                    = var.display_version
    "lifecycleState"                    = var.lifecycle_state
    "@odata.type"                       = var.odata_type
    "platforms"                         = var.platforms
    "settingTemplates"                  = (var.setting_templates == null ? null : [for item0 in var.setting_templates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingDefinitions" = (item0["settingDefinitions"] == null ? null : [for item2 in item0["settingDefinitions"] : item2 if item2 != null]), "settingInstanceTemplate" = item0["settingInstanceTemplate"] } : key1 => value1 if value1 != null }) if item0 != null])
    "technologies"                      = var.technologies
    "templateFamily"                    = var.template_family
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configurationPolicyTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["settingTemplates"], name)])]))))] } : null

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
