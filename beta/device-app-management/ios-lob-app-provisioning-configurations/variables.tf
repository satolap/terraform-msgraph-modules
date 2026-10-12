variable "assignments" {
  description = "The associated group assignments for IosLobAppProvisioningConfiguration, this determines which devices/users the IOS LOB app provisioning conifguration will be targeted to."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.iosLobAppProvisioningConfigurationAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "DateTime the object was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Admin provided description of the Device Configuration."
  type        = string
  default     = null
}

variable "device_statuses" {
  description = "The list of device installation states for this mobile app configuration."
  type = list(object({
    odata_type                              = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationDeviceStatus")
    complianceGracePeriodExpirationDateTime = optional(string)
    deviceDisplayName                       = optional(string)
    deviceModel                             = optional(string)
    lastReportedDateTime                    = optional(string)
    platform                                = optional(number)
    status                                  = optional(string)
    userName                                = optional(string)
    userPrincipalName                       = optional(string)
  }))
  default = null
}

variable "display_name" {
  description = "Admin provided name of the device configuration."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "Optional profile expiration date and time. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 would look like this: '2014-01-01T00:00:00Z'. Returned by default."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version of the device configuration."
  type        = number
  default     = null
}

variable "group_assignments" {
  description = "The associated group assignments."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.mobileAppProvisioningConfigGroupAssignment")
    targetGroupId = optional(string)
  }))
  default = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.iosLobAppProvisioningConfiguration"
  nullable    = false
}

variable "payload" {
  description = "Payload. (UTF8 encoded byte array)"
  type        = string
  default     = null
}

variable "payload_file_name" {
  description = "Payload file name (.mobileprovision"
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this iOS LOB app provisioning configuration entity."
  type        = list(string)
  default     = null
}

variable "user_statuses" {
  description = "The list of user installation states for this mobile app configuration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedDeviceMobileAppConfigurationUserStatus")
    devicesCount         = optional(number)
    lastReportedDateTime = optional(string)
    status               = optional(string)
    userDisplayName      = optional(string)
    userPrincipalName    = optional(string)
  }))
  default = null
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
