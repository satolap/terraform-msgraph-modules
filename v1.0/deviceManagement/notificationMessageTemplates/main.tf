# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "brandingOptions"               = var.brandingOptions
    "defaultLocale"                 = var.defaultLocale
    "displayName"                   = var.displayName
    "lastModifiedDateTime"          = var.lastModifiedDateTime
    "localizedNotificationMessages" = (var.localizedNotificationMessages == null ? null : [for item0 in var.localizedNotificationMessages : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isDefault" = item0["isDefault"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "locale" = item0["locale"], "messageTemplate" = item0["messageTemplate"], "subject" = item0["subject"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"                   = var.odata_type
    "roleScopeTagIds"               = (var.roleScopeTagIds == null ? null : [for item0 in var.roleScopeTagIds : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/notificationMessageTemplates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["localizedNotificationMessages"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
