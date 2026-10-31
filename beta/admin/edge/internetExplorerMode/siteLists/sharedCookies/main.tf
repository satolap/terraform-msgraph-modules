# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "comment"              = var.comment
    "createdDateTime"      = var.createdDateTime
    "deletedDateTime"      = var.deletedDateTime
    "displayName"          = var.displayName
    "history"              = (var.history == null ? null : [for item0 in var.history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "displayName" = item0["displayName"], "hostOnly" = item0["hostOnly"], "hostOrDomain" = item0["hostOrDomain"], "lastModifiedBy" = item0["lastModifiedBy"], "path" = item0["path"], "publishedDateTime" = item0["publishedDateTime"], "sourceEnvironment" = item0["sourceEnvironment"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hostOnly"             = var.hostOnly
    "hostOrDomain"         = var.hostOrDomain
    "lastModifiedBy"       = var.lastModifiedBy
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "path"                 = var.path
    "sourceEnvironment"    = var.sourceEnvironment
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "admin/edge/internetExplorerMode/siteLists/${urlencode(var.browserSiteList-id)}/sharedCookies"
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
