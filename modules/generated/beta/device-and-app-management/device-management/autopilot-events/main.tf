# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountSetupDuration"                                      = var.account_setup_duration
    "accountSetupStatus"                                        = var.account_setup_status
    "deploymentDuration"                                        = var.deployment_duration
    "deploymentEndDateTime"                                     = var.deployment_end_date_time
    "deploymentStartDateTime"                                   = var.deployment_start_date_time
    "deploymentState"                                           = var.deployment_state
    "deploymentTotalDuration"                                   = var.deployment_total_duration
    "deviceId"                                                  = var.device_id
    "deviceRegisteredDateTime"                                  = var.device_registered_date_time
    "deviceSerialNumber"                                        = var.device_serial_number
    "deviceSetupDuration"                                       = var.device_setup_duration
    "deviceSetupStatus"                                         = var.device_setup_status
    "enrollmentFailureDetails"                                  = var.enrollment_failure_details
    "enrollmentStartDateTime"                                   = var.enrollment_start_date_time
    "enrollmentState"                                           = var.enrollment_state
    "enrollmentType"                                            = var.enrollment_type
    "eventDateTime"                                             = var.event_date_time
    "managedDeviceName"                                         = var.managed_device_name
    "@odata.type"                                               = var.odata_type
    "osVersion"                                                 = var.os_version
    "userId"                                                    = var.user_id
    "userPrincipalName"                                         = var.user_principal_name
    "windows10EnrollmentCompletionPageConfigurationDisplayName" = var.windows10_enrollment_completion_page_configuration_display_name
    "windows10EnrollmentCompletionPageConfigurationId"          = var.windows10_enrollment_completion_page_configuration_id
    "windowsAutopilotDeploymentProfileDisplayName"              = var.windows_autopilot_deployment_profile_display_name
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/autopilotEvents"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
