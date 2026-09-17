# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedOnlineMeetingProviders" = (var.allowed_online_meeting_providers == null ? null : [for item0 in var.allowed_online_meeting_providers : item0 if item0 != null])
    "calendarPermissions"           = (var.calendar_permissions == null ? null : [for item0 in var.calendar_permissions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allowedRoles" = (item0["allowedRoles"] == null ? null : [for item2 in item0["allowedRoles"] : item2 if item2 != null]), "isInsideOrganization" = item0["isInsideOrganization"], "isRemovable" = item0["isRemovable"], "role" = item0["role"] } : key1 => value1 if value1 != null }) if item0 != null])
    "canEdit"                       = var.can_edit
    "canShare"                      = var.can_share
    "canViewPrivateItems"           = var.can_view_private_items
    "color"                         = var.color
    "defaultOnlineMeetingProvider"  = var.default_online_meeting_provider
    "isDefaultCalendar"             = var.is_default_calendar
    "isRemovable"                   = var.is_removable
    "isTallyingResponses"           = var.is_tallying_responses
    "name"                          = var.name
    "@odata.type"                   = var.odata_type
    "owner"                         = var.owner
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/calendars"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
