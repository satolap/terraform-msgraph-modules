# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"  = var.odata_type
    "data"         = var.data
    "files"        = (var.files == null ? null : [for item0 in var.files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isUploadDone" = var.isUploadDone
    "referenceId"  = var.referenceId
    "stats"        = (var.stats == null ? null : { for key0, value0 in { "@odata.type" = var.stats["odata_type"], "filesUploaded" = var.stats["filesUploaded"], "totalBytesUploaded" = var.stats["totalBytesUploaded"] } : key0 => value0 if value0 != null })
    "status"       = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/catalogs/${urlencode(var.accessPackageCatalog-id)}/accessPackageResources/${urlencode(var.accessPackageResource-id)}/uploadSessions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["files"], name)])]))))] } : null

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
