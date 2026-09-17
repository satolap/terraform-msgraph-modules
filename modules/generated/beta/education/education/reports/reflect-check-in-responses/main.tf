# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "checkInId"        = var.check_in_id
    "checkInTitle"     = var.check_in_title
    "classId"          = var.class_id
    "createdDateTime"  = var.created_date_time
    "creatorId"        = var.creator_id
    "isClosed"         = var.is_closed
    "@odata.type"      = var.odata_type
    "responderId"      = var.responder_id
    "responseEmotion"  = var.response_emotion
    "responseFeedback" = var.response_feedback
    "submitDateTime"   = var.submit_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "education/reports/reflectCheckInResponses"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
