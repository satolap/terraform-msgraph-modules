# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionType"            = var.action_type
    "actionUrl"             = var.action_url
    "azureTenantId"         = var.azure_tenant_id
    "complianceInformation" = (var.compliance_information == null ? null : [for item0 in var.compliance_information : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certificationControls" = (item0["certificationControls"] == null ? null : [for item2 in item0["certificationControls"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "name" = item2["name"], "url" = item2["url"] } : key3 => value3 if value3 != null }) if item2 != null]), "certificationName" = item0["certificationName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "controlCategory"       = var.control_category
    "controlStateUpdates"   = (var.control_state_updates == null ? null : [for item0 in var.control_state_updates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "assignedTo" = item0["assignedTo"], "comment" = item0["comment"], "state" = item0["state"], "updatedBy" = item0["updatedBy"], "updatedDateTime" = item0["updatedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deprecated"            = var.deprecated
    "implementationCost"    = var.implementation_cost
    "lastModifiedDateTime"  = var.last_modified_date_time
    "maxScore"              = var.max_score
    "@odata.type"           = var.odata_type
    "rank"                  = var.rank
    "remediation"           = var.remediation
    "remediationImpact"     = var.remediation_impact
    "service"               = var.service
    "threats"               = (var.threats == null ? null : [for item0 in var.threats : item0 if item0 != null])
    "tier"                  = var.tier
    "title"                 = var.title
    "userImpact"            = var.user_impact
    "vendorInformation"     = var.vendor_information
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/secureScoreControlProfiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
