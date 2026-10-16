# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "source"      = var.graph_source
    "@odata.type" = var.odata_type
    "sourceId"    = var.source_id
    "target"      = var.target
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/windowsAutopilotDeploymentProfiles/${urlencode(var.windows_autopilot_deployment_profile_id)}/assignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
