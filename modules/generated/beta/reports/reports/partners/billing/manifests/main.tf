# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "blobCount"       = var.blob_count
    "blobs"           = (var.blobs == null ? null : [for item0 in var.blobs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "partitionValue" = item0["partitionValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime" = var.created_date_time
    "dataFormat"      = var.data_format
    "eTag"            = var.e_tag
    "@odata.type"     = var.odata_type
    "partitionType"   = var.partition_type
    "partnerTenantId" = var.partner_tenant_id
    "rootDirectory"   = var.root_directory
    "sasToken"        = var.sas_token
    "schemaVersion"   = var.schema_version
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "reports/partners/billing/manifests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
