variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "last_shared_method" {
  description = "Microsoft Graph lastSharedMethod property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sharedInsight"
  nullable    = false
}

variable "resource" {
  description = "Used for navigating to the item that was shared. For file attachments, the type is fileAttachment. For linked attachments, the type is driveItem."
  type        = any
  default     = null
}

variable "sharing_history" {
  description = "Microsoft Graph sharingHistory property."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.sharingDetail")
    sharedBy       = optional(any)
    sharingSubject = optional(string)
    sharingType    = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastShared", "resourceReference", "resourceVisualization"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
