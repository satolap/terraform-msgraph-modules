# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"       = var.created_date_time
    "deploymentStatus"      = var.deployment_status
    "displayName"           = var.display_name
    "domainName"            = var.domain_name
    "version"               = var.graph_version
    "healthIssues"          = (var.health_issues == null ? null : [for item0 in var.health_issues : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "additionalInformation" = (item0["additionalInformation"] == null ? null : [for item2 in item0["additionalInformation"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "displayName" = item0["displayName"], "domainNames" = (item0["domainNames"] == null ? null : [for item2 in item0["domainNames"] : item2 if item2 != null]), "healthIssueType" = item0["healthIssueType"], "issueTypeId" = item0["issueTypeId"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "recommendations" = (item0["recommendations"] == null ? null : [for item2 in item0["recommendations"] : item2 if item2 != null]), "recommendedActionCommands" = (item0["recommendedActionCommands"] == null ? null : [for item2 in item0["recommendedActionCommands"] : item2 if item2 != null]), "sensorDNSNames" = (item0["sensorDNSNames"] == null ? null : [for item2 in item0["sensorDNSNames"] : item2 if item2 != null]), "severity" = item0["severity"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "healthStatus"          = var.health_status
    "migrationState"        = var.migration_state
    "@odata.type"           = var.odata_type
    "openHealthIssuesCount" = var.open_health_issues_count
    "sensorType"            = var.sensor_type
    "serviceStatus"         = var.service_status
    "settings"              = (var.settings == null ? null : { for key0, value0 in { "@odata.type" = var.settings["odata_type"], "description" = var.settings["description"], "domainControllerDnsNames" = (var.settings["domainControllerDnsNames"] == null ? null : [for item1 in var.settings["domainControllerDnsNames"] : item1 if item1 != null]), "isDelayedDeploymentEnabled" = var.settings["isDelayedDeploymentEnabled"], "networkAdapters" = (var.settings["networkAdapters"] == null ? null : [for item1 in var.settings["networkAdapters"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "isEnabled" = item1["isEnabled"], "name" = item1["name"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/identities/sensors"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
