# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedOnlineMeetingProviders" = (var.allowed_online_meeting_providers == null ? null : [for item0 in var.allowed_online_meeting_providers : item0 if item0 != null])
    "calendarGroupId"               = var.calendar_group_id_2
    "calendarPermissions"           = (var.calendar_permissions == null ? null : [for item0 in var.calendar_permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedRoles" = (item0["allowedRoles"] == null ? null : [for item2 in item0["allowedRoles"] : item2 if item2 != null]), "isInsideOrganization" = item0["isInsideOrganization"], "isRemovable" = item0["isRemovable"], "role" = item0["role"] } : key1 => value1 if value1 != null }) if item0 != null])
    "color"                         = var.color
    "defaultOnlineMeetingProvider"  = var.default_online_meeting_provider
    "hexColor"                      = var.hex_color
    "isDefaultCalendar"             = var.is_default_calendar
    "isRemovable"                   = var.is_removable
    "isTallyingResponses"           = var.is_tallying_responses
    "name"                          = var.name
    "@odata.type"                   = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/calendarGroups/${urlencode(var.calendar_group_id)}/calendars"
  api_version             = "beta"
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
