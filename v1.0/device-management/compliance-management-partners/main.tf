# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "androidEnrollmentAssignments" = (var.android_enrollment_assignments == null ? null : [for item0 in var.android_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "androidOnboarded"             = var.android_onboarded
    "displayName"                  = var.display_name
    "iosEnrollmentAssignments"     = (var.ios_enrollment_assignments == null ? null : [for item0 in var.ios_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "iosOnboarded"                 = var.ios_onboarded
    "lastHeartbeatDateTime"        = var.last_heartbeat_date_time
    "macOsEnrollmentAssignments"   = (var.mac_os_enrollment_assignments == null ? null : [for item0 in var.mac_os_enrollment_assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "target" = item0["target"] } : key1 => value1 if value1 != null }) if item0 != null])
    "macOsOnboarded"               = var.mac_os_onboarded
    "@odata.type"                  = var.odata_type
    "partnerState"                 = var.partner_state
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/complianceManagementPartners"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
