# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "bulkUpload"                 = var.bulk_upload
    "@odata.type"                = var.odata_type
    "schema"                     = var.schema
    "status"                     = var.status
    "synchronizationJobSettings" = (var.synchronization_job_settings == null ? null : [for item0 in var.synchronization_job_settings : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "templateId"                 = var.template_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "servicePrincipals/${urlencode(var.service_principal_id)}/synchronization/jobs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
