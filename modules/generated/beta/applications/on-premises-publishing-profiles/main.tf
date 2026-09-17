# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "applicationSegments"             = (var.application_segments == null ? null : [for item0 in var.application_segments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"], "application" = item0["application"], "destinationHost" = item0["destinationHost"], "destinationType" = item0["destinationType"], "port" = item0["port"], "ports" = (item0["ports"] == null ? null : [for item2 in item0["ports"] : item2 if item2 != null]), "protocol" = item0["protocol"] } : key1 => value1 if value1 != null }) if item0 != null])
    "hybridAgentUpdaterConfiguration" = var.hybrid_agent_updater_configuration
    "isDefaultAccessEnabled"          = var.is_default_access_enabled
    "isEnabled"                       = var.is_enabled
    "@odata.type"                     = var.odata_type
    "sensors"                         = (var.sensors == null ? null : [for item0 in var.sensors : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "externalIp" = item0["externalIp"], "isAuditMode" = item0["isAuditMode"], "isBreakglassEnabled" = item0["isBreakglassEnabled"], "machineName" = item0["machineName"], "status" = item0["status"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "onPremisesPublishingProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
