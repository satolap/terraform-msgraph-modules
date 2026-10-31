# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"          = var.odata_type
    "assignments"          = (var.assignments == null ? null : [for item0 in var.assignments : item0 if item0 != null])
    "cloudPcConfiguration" = (var.cloudPcConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.cloudPcConfiguration["odata_type"], "imageId" = var.cloudPcConfiguration["imageId"], "imageType" = var.cloudPcConfiguration["imageType"], "osLocale" = var.cloudPcConfiguration["osLocale"] } : key0 => value0 if value0 != null })
    "description"          = var.description
    "displayName"          = var.displayName
    "networkConfiguration" = var.networkConfiguration
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/cloudPcPools"
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
