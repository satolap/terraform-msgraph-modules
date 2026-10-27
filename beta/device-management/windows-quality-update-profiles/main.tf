# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignments"                  = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"              = var.created_date_time
    "deployableContentDisplayName" = var.deployable_content_display_name
    "description"                  = var.description
    "displayName"                  = var.display_name
    "expeditedUpdateSettings"      = (var.expedited_update_settings == null ? null : { for key0, value0 in { "@odata.type" = var.expedited_update_settings["odata_type"], "daysUntilForcedReboot" = var.expedited_update_settings["daysUntilForcedReboot"], "qualityUpdateCatalogItemId" = var.expedited_update_settings["qualityUpdateCatalogItemId"], "qualityUpdateRelease" = var.expedited_update_settings["qualityUpdateRelease"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"         = var.last_modified_date_time
    "@odata.type"                  = var.odata_type
    "releaseDateDisplayName"       = var.release_date_display_name
    "roleScopeTagIds"              = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsQualityUpdateProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments"], name)])]))))] } : null

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
