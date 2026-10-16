# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "emailContent"      = var.email_content
    "isDefaultLangauge" = var.is_default_langauge
    "language"          = var.language
    "locale"            = var.locale
    "@odata.type"       = var.odata_type
    "sentFrom"          = (var.sent_from == null ? null : { for key0, value0 in { "@odata.type" = var.sent_from["odata_type"], "displayName" = var.sent_from["displayName"], "email" = var.sent_from["email"], "id" = var.sent_from["id"] } : key0 => value0 if value0 != null })
    "subject"           = var.subject
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/endUserNotifications/${urlencode(var.end_user_notification_id)}/details"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
