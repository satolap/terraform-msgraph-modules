variable "apple_identifier" {
  description = "The Apple ID used to obtain the current token."
  type        = string
  default     = null
}

variable "data_sharing_consent_granted" {
  description = "Consent granted for data sharing with Apple Dep Service"
  type        = bool
  default     = null
}

variable "default_ios_enrollment_profile" {
  description = "Default iOS Enrollment Profile"
  type        = any
  default     = null
}

variable "default_mac_os_enrollment_profile" {
  description = "Default MacOs Enrollment Profile"
  type        = any
  default     = null
}

variable "default_tv_os_enrollment_profile" {
  description = "Default TvOS Enrollment Profile"
  type        = any
  default     = null
}

variable "default_vision_os_enrollment_profile" {
  description = "Default VisionOS Enrollment Profile"
  type        = any
  default     = null
}

variable "enrollment_profiles" {
  description = "The enrollment profiles."
  type = list(object({
    odata_type                                          = optional(string, "#microsoft.graph.enrollmentProfile")
    configurationEndpointUrl                            = optional(string)
    description                                         = optional(string)
    displayName                                         = optional(string)
    enableAuthenticationViaCompanyPortal                = optional(bool)
    requireCompanyPortalOnSetupAssistantEnrolledDevices = optional(bool)
    requiresUserAuthentication                          = optional(bool)
  }))
  default = null
}

variable "imported_apple_device_identities" {
  description = "The imported Apple device identities."
  type = list(object({
    odata_type                                   = optional(string, "#microsoft.graph.importedAppleDeviceIdentity")
    createdDateTime                              = optional(string)
    description                                  = optional(string)
    discoverySource                              = optional(string)
    enrollmentState                              = optional(string)
    isDeleted                                    = optional(bool)
    isSupervised                                 = optional(bool)
    lastContactedDateTime                        = optional(string)
    platform                                     = optional(string)
    requestedEnrollmentProfileAssignmentDateTime = optional(string)
    requestedEnrollmentProfileId                 = optional(string)
    serialNumber                                 = optional(string)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "When the service was onboarded."
  type        = string
  default     = null
}

variable "last_successful_sync_date_time" {
  description = "When the service last syned with Intune"
  type        = string
  default     = null
}

variable "last_sync_error_code" {
  description = "Error code reported by Apple during last dep sync."
  type        = number
  default     = null
}

variable "last_sync_triggered_date_time" {
  description = "When Intune last requested a sync."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.depOnboardingSetting"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "share_token_with_school_data_sync_service" {
  description = "Whether or not the Dep token sharing is enabled with the School Data Sync service."
  type        = bool
  default     = null
}

variable "synced_device_count" {
  description = "Gets synced device count"
  type        = number
  default     = null
}

variable "token_expiration_date_time" {
  description = "When the token will expire."
  type        = string
  default     = null
}

variable "token_name" {
  description = "Friendly Name for Dep Token"
  type        = string
  default     = null
}

variable "token_type" {
  description = "Microsoft Graph tokenType property."
  type        = string
  default     = null

  validation {
    condition     = var.token_type == null ? true : contains(["none", "dep", "appleSchoolManager"], var.token_type)
    error_message = "token_type must be one of the documented enum values."
  }
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
