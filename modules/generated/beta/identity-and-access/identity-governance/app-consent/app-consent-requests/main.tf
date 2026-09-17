# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDisplayName"      = var.app_display_name
    "appId"               = var.app_id
    "consentType"         = var.consent_type
    "@odata.type"         = var.odata_type
    "pendingScopes"       = (var.pending_scopes == null ? null : [for item0 in var.pending_scopes : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "displayName" = item0["displayName"] } : key1 => value1 if value1 != null }) if item0 != null])
    "userConsentRequests" = (var.user_consent_requests == null ? null : [for item0 in var.user_consent_requests : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "approval" = item0["approval"], "approvalId" = item0["approvalId"], "completedDateTime" = item0["completedDateTime"], "createdBy" = item0["createdBy"], "createdDateTime" = item0["createdDateTime"], "customData" = item0["customData"], "reason" = item0["reason"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/appConsent/appConsentRequests"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
