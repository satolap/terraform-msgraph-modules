# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "allowedInboundDataTransferSourceApps"       = var.allowed_inbound_data_transfer_source_apps
    "allowedInboundDataTransferSources"          = var.allowed_inbound_data_transfer_sources
    "allowedOutboundClipboardSharingLevel"       = var.allowed_outbound_clipboard_sharing_level
    "allowedOutboundDataTransferDestinationApps" = var.allowed_outbound_data_transfer_destination_apps
    "allowedOutboundDataTransferDestinations"    = var.allowed_outbound_data_transfer_destinations
    "appActionIfUnableToAuthenticateUser"        = var.app_action_if_unable_to_authenticate_user
    "apps"                                       = (var.apps == null ? null : [for item0 in var.apps : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "mobileAppIdentifier" = item0["mobileAppIdentifier"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "assignments"                                = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "source" = item0["source"], "sourceId" = item0["sourceId"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "createdDateTime"                            = var.created_date_time
    "deployedAppCount"                           = var.deployed_app_count
    "deploymentSummary"                          = var.deployment_summary
    "description"                                = var.description
    "displayName"                                = var.display_name
    "version"                                    = var.graph_version
    "isAssigned"                                 = var.is_assigned
    "lastModifiedDateTime"                       = var.last_modified_date_time
    "maximumAllowedDeviceThreatLevel"            = var.maximum_allowed_device_threat_level
    "maximumRequiredOsVersion"                   = var.maximum_required_os_version
    "maximumWarningOsVersion"                    = var.maximum_warning_os_version
    "maximumWipeOsVersion"                       = var.maximum_wipe_os_version
    "minimumRequiredAppVersion"                  = var.minimum_required_app_version
    "minimumRequiredOsVersion"                   = var.minimum_required_os_version
    "minimumRequiredSdkVersion"                  = var.minimum_required_sdk_version
    "minimumWarningAppVersion"                   = var.minimum_warning_app_version
    "minimumWarningOsVersion"                    = var.minimum_warning_os_version
    "minimumWipeAppVersion"                      = var.minimum_wipe_app_version
    "minimumWipeOsVersion"                       = var.minimum_wipe_os_version
    "minimumWipeSdkVersion"                      = var.minimum_wipe_sdk_version
    "mobileThreatDefenseRemediationAction"       = var.mobile_threat_defense_remediation_action
    "@odata.type"                                = var.odata_type
    "periodOfflineBeforeAccessCheck"             = var.period_offline_before_access_check
    "periodOfflineBeforeWipeIsEnforced"          = var.period_offline_before_wipe_is_enforced
    "printBlocked"                               = var.print_blocked
    "roleScopeTagIds"                            = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceAppManagement/windowsManagedAppProtections"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["apps", "assignments", "deploymentSummary"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
