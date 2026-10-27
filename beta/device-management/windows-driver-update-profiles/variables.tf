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
    target     = optional(any)
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

  validation {
    condition     = (var.driver_inventories == null ? true : alltrue([alltrue([for input0 in var.driver_inventories : (input0 == null ? true : alltrue([(input0["approvalStatus"] == null ? true : alltrue([(input0["approvalStatus"] == null ? true : contains(["needsReview", "declined", "approved", "suspended"], input0["approvalStatus"]))])), (input0["category"] == null ? true : alltrue([(input0["category"] == null ? true : contains(["recommended", "previouslyApproved", "other"], input0["category"]))]))]))])]))
    error_message = "driver_inventories: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "inventory_sync_status" {
  description = "Driver inventory sync status for this profile."
  type = object({
    odata_type                 = optional(string, "#microsoft.graph.windowsDriverUpdateProfileInventorySyncStatus")
    driverInventorySyncState   = optional(string)
    lastSuccessfulSyncDateTime = optional(string)
  })
  default = null

  validation {
    condition     = (var.inventory_sync_status == null ? true : alltrue([(var.inventory_sync_status["driverInventorySyncState"] == null ? true : alltrue([(var.inventory_sync_status["driverInventorySyncState"] == null ? true : contains(["pending", "success", "failure"], var.inventory_sync_status["driverInventorySyncState"]))]))]))
    error_message = "inventory_sync_status: nested required attributes must be non-null and enum values must be supported input members."
  }
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
