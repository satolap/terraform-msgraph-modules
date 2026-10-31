# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "constraints"      = (var.constraints == null ? null : [for item0 in var.constraints : item0 if item0 != null])
    "dependencies"     = (var.dependencies == null ? null : [for item0 in var.dependencies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "constraints" = (item0["constraints"] == null ? null : [for item2 in item0["constraints"] : item2 if item2 != null]), "definitionId" = item0["definitionId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"      = var.description
    "displayName"      = var.displayName
    "documentationUrl" = var.documentationUrl
    "headerSubtitle"   = var.headerSubtitle
    "headerTitle"      = var.headerTitle
    "isTopLevel"       = var.isTopLevel
    "keywords"         = (var.keywords == null ? null : [for item0 in var.keywords : item0 if item0 != null])
    "@odata.type"      = var.odata_type
    "placeholderText"  = var.placeholderText
    "valueType"        = var.valueType
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/templates/${urlencode(var.deviceManagementTemplate-id)}/categories/${urlencode(var.deviceManagementTemplateSettingCategory-id)}/settingDefinitions"
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
