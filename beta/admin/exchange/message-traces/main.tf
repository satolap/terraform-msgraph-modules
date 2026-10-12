# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "destinationIPAddress" = var.destination_ip_address
    "messageId"            = var.message_id
    "@odata.type"          = var.odata_type
    "receivedDateTime"     = var.received_date_time
    "recipients"           = (var.recipients == null ? null : [for item0 in var.recipients : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deliveryStatus" = item0["deliveryStatus"], "events" = (item0["events"] == null ? null : [for item2 in item0["events"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "dateTime" = item2["dateTime"], "description" = item2["description"], "eventType" = item2["eventType"] } : key3 => value3 if value3 != null }) if item2 != null]), "recipientEmail" = item0["recipientEmail"] } : key1 => value1 if value1 != null }) if item0 != null])
    "senderEmail"          = var.sender_email
    "size"                 = var.size
    "sourceIPAddress"      = var.source_ip_address
    "subject"              = var.subject
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/exchange/messageTraces"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
