# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "classifyAs"         = var.classify_as
    "@odata.type"        = var.odata_type
    "senderEmailAddress" = (var.sender_email_address == null ? null : { for key0, value0 in { "@odata.type" = var.sender_email_address["odata_type"], "address" = var.sender_email_address["address"], "name" = var.sender_email_address["name"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/inferenceClassification/overrides"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
