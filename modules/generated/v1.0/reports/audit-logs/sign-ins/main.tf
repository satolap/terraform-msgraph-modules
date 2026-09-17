# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDisplayName"                   = var.app_display_name
    "appId"                            = var.app_id
    "appliedConditionalAccessPolicies" = (var.applied_conditional_access_policies == null ? null : [for item0 in var.applied_conditional_access_policies : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"], "enforcedGrantControls" = (item0["enforcedGrantControls"] == null ? null : [for item2 in item0["enforcedGrantControls"] : item2 if item2 != null]), "enforcedSessionControls" = (item0["enforcedSessionControls"] == null ? null : [for item2 in item0["enforcedSessionControls"] : item2 if item2 != null]), "id" = item0["id"], "result" = item0["result"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationAppDeviceDetails"   = var.authentication_app_device_details
    "clientAppUsed"                    = var.client_app_used
    "conditionalAccessStatus"          = var.conditional_access_status
    "correlationId"                    = var.correlation_id
    "createdDateTime"                  = var.created_date_time
    "deviceDetail"                     = var.device_detail
    "homeTenantId"                     = var.home_tenant_id
    "ipAddress"                        = var.ip_address
    "isInteractive"                    = var.is_interactive
    "location"                         = var.location
    "@odata.type"                      = var.odata_type
    "resourceDisplayName"              = var.resource_display_name
    "resourceId"                       = var.resource_id
    "resourceTenantId"                 = var.resource_tenant_id
    "riskDetail"                       = var.risk_detail
    "riskEventTypes"                   = (var.risk_event_types == null ? null : [for item0 in var.risk_event_types : item0 if item0 != null])
    "riskEventTypes_v2"                = (var.risk_event_types_v2 == null ? null : [for item0 in var.risk_event_types_v2 : item0 if item0 != null])
    "riskLevelAggregated"              = var.risk_level_aggregated
    "riskLevelDuringSignIn"            = var.risk_level_during_sign_in
    "riskState"                        = var.risk_state
    "servicePrincipalId"               = var.service_principal_id
    "servicePrincipalName"             = var.service_principal_name
    "status"                           = var.status
    "userAgent"                        = var.user_agent
    "userDisplayName"                  = var.user_display_name
    "userId"                           = var.user_id
    "userPrincipalName"                = var.user_principal_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "auditLogs/signIns"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
