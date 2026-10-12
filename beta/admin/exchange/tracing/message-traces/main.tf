# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "fromIP"           = var.from_ip
    "messageId"        = var.message_id
    "@odata.type"      = var.odata_type
    "receivedDateTime" = var.received_date_time
    "recipientAddress" = var.recipient_address
    "senderAddress"    = var.sender_address
    "size"             = var.size
    "status"           = var.status
    "subject"          = var.subject
    "toIP"             = var.to_ip
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/exchange/tracing/messageTraces"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
