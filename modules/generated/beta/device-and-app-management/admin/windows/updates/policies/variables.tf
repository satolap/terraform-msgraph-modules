variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.windowsUpdates.qualityUpdatePolicy"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "applicable_content" {
  description = "Represents content applicable for offering to the related collection of devices."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.windowsUpdates.applicableContent")
    catalogEntry   = optional(any)
    catalogEntryId = optional(string)
    matchedDevices = optional(list(object({
      odata_type    = optional(string, "#microsoft.graph.windowsUpdates.applicableContentDeviceMatch")
      deviceId      = optional(string)
      recommendedBy = optional(list(string))
    })))
  }))
  default = null
}

variable "approval_rules" {
  description = "The approved rule of the policy that determines which published content matches the rule on an ongoing basis."
  type        = any
  default     = null
}

variable "approvals" {
  description = "Represents a set of quality updates policy approval types."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.windowsUpdates.policyApproval")
    catalogEntryId = optional(string)
    status         = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The policy description. The maximum length is 1,500 characters."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The policy display name. The maximum length is 200 characters."
  type        = string
  default     = null
}

variable "rings" {
  description = "Represents a set of deployment rings that contains update deployment settings."
  type        = any
  default     = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
