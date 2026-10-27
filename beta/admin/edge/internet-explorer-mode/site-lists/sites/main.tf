# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowRedirect"        = var.allow_redirect
    "comment"              = var.comment
    "compatibilityMode"    = var.compatibility_mode
    "createdDateTime"      = var.created_date_time
    "deletedDateTime"      = var.deleted_date_time
    "history"              = (var.history == null ? null : [for item0 in var.history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowRedirect" = item0["allowRedirect"], "comment" = item0["comment"], "compatibilityMode" = item0["compatibilityMode"], "lastModifiedBy" = item0["lastModifiedBy"], "mergeType" = item0["mergeType"], "publishedDateTime" = item0["publishedDateTime"], "targetEnvironment" = item0["targetEnvironment"] } : key1 => value1 if value1 != null }) if item0 != null])
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "mergeType"            = var.merge_type
    "@odata.type"          = var.odata_type
    "status"               = var.status
    "targetEnvironment"    = var.target_environment
    "webUrl"               = var.web_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "admin/edge/internetExplorerMode/siteLists/${urlencode(var.browser_site_list_id)}/sites"
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
