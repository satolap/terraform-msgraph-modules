# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "connectorVersion"       = var.connector_version
    "displayName"            = var.display_name
    "enrolledDateTime"       = var.enrolled_date_time
    "lastConnectionDateTime" = var.last_connection_date_time
    "machineName"            = var.machine_name
    "@odata.type"            = var.odata_type
    "roleScopeTagIds"        = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "state"                  = var.state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/ndesConnectors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
