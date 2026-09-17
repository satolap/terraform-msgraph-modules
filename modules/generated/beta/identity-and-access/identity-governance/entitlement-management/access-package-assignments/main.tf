# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accessPackageAssignmentRequests" = (var.access_package_assignment_requests == null ? null : [for item0 in var.access_package_assignment_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accessPackageAssignment" = item0["accessPackageAssignment"], "answers" = (item0["answers"] == null ? null : [for item2 in item0["answers"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "displayValue" = item2["displayValue"] } : key3 => value3 if value3 != null }) if item2 != null]), "customExtensionCalloutInstances" = (item0["customExtensionCalloutInstances"] == null ? null : [for item2 in item0["customExtensionCalloutInstances"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "customExtensionId" = item2["customExtensionId"], "detail" = item2["detail"], "externalCorrelationId" = item2["externalCorrelationId"], "status" = item2["status"] } : key3 => value3 if value3 != null }) if item2 != null]), "expirationDateTime" = item0["expirationDateTime"], "history" = (item0["history"] == null ? null : [for item2 in item0["history"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "action" = item2["action"], "actionDateTime" = item2["actionDateTime"], "detail" = item2["detail"], "scheduledDateTime" = item2["scheduledDateTime"], "userDisplayName" = item2["userDisplayName"], "userPrincipalName" = item2["userPrincipalName"] } : key3 => value3 if value3 != null }) if item2 != null]), "isValidationOnly" = item0["isValidationOnly"], "justification" = item0["justification"], "parameters" = item0["parameters"] } : key1 => value1 if value1 != null }) if item0 != null])
    "customExtensionCalloutInstances" = (var.custom_extension_callout_instances == null ? null : [for item0 in var.custom_extension_callout_instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "customExtensionId" = item0["customExtensionId"], "detail" = item0["detail"], "externalCorrelationId" = item0["externalCorrelationId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "expiredDateTime"                 = var.expired_date_time
    "@odata.type"                     = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/accessPackageAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
