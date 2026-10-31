# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                       = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                   = var.createdDateTime
    "creationSource"                    = var.creationSource
    "description"                       = var.description
    "disableEntraGroupPolicyAssignment" = var.disableEntraGroupPolicyAssignment
    "lastModifiedDateTime"              = var.lastModifiedDateTime
    "name"                              = var.name
    "@odata.type"                       = var.odata_type
    "platforms"                         = var.platforms
    "priorityMetaData"                  = (var.priorityMetaData == null ? null : { for key0, value0 in { "@odata.type" = var.priorityMetaData["odata_type"], "priority" = var.priorityMetaData["priority"] } : key0 => value0 if value0 != null })
    "roleScopeTagIds"                   = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
    "settingCount"                      = var.settingCount
    "settings"                          = (var.settings == null ? null : [for item0 in var.settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "settingInstance" = item0["settingInstance"] } : key1 => value1 if value1 != null }) if item0 != null])
    "technologies"                      = var.technologies
    "templateReference"                 = (var.templateReference == null ? null : { for key0, value0 in { "@odata.type" = var.templateReference["odata_type"], "templateId" = var.templateReference["templateId"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/configurationPolicies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "settings"], name)])]))))] } : null

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
