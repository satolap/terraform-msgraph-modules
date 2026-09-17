# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "createdDateTime"                              = var.created_date_time
    "description"                                  = var.description
    "discoverySource"                              = var.discovery_source
    "enrollmentState"                              = var.enrollment_state
    "isDeleted"                                    = var.is_deleted
    "isSupervised"                                 = var.is_supervised
    "lastContactedDateTime"                        = var.last_contacted_date_time
    "@odata.type"                                  = var.odata_type
    "platform"                                     = var.platform
    "requestedEnrollmentProfileAssignmentDateTime" = var.requested_enrollment_profile_assignment_date_time
    "requestedEnrollmentProfileId"                 = var.requested_enrollment_profile_id
    "serialNumber"                                 = var.serial_number
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/depOnboardingSettings/${urlencode(var.dep_onboarding_setting_id)}/importedAppleDeviceIdentities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
