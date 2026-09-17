variable "approval_type" {
  description = "An enum type to represent approval type of a driver update profile."
  type        = string
  default     = null

  validation {
    condition     = var.approval_type == null ? true : contains(["manual", "automatic"], var.approval_type)
    error_message = "approval_type must be one of the documented enum values."
  }
}

variable "assignments" {
  description = "The list of group assignments of the profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.windowsDriverUpdateProfileAssignment")
    target = optional(object({
      odata_type                                 = optional(string, "#microsoft.graph.deviceAndAppManagementAssignmentTarget")
      deviceAndAppManagementAssignmentFilterId   = optional(string)
      deviceAndAppManagementAssignmentFilterType = optional(string)
    }))
  }))
  default = null
}

variable "created_date_time" {
  description = "The date time that the profile was created."
  type        = string
  default     = null
}

variable "deployment_deferral_in_days" {
  description = "Deployment deferral settings in days, only applicable when ApprovalType is set to automatic approval."
  type        = number
  default     = null
}

variable "description" {
  description = "The description of the profile which is specified by the user."
  type        = string
  default     = null
}

variable "device_reporting" {
  description = "Number of devices reporting for this profile"
  type        = number
  default     = null
}

variable "display_name" {
  description = "The display name for the profile."
  type        = string
  default     = null
}

variable "driver_inventories" {
  description = "Driver inventories for this profile."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.windowsDriverUpdateInventory")
    applicableDeviceCount = optional(number)
    approvalStatus        = optional(string)
    category              = optional(string)
    deployDateTime        = optional(string)
    driverClass           = optional(string)
    manufacturer          = optional(string)
    name                  = optional(string)
    releaseDateTime       = optional(string)
    version               = optional(string)
  }))
  default = null
}

variable "inventory_sync_status" {
  description = "Driver inventory sync status for this profile."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "The date time that the profile was last modified."
  type        = string
  default     = null
}

variable "new_updates" {
  description = "Number of new driver updates available for this profile."
  type        = number
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsDriverUpdateProfile"
  nullable    = false
}

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Driver Update entity."
  type        = list(string)
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
