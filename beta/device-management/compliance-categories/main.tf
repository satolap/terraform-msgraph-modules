# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "categoryDescription" = var.category_description
    "childCategoryIds"    = (var.child_category_ids == null ? null : [for item0 in var.child_category_ids : item0 if item0 != null])
    "description"         = var.description
    "displayName"         = var.display_name
    "helpText"            = var.help_text
    "name"                = var.name
    "@odata.type"         = var.odata_type
    "parentCategoryId"    = var.parent_category_id
    "platforms"           = var.platforms
    "rootCategoryId"      = var.root_category_id
    "settingUsage"        = var.setting_usage
    "technologies"        = var.technologies
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/complianceCategories"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
