# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appleDeviceAppDeliveryProtocolType"  = var.apple_device_app_delivery_protocol_type
    "appleId"                             = var.apple_id
    "automaticallyUpdateApps"             = var.automatically_update_apps
    "claimTokenManagementFromExternalMdm" = var.claim_token_management_from_external_mdm
    "countryOrRegion"                     = var.country_or_region
    "dataSharingConsentGranted"           = var.data_sharing_consent_granted
    "displayName"                         = var.display_name
    "expirationDateTime"                  = var.expiration_date_time
    "lastModifiedDateTime"                = var.last_modified_date_time
    "lastSyncDateTime"                    = var.last_sync_date_time
    "lastSyncStatus"                      = var.last_sync_status
    "locationName"                        = var.location_name
    "@odata.type"                         = var.odata_type
    "organizationName"                    = var.organization_name
    "roleScopeTagIds"                     = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "state"                               = var.state
    "token"                               = var.token
    "tokenActionResults"                  = (var.token_action_results == null ? null : [for item0 in var.token_action_results : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "actionName" = item0["actionName"], "actionState" = item0["actionState"], "lastUpdatedDateTime" = item0["lastUpdatedDateTime"], "startDateTime" = item0["startDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "vppTokenAccountType"                 = var.vpp_token_account_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/vppTokens"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
