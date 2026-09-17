# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "category"           = var.category
    "contentType"        = var.content_type
    "createdBy"          = var.created_by
    "createdDateTime"    = var.created_date_time
    "expectedAssessment" = var.expected_assessment
    "@odata.type"        = var.odata_type
    "requestSource"      = var.request_source
    "status"             = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "informationProtection/threatAssessmentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
