# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionStatus"   = var.action_status
    "actionType"     = var.action_type
    "description"    = var.description
    "displayName"    = var.display_name
    "source"         = var.graph_source
    "incident"       = var.incident
    "@odata.type"    = var.odata_type
    "responseAction" = var.response_action
    "status"         = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/incidentTasks"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
