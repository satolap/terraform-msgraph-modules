# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageAssignment"         = var.access_package_assignment
    "answers"                         = (var.answers == null ? null : [for item0 in var.answers : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayValue" = item0["displayValue"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customExtensionCalloutInstances" = (var.custom_extension_callout_instances == null ? null : [for item0 in var.custom_extension_callout_instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtensionId" = item0["customExtensionId"], "detail" = item0["detail"], "externalCorrelationId" = item0["externalCorrelationId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "expirationDateTime"              = var.expiration_date_time
    "history"                         = (var.history == null ? null : [for item0 in var.history : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "action" = item0["action"], "actionDateTime" = item0["actionDateTime"], "detail" = item0["detail"], "scheduledDateTime" = item0["scheduledDateTime"], "userDisplayName" = item0["userDisplayName"], "userPrincipalName" = item0["userPrincipalName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "isValidationOnly"                = var.is_validation_only
    "justification"                   = var.justification
    "@odata.type"                     = var.odata_type
    "parameters"                      = var.parameters
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageAssignments/${urlencode(var.access_package_assignment_id)}/accessPackageAssignmentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
