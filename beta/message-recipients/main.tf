# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deliveryStatus" = var.delivery_status
    "events"         = (var.events == null ? null : [for item0 in var.events : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "dateTime" = item0["dateTime"], "description" = item0["description"], "eventType" = item0["eventType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"    = var.odata_type
    "recipientEmail" = var.recipient_email
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "messageRecipients"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
