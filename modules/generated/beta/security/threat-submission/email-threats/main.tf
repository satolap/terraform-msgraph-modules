# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "adminReview"                  = var.admin_review
    "attackSimulationInfo"         = var.attack_simulation_info
    "category"                     = var.category
    "clientSource"                 = var.client_source
    "contentType"                  = var.content_type
    "createdBy"                    = var.created_by
    "createdDateTime"              = var.created_date_time
    "source"                       = var.graph_source
    "internetMessageId"            = var.internet_message_id
    "@odata.type"                  = var.odata_type
    "originalCategory"             = var.original_category
    "receivedDateTime"             = var.received_date_time
    "recipientEmailAddress"        = var.recipient_email_address
    "result"                       = var.result
    "sender"                       = var.sender
    "senderIP"                     = var.sender_ip
    "status"                       = var.status
    "subject"                      = var.subject
    "tenantAllowOrBlockListAction" = var.tenant_allow_or_block_list_action
    "tenantId"                     = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "threatSubmission/emailThreats"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
