# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "displayName"          = var.display_name
    "error"                = var.error
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "@odata.type"          = var.odata_type
    "siteIds"              = (var.site_ids == null ? null : [for item0 in var.site_ids : item0 if item0 != null])
    "siteWebUrls"          = (var.site_web_urls == null ? null : [for item0 in var.site_web_urls : item0 if item0 != null])
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "solutions/backupRestore/siteProtectionUnitsBulkAdditionJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
