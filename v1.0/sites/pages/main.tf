# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"     = var.description
    "name"            = var.name
    "@odata.type"     = var.odata_type
    "pageLayout"      = var.pageLayout
    "parentReference" = (var.parentReference == null ? null : { for key0, value0 in { "@odata.type" = var.parentReference["odata_type"], "driveType" = var.parentReference["driveType"], "shareId" = var.parentReference["shareId"], "siteId" = var.parentReference["siteId"] } : key0 => value0 if value0 != null })
    "publishingState" = (var.publishingState == null ? null : { for key0, value0 in { "@odata.type" = var.publishingState["odata_type"], "checkedOutBy" = var.publishingState["checkedOutBy"] } : key0 => value0 if value0 != null })
    "title"           = var.title
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "sites/${urlencode(var.site-id)}/pages"
  api_version             = "v1.0"
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
