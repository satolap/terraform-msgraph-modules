# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "additionalInformation"     = (var.additional_information == null ? null : [for item0 in var.additional_information : item0 if item0 != null])
    "createdDateTime"           = var.created_date_time
    "description"               = var.description
    "displayName"               = var.display_name
    "domainNames"               = (var.domain_names == null ? null : [for item0 in var.domain_names : item0 if item0 != null])
    "healthIssueType"           = var.health_issue_type
    "issueTypeId"               = var.issue_type_id
    "lastModifiedDateTime"      = var.last_modified_date_time
    "@odata.type"               = var.odata_type
    "recommendations"           = (var.recommendations == null ? null : [for item0 in var.recommendations : item0 if item0 != null])
    "recommendedActionCommands" = (var.recommended_action_commands == null ? null : [for item0 in var.recommended_action_commands : item0 if item0 != null])
    "sensorDNSNames"            = (var.sensor_dns_names == null ? null : [for item0 in var.sensor_dns_names : item0 if item0 != null])
    "severity"                  = var.severity
    "status"                    = var.status
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/identities/healthIssues"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
