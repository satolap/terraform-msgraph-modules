# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "comment"              = var.comment
    "createdDateTime"      = var.created_date_time
    "deletedDateTime"      = var.deleted_date_time
    "displayName"          = var.display_name
    "history"              = (var.history == null ? null : [for item0 in var.history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "comment" = item0["comment"], "displayName" = item0["displayName"], "hostOnly" = item0["hostOnly"], "hostOrDomain" = item0["hostOrDomain"], "lastModifiedBy" = (item0["lastModifiedBy"] == null ? null : { for key2, value2 in { "@odata.type" = item0["lastModifiedBy"]["odata_type"], "application" = item0["lastModifiedBy"]["application"], "device" = item0["lastModifiedBy"]["device"], "user" = item0["lastModifiedBy"]["user"] } : key2 => value2 if value2 != null }), "path" = item0["path"], "publishedDateTime" = item0["publishedDateTime"], "sourceEnvironment" = item0["sourceEnvironment"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hostOnly"             = var.host_only
    "hostOrDomain"         = var.host_or_domain
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "path"                 = var.path
    "sourceEnvironment"    = var.source_environment
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/edge/internetExplorerMode/siteLists/${urlencode(var.browser_site_list_id)}/sharedCookies"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
