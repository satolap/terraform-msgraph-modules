variable "assignments" {
  description = "Represents the set of Microsoft 365 groups and security groups in Microsoft Entra ID that have cloudPCUserSetting assigned. Returned only on $expand. For an example, see Get cloudPcUserSettingample."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.cloudPcUserSettingAssignment")
    createdDateTime = optional(string)
    target          = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time the setting was created. The timestamp type represents the date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 looks like this: '2014-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "cross_region_disaster_recovery_setting" {
  description = "Defines whether the user's Cloud PC enables cross-region disaster recovery and specifies the network for the disaster recovery."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The setting name displayed in the user interface."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The last date and time the setting was modified. The timestamp type represents the date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 looks like this: '2014-01-01T00:00:00Z'."
  type        = string
  default     = null
}

variable "local_admin_enabled" {
  description = "Indicates whether the local admin option is enabled. Default value is false. To enable the local admin option, change the setting to true. If the local admin option is enabled, the end user can be an admin of the Cloud PC device."
  type        = bool
  default     = null
}

variable "notification_setting" {
  description = "Defines the setting of the Cloud PC notification prompts for the Cloud PC user. The notificationSetting property is deprecated and will stop returning data on July 14, 2026."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcUserSetting"
  nullable    = false
}

variable "provisioning_source_type" {
  description = "Indicates the provisioning source of the Cloud PC prepared for an end user. The possible values are: image, snapshot, unknownFutureValue. The default value is image. If this property isn't set or set to null, its functionality is the same as setting it to image."
  type        = any
  default     = null

  validation {
    condition     = var.provisioning_source_type == null ? true : contains(["image", "snapshot", "unknownFutureValue"], var.provisioning_source_type)
    error_message = "provisioning_source_type must be one of the documented enum values."
  }
}

variable "reset_enabled" {
  description = "Indicates whether an end user is allowed to reset their Cloud PC. When true, the user is allowed to reset their Cloud PC. When false, end-user initiated reset isn't allowed. The default value is false."
  type        = bool
  default     = null
}

variable "restore_point_setting" {
  description = "Defines how frequently a restore point is created that is, a snapshot is taken) for users' provisioned Cloud PCs (default is 12 hours), and whether the user is allowed to restore their own Cloud PCs to a backup made at a specific point in time."
  type        = any
  default     = null
}

variable "self_service_enabled" {
  description = "Indicates whether the self-service option is enabled. Default value is false. To enable the self-service option, change the setting to true. If the self-service option is enabled, the end user is allowed to perform some self-service operations, such as upgrading the Cloud PC through the end user portal. The selfServiceEnabled property is deprecated and stopped returning data on December 1, 2023."
  type        = bool
  default     = null
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
