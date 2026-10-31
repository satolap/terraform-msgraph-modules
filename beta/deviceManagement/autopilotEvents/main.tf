# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountSetupDuration"                                      = var.accountSetupDuration
    "accountSetupStatus"                                        = var.accountSetupStatus
    "deploymentDuration"                                        = var.deploymentDuration
    "deploymentEndDateTime"                                     = var.deploymentEndDateTime
    "deploymentStartDateTime"                                   = var.deploymentStartDateTime
    "deploymentState"                                           = var.deploymentState
    "deploymentTotalDuration"                                   = var.deploymentTotalDuration
    "deviceId"                                                  = var.deviceId
    "deviceRegisteredDateTime"                                  = var.deviceRegisteredDateTime
    "deviceSerialNumber"                                        = var.deviceSerialNumber
    "deviceSetupDuration"                                       = var.deviceSetupDuration
    "deviceSetupStatus"                                         = var.deviceSetupStatus
    "enrollmentFailureDetails"                                  = var.enrollmentFailureDetails
    "enrollmentStartDateTime"                                   = var.enrollmentStartDateTime
    "enrollmentState"                                           = var.enrollmentState
    "enrollmentType"                                            = var.enrollmentType
    "eventDateTime"                                             = var.eventDateTime
    "managedDeviceName"                                         = var.managedDeviceName
    "@odata.type"                                               = var.odata_type
    "osVersion"                                                 = var.osVersion
    "userId"                                                    = var.userId
    "userPrincipalName"                                         = var.userPrincipalName
    "windows10EnrollmentCompletionPageConfigurationDisplayName" = var.windows10EnrollmentCompletionPageConfigurationDisplayName
    "windows10EnrollmentCompletionPageConfigurationId"          = var.windows10EnrollmentCompletionPageConfigurationId
    "windowsAutopilotDeploymentProfileDisplayName"              = var.windowsAutopilotDeploymentProfileDisplayName
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/autopilotEvents"
  api_version             = "beta"
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
