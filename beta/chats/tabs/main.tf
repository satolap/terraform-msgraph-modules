# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "configuration"  = (var.configuration == null ? null : { for key0, value0 in { "@odata.type" = var.configuration["odata_type"], "contentUrl" = var.configuration["contentUrl"], "entityId" = var.configuration["entityId"], "removeUrl" = var.configuration["removeUrl"], "websiteUrl" = var.configuration["websiteUrl"] } : key0 => value0 if value0 != null })
    "displayName"    = var.displayName
    "messageId"      = var.messageId
    "@odata.type"    = var.odata_type
    "sortOrderIndex" = var.sortOrderIndex
    "teamsApp"       = var.teamsApp
    "teamsAppId"     = var.teamsAppId
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "chats/${urlencode(var.chat-id)}/tabs"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["teamsApp"], name)])]))))] } : null

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
