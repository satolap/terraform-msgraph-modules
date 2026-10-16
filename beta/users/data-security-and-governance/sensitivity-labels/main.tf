# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionSource"                = var.action_source
    "applicableTo"                = var.applicable_to
    "applicationMode"             = var.application_mode
    "autoTooltip"                 = var.auto_tooltip
    "color"                       = var.color
    "description"                 = var.description
    "displayName"                 = var.display_name
    "hasProtection"               = var.has_protection
    "isDefault"                   = var.is_default
    "isEnabled"                   = var.is_enabled
    "isEndpointProtectionEnabled" = var.is_endpoint_protection_enabled
    "isScopedToUser"              = var.is_scoped_to_user
    "locale"                      = var.locale
    "name"                        = var.name
    "@odata.type"                 = var.odata_type
    "priority"                    = var.priority
    "rights"                      = var.rights
    "sublabels"                   = (var.sublabels == null ? null : [for item0 in var.sublabels : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionSource" = item0["actionSource"], "applicableTo" = item0["applicableTo"], "applicationMode" = item0["applicationMode"], "autoTooltip" = item0["autoTooltip"], "color" = item0["color"], "description" = item0["description"], "displayName" = item0["displayName"], "hasProtection" = item0["hasProtection"], "isDefault" = item0["isDefault"], "isEnabled" = item0["isEnabled"], "isEndpointProtectionEnabled" = item0["isEndpointProtectionEnabled"], "isScopedToUser" = item0["isScopedToUser"], "locale" = item0["locale"], "name" = item0["name"], "priority" = item0["priority"], "rights" = item0["rights"], "sublabels" = (item0["sublabels"] == null ? null : [for item2 in item0["sublabels"] : item2 if item2 != null]), "toolTip" = item0["toolTip"] } : key1 => value1 if value1 != null }) if item0 != null])
    "toolTip"                     = var.tool_tip
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/dataSecurityAndGovernance/sensitivityLabels"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
