# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "creationDateTime" = var.creation_date_time
    "endDateTime"      = var.end_date_time
    "error"            = var.error
    "@odata.type"      = var.odata_type
    "startDateTime"    = var.start_date_time
    "status"           = var.status
    "tenantId"         = var.tenant_id
    "type"             = var.type
    "userId"           = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "dataClassification/classifyTextJobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
