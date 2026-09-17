# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "emailContent"      = var.email_content
    "isDefaultLangauge" = var.is_default_langauge
    "language"          = var.language
    "locale"            = var.locale
    "@odata.type"       = var.odata_type
    "sentFrom"          = var.sent_from
    "subject"           = var.subject
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/endUserNotifications/${urlencode(var.end_user_notification_id)}/details"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
