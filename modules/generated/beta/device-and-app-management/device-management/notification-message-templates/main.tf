# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "brandingOptions"               = var.branding_options
    "defaultLocale"                 = var.default_locale
    "description"                   = var.description
    "displayName"                   = var.display_name
    "lastModifiedDateTime"          = var.last_modified_date_time
    "localizedNotificationMessages" = (var.localized_notification_messages == null ? null : [for item0 in var.localized_notification_messages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefault" = item0["isDefault"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "locale" = item0["locale"], "messageTemplate" = item0["messageTemplate"], "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "roleScopeTagIds"               = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/notificationMessageTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
