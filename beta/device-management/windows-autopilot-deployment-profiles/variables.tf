variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.activeDirectoryWindowsAutopilotDeploymentProfile", "#microsoft.graph.azureADWindowsAutopilotDeploymentProfile"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "assigned_devices" {
  description = "The list of assigned devices for the profile."
  type = list(object({
    odata_type                                = optional(string, "#microsoft.graph.windowsAutopilotDeviceIdentity")
    addressableUserName                       = optional(string)
    azureActiveDirectoryDeviceId              = optional(string)
    azureAdDeviceId                           = optional(string)
    deploymentProfile                         = optional(any)
    deploymentProfileAssignedDateTime         = optional(string)
    deploymentProfileAssignmentDetailedStatus = optional(string)
    deploymentProfileAssignmentStatus         = optional(string)
    deviceAccountPassword                     = optional(string)
    deviceAccountUpn                          = optional(string)
    deviceFriendlyName                        = optional(string)
    displayName                               = optional(string)
    enrollmentState                           = optional(string)
    groupTag                                  = optional(string)
    intendedDeploymentProfile                 = optional(any)
    lastContactedDateTime                     = optional(string)
    managedDeviceId                           = optional(string)
    manufacturer                              = optional(string)
    model                                     = optional(string)
    productKey                                = optional(string)
    purchaseOrderIdentifier                   = optional(string)
    remediationState                          = optional(string)
    remediationStateLastModifiedDateTime      = optional(string)
    resourceName                              = optional(string)
    serialNumber                              = optional(string)
    skuNumber                                 = optional(string)
    systemFamily                              = optional(string)
    userPrincipalName                         = optional(string)
    userlessEnrollmentStatus                  = optional(string)
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.assigned_devices == null ? true : alltrue([alltrue([for input0 in var.assigned_devices : (input0 == null ? true : alltrue([(input0["deploymentProfileAssignmentDetailedStatus"] == null ? true : alltrue([(input0["deploymentProfileAssignmentDetailedStatus"] == null ? true : contains(["none", "hardwareRequirementsNotMet", "surfaceHubProfileNotSupported", "holoLensProfileNotSupported", "windowsPcProfileNotSupported", "surfaceHub2SProfileNotSupported"], input0["deploymentProfileAssignmentDetailedStatus"]))])), (input0["deploymentProfileAssignmentStatus"] == null ? true : alltrue([(input0["deploymentProfileAssignmentStatus"] == null ? true : contains(["unknown", "assignedInSync", "assignedOutOfSync", "assignedUnkownSyncState", "notAssigned", "pending", "failed"], input0["deploymentProfileAssignmentStatus"]))])), (input0["enrollmentState"] == null ? true : alltrue([(input0["enrollmentState"] == null ? true : contains(["unknown", "enrolled", "pendingReset", "failed", "notContacted", "blocked"], input0["enrollmentState"]))])), (input0["remediationState"] == null ? true : alltrue([(input0["remediationState"] == null ? true : contains(["unknown", "noRemediationRequired", "automaticRemediationRequired", "manualRemediationRequired"], input0["remediationState"]))])), (input0["userlessEnrollmentStatus"] == null ? true : alltrue([(input0["userlessEnrollmentStatus"] == null ? true : contains(["unknown", "allowed", "blocked"], input0["userlessEnrollmentStatus"]))]))]))])]))
    error_message = "assigned_devices: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "assignments" {
  description = "The list of group assignments for the profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsAutopilotDeploymentProfileAssignment")
    source     = optional(string)
    sourceId   = optional(string)
    target     = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["source"] == null ? true : alltrue([(input0["source"] == null ? true : contains(["direct", "policySets"], input0["source"]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "A description of the deployment profile. Max allowed length is 1500 chars. Supports: $select, $top, $skip, $orderBy. $Search and $filter are not supported."
  type        = string
  default     = null
}

variable "device_name_template" {
  description = "The template used to name the Autopilot device. This can be a custom text and can also contain either the serial number of the device, or a randomly generated number. The total length of the text generated by the template can be no more than 15 characters. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
  type        = string
  default     = null
}

variable "device_type" {
  description = "The Windows device type that this profile is applicable to. Possible values include windowsPc, holoLens, and virtualMachine. The default is windowsPc. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
  type        = string
  default     = null

  validation {
    condition     = var.device_type == null ? true : contains(["windowsPc", "holoLens", "surfaceHub2", "surfaceHub2S", "virtualMachine"], var.device_type)
    error_message = "device_type must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The display name of the deployment profile. Max allowed length is 200 chars. Returned by default. Supports: $select, $top, $skip, $orderby. $Search and $filter are not supported."
  type        = string
  default     = null
}

variable "enrollment_status_screen_settings" {
  description = "Enrollment status screen setting"
  type = object({
    odata_type                                       = optional(string, "#microsoft.graph.windowsEnrollmentStatusScreenSettings")
    allowDeviceUseBeforeProfileAndAppInstallComplete = optional(bool)
    allowDeviceUseOnInstallFailure                   = optional(bool)
    allowLogCollectionOnInstallFailure               = optional(bool)
    blockDeviceSetupRetryByUser                      = optional(bool)
    customErrorMessage                               = optional(string)
    hideInstallationProgress                         = optional(bool)
    installProgressTimeoutInMinutes                  = optional(number)
  })
  default = null
}

variable "hardware_hash_extraction_enabled" {
  description = "Indicates whether the profile supports the extraction of hardware hash values and registration of the device into Windows Autopilot. When TRUE, indicates if hardware extraction and Windows Autopilot registration will happen on the next successful check-in. When FALSE, hardware hash extraction and Windows Autopilot registration will not happen. Default value is FALSE. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
  type        = bool
  default     = null
}

variable "locale" {
  description = "The locale (language) to be used when configuring the device. E.g. en-US. The default value is os-default. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
  type        = string
  default     = null
}

variable "management_service_app_id" {
  description = "The Entra management service App ID which gets used during client device-based enrollment discovery. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
  type        = string
  default     = null
}

variable "out_of_box_experience_setting" {
  description = "The Windows Autopilot Deployment Profile settings used by the device for the out-of-box experience. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
  type = object({
    odata_type                   = optional(string, "#microsoft.graph.outOfBoxExperienceSetting")
    deviceUsageType              = optional(string)
    escapeLinkHidden             = optional(bool)
    eulaHidden                   = optional(bool)
    keyboardSelectionPageSkipped = optional(bool)
    privacySettingsHidden        = optional(bool)
    userType                     = optional(string)
  })
  default = null

  validation {
    condition     = (var.out_of_box_experience_setting == null ? true : alltrue([(var.out_of_box_experience_setting["deviceUsageType"] == null ? true : alltrue([(var.out_of_box_experience_setting["deviceUsageType"] == null ? true : contains(["singleUser", "shared"], var.out_of_box_experience_setting["deviceUsageType"]))])), (var.out_of_box_experience_setting["userType"] == null ? true : alltrue([(var.out_of_box_experience_setting["userType"] == null ? true : contains(["administrator", "standard"], var.out_of_box_experience_setting["userType"]))]))]))
    error_message = "out_of_box_experience_setting: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "preprovisioning_allowed" {
  description = "Indicates whether the user is allowed to use Windows Autopilot for pre-provisioned deployment mode during Out of Box experience (OOBE). When TRUE, indicates that Windows Autopilot for pre-provisioned deployment mode for OOBE is allowed to be used. When false, Windows Autopilot for pre-provisioned deployment mode for OOBE is not allowed. The default is FALSE."
  type        = bool
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of role scope tags for the deployment profile."
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "enableWhiteGlove", "extractHardwareHash", "id", "language", "lastModifiedDateTime", "outOfBoxExperienceSettings"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
