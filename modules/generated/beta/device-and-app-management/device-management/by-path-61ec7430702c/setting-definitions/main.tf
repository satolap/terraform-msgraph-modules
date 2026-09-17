# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "constraints"      = (var.constraints == null ? null : [for item0 in var.constraints : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "dependencies"     = (var.dependencies == null ? null : [for item0 in var.dependencies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "constraints" = (item0["constraints"] == null ? null : [for item2 in item0["constraints"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"] } : key3 => value3 if value3 != null }) if item2 != null]), "definitionId" = item0["definitionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"      = var.description
    "displayName"      = var.display_name
    "documentationUrl" = var.documentation_url
    "headerSubtitle"   = var.header_subtitle
    "headerTitle"      = var.header_title
    "isTopLevel"       = var.is_top_level
    "keywords"         = (var.keywords == null ? null : [for item0 in var.keywords : item0 if item0 != null])
    "@odata.type"      = var.odata_type
    "placeholderText"  = var.placeholder_text
    "valueType"        = var.value_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templates/${urlencode(var.device_management_template_id)}/categories/${urlencode(var.device_management_template_setting_category_id)}/settingDefinitions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
