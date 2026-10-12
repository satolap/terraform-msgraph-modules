# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "androidEnrollmentAssignments" = (var.android_enrollment_assignments == null ? null : [for item0 in var.android_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "androidOnboarded"             = var.android_onboarded
    "displayName"                  = var.display_name
    "iosEnrollmentAssignments"     = (var.ios_enrollment_assignments == null ? null : [for item0 in var.ios_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "iosOnboarded"                 = var.ios_onboarded
    "lastHeartbeatDateTime"        = var.last_heartbeat_date_time
    "linuxEnrollmentAssignments"   = (var.linux_enrollment_assignments == null ? null : [for item0 in var.linux_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "linuxOnboarded"               = var.linux_onboarded
    "macOsEnrollmentAssignments"   = (var.mac_os_enrollment_assignments == null ? null : [for item0 in var.mac_os_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "macOsOnboarded"               = var.mac_os_onboarded
    "@odata.type"                  = var.odata_type
    "partnerState"                 = var.partner_state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/complianceManagementPartners"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
