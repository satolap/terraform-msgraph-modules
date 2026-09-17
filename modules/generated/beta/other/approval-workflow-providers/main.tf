# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "businessFlows"                               = (var.business_flows == null ? null : [for item0 in var.business_flows : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customData" = item0["customData"], "deDuplicationId" = item0["deDuplicationId"], "description" = item0["description"], "displayName" = item0["displayName"], "policy" = item0["policy"], "policyTemplateId" = item0["policyTemplateId"], "recordVersion" = item0["recordVersion"], "schemaId" = item0["schemaId"], "settings" = item0["settings"] } : key1 => value1 if value1 != null }) if item0 != null])
    "businessFlowsWithRequestsAwaitingMyDecision" = (var.business_flows_with_requests_awaiting_my_decision == null ? null : [for item0 in var.business_flows_with_requests_awaiting_my_decision : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customData" = item0["customData"], "deDuplicationId" = item0["deDuplicationId"], "description" = item0["description"], "displayName" = item0["displayName"], "policy" = item0["policy"], "policyTemplateId" = item0["policyTemplateId"], "recordVersion" = item0["recordVersion"], "schemaId" = item0["schemaId"], "settings" = item0["settings"] } : key1 => value1 if value1 != null }) if item0 != null])
    "displayName"                                 = var.display_name
    "@odata.type"                                 = var.odata_type
    "policyTemplates"                             = (var.policy_templates == null ? null : [for item0 in var.policy_templates : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "policy" = item0["policy"], "settings" = item0["settings"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "approvalWorkflowProviders"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
