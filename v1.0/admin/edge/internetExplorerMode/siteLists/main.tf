# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"          = var.description
    "displayName"          = var.displayName
    "lastModifiedBy"       = var.lastModifiedBy
    "lastModifiedDateTime" = var.lastModifiedDateTime
    "@odata.type"          = var.odata_type
    "publishedBy"          = var.publishedBy
    "publishedDateTime"    = var.publishedDateTime
    "revision"             = var.revision
    "sharedCookies"        = (var.sharedCookies == null ? null : [for item0 in var.sharedCookies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "createdDateTime" = item0["createdDateTime"], "deletedDateTime" = item0["deletedDateTime"], "displayName" = item0["displayName"], "history" = (item0["history"] == null ? null : [for item2 in item0["history"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "comment" = item2["comment"], "displayName" = item2["displayName"], "hostOnly" = item2["hostOnly"], "hostOrDomain" = item2["hostOrDomain"], "lastModifiedBy" = item2["lastModifiedBy"], "path" = item2["path"], "publishedDateTime" = item2["publishedDateTime"], "sourceEnvironment" = item2["sourceEnvironment"] } : key3 => value3 if value3 != null }) if item2 != null]), "hostOnly" = item0["hostOnly"], "hostOrDomain" = item0["hostOrDomain"], "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "path" = item0["path"], "sourceEnvironment" = item0["sourceEnvironment"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "sites"                = (var.sites == null ? null : [for item0 in var.sites : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowRedirect" = item0["allowRedirect"], "comment" = item0["comment"], "compatibilityMode" = item0["compatibilityMode"], "createdDateTime" = item0["createdDateTime"], "deletedDateTime" = item0["deletedDateTime"], "history" = (item0["history"] == null ? null : [for item2 in item0["history"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "allowRedirect" = item2["allowRedirect"], "comment" = item2["comment"], "compatibilityMode" = item2["compatibilityMode"], "lastModifiedBy" = item2["lastModifiedBy"], "mergeType" = item2["mergeType"], "publishedDateTime" = item2["publishedDateTime"], "targetEnvironment" = item2["targetEnvironment"] } : key3 => value3 if value3 != null }) if item2 != null]), "lastModifiedBy" = item0["lastModifiedBy"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "mergeType" = item0["mergeType"], "status" = item0["status"], "targetEnvironment" = item0["targetEnvironment"], "webUrl" = item0["webUrl"] } : key1 => value1 if value1 != null }) if item0 != null])
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "admin/edge/internetExplorerMode/siteLists"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["sharedCookies", "sites"], name)])]))))] } : null

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
