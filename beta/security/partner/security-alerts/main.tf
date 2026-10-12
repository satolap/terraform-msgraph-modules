# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activityLogs"               = (var.activity_logs == null ? null : [for item0 in var.activity_logs : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "statusFrom" = item0["statusFrom"], "statusTo" = item0["statusTo"], "updatedBy" = item0["updatedBy"], "updatedDateTime" = item0["updatedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "additionalDetails"          = var.additional_details
    "affectedResources"          = (var.affected_resources == null ? null : [for item0 in var.affected_resources : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceId" = item0["resourceId"], "resourceType" = item0["resourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "alertType"                  = var.alert_type
    "catalogOfferId"             = var.catalog_offer_id
    "confidenceLevel"            = var.confidence_level
    "customerTenantId"           = var.customer_tenant_id
    "description"                = var.description
    "detectedDateTime"           = var.detected_date_time
    "displayName"                = var.display_name
    "firstObservedDateTime"      = var.first_observed_date_time
    "isTest"                     = var.is_test
    "lastObservedDateTime"       = var.last_observed_date_time
    "@odata.type"                = var.odata_type
    "resolvedBy"                 = var.resolved_by
    "resolvedOnDateTime"         = var.resolved_on_date_time
    "resolvedReason"             = var.resolved_reason
    "severity"                   = var.severity
    "status"                     = var.status
    "subscriptionId"             = var.subscription_id
    "valueAddedResellerTenantId" = var.value_added_reseller_tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/partner/securityAlerts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
