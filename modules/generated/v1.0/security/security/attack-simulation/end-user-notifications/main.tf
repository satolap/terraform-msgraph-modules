# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdBy"            = var.created_by
    "createdDateTime"      = var.created_date_time
    "description"          = var.description
    "details"              = (var.details == null ? null : [for item0 in var.details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "emailContent" = item0["emailContent"], "isDefaultLangauge" = item0["isDefaultLangauge"], "language" = item0["language"], "locale" = item0["locale"], "sentFrom" = (item0["sentFrom"] == null ? null : { for key2, value2 in { "@odata.type" = item0["sentFrom"]["odata_type"], "displayName" = item0["sentFrom"]["displayName"], "email" = item0["sentFrom"]["email"], "id" = item0["sentFrom"]["id"] } : key2 => value2 if value2 != null }), "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"          = var.display_name
    "source"               = var.graph_source
    "lastModifiedBy"       = var.last_modified_by
    "lastModifiedDateTime" = var.last_modified_date_time
    "notificationType"     = var.notification_type
    "@odata.type"          = var.odata_type
    "status"               = var.status
    "supportedLocales"     = (var.supported_locales == null ? null : [for item0 in var.supported_locales : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/attackSimulation/endUserNotifications"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
