# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "cloudPcId"            = var.cloud_pc_id
    "createdDateTime"      = var.created_date_time
    "expirationDateTime"   = var.expiration_date_time
    "lastRestoredDateTime" = var.last_restored_date_time
    "@odata.type"          = var.odata_type
    "snapshotType"         = var.snapshot_type
    "status"               = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/virtualEndpoint/snapshots"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
