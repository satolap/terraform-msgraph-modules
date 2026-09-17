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

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/complianceCategories"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
