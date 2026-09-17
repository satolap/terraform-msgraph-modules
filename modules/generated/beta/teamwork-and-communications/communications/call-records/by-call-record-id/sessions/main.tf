# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "callee"        = var.callee
    "caller"        = var.caller
    "endDateTime"   = var.end_date_time
    "failureInfo"   = var.failure_info
    "isTest"        = var.is_test
    "modalities"    = (var.modalities == null ? null : [for item0 in var.modalities : item0 if item0 != null])
    "@odata.type"   = var.odata_type
    "startDateTime" = var.start_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/callRecords/${urlencode(var.call_record_id)}/sessions"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
