# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"           = var.odata_type
    "assignments"           = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "intent" = item0["intent"], "settings" = item0["settings"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"           = var.description
    "developer"             = var.developer
    "displayName"           = var.display_name
    "informationUrl"        = var.information_url
    "isFeatured"            = var.is_featured
    "largeIcon"             = (var.large_icon == null ? null : { for key0, value0 in { "@odata.type" = var.large_icon["odata_type"], "type" = var.large_icon["type"], "value" = var.large_icon["value"] } : key0 => value0 if value0 != null })
    "notes"                 = var.notes
    "owner"                 = var.owner
    "privacyInformationUrl" = var.privacy_information_url
    "publisher"             = var.publisher
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/mobileApps"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["assignments", "categories"], name)])]))))] } : null

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
