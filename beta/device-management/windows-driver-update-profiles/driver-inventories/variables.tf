variable "windows_driver_update_profile_id" {
  description = "The unique identifier of windowsDriverUpdateProfile"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.windows_driver_update_profile_id)) > 0
    error_message = "windows_driver_update_profile_id must not be empty."
  }
}

variable "applicable_device_count" {
  description = "The number of devices for which this driver is applicable."
  type        = number
  default     = null
}

variable "approval_status" {
  description = "An enum type to represent approval status of a driver."
  type        = string
  default     = null

  validation {
    condition     = var.approval_status == null ? true : contains(["needsReview", "declined", "approved", "suspended"], var.approval_status)
    error_message = "approval_status must be one of the documented enum values."
  }
}

variable "category" {
  description = "An enum type to represent which category a driver belongs to."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["recommended", "previouslyApproved", "other"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "deploy_date_time" {
  description = "The date time when a driver should be deployed if approvalStatus is approved."
  type        = string
  default     = null
}

variable "driver_class" {
  description = "The class of the driver."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version of the driver."
  type        = string
  default     = null
}

variable "manufacturer" {
  description = "The manufacturer of the driver."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the driver."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsDriverUpdateInventory"
  nullable    = false
}

variable "release_date_time" {
  description = "The release date time of the driver."
  type        = string
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
