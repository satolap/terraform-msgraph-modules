# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedOnlineMeetingProviders" = (var.allowedOnlineMeetingProviders == null ? null : [for item0 in var.allowedOnlineMeetingProviders : item0 if item0 != null])
    "calendarPermissions"           = (var.calendarPermissions == null ? null : [for item0 in var.calendarPermissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedRoles" = (item0["allowedRoles"] == null ? null : [for item2 in item0["allowedRoles"] : item2 if item2 != null]), "isInsideOrganization" = item0["isInsideOrganization"], "isRemovable" = item0["isRemovable"], "role" = item0["role"] } : key1 => value1 if value1 != null }) if item0 != null])
    "canEdit"                       = var.canEdit
    "canShare"                      = var.canShare
    "canViewPrivateItems"           = var.canViewPrivateItems
    "color"                         = var.color
    "defaultOnlineMeetingProvider"  = var.defaultOnlineMeetingProvider
    "isDefaultCalendar"             = var.isDefaultCalendar
    "isRemovable"                   = var.isRemovable
    "isTallyingResponses"           = var.isTallyingResponses
    "name"                          = var.name
    "@odata.type"                   = var.odata_type
    "owner"                         = (var.owner == null ? null : { for key0, value0 in { "@odata.type" = var.owner["odata_type"], "address" = var.owner["address"], "name" = var.owner["name"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "me/calendars"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["calendarPermissions"], name)])]))))] } : null

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
