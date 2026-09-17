# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "answers"                         = (var.answers == null ? null : [for item0 in var.answers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "answeredQuestion" = item0["answeredQuestion"], "displayValue" = item0["displayValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignment"                      = var.assignment
    "customExtensionCalloutInstances" = (var.custom_extension_callout_instances == null ? null : [for item0 in var.custom_extension_callout_instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtensionId" = item0["customExtensionId"], "detail" = item0["detail"], "externalCorrelationId" = item0["externalCorrelationId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "justification"                   = var.justification
    "@odata.type"                     = var.odata_type
    "parameters"                      = var.parameters
    "requestType"                     = var.request_type
    "schedule"                        = var.schedule
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/assignmentRequests"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
