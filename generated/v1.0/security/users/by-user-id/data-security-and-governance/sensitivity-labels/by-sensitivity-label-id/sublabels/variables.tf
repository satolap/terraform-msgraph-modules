variable "user_id" {
  description = "The unique identifier of user"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.user_id)) > 0
    error_message = "user_id must not be empty."
  }
}

variable "sensitivity_label_id" {
  description = "The unique identifier of sensitivityLabel"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.sensitivity_label_id)) > 0
    error_message = "sensitivity_label_id must not be empty."
  }
}

variable "action_source" {
  description = "Microsoft Graph actionSource property."
  type        = any
  default     = null

  validation {
    condition     = var.action_source == null ? true : contains(["manual", "automatic", "recommended", "none", "unknownFutureValue"], var.action_source)
    error_message = "action_source must be one of the documented enum values."
  }
}

variable "auto_tooltip" {
  description = "Microsoft Graph autoTooltip property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Microsoft Graph displayName property."
  type        = string
  default     = null
}

variable "has_protection" {
  description = "Microsoft Graph hasProtection property."
  type        = bool
  default     = null
}

variable "is_default" {
  description = "Microsoft Graph isDefault property."
  type        = bool
  default     = null
}

variable "is_endpoint_protection_enabled" {
  description = "Microsoft Graph isEndpointProtectionEnabled property."
  type        = bool
  default     = null
}

variable "is_scoped_to_user" {
  description = "Microsoft Graph isScopedToUser property."
  type        = bool
  default     = null
}

variable "locale" {
  description = "Microsoft Graph locale property."
  type        = string
  default     = null
}

variable "name" {
  description = "Microsoft Graph name property."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.sensitivityLabel"
  nullable    = false
}

variable "priority" {
  description = "Microsoft Graph priority property."
  type        = number
  default     = null
}

variable "rights" {
  description = "Microsoft Graph rights property."
  type        = any
  default     = null
}

variable "sublabels" {
  description = "Microsoft Graph sublabels property."
  type = list(object({
    odata_type                  = optional(string, "#microsoft.graph.sensitivityLabel")
    actionSource                = optional(any)
    autoTooltip                 = optional(string)
    description                 = optional(string)
    displayName                 = optional(string)
    hasProtection               = optional(bool)
    isDefault                   = optional(bool)
    isEndpointProtectionEnabled = optional(bool)
    isScopedToUser              = optional(bool)
    locale                      = optional(string)
    name                        = optional(string)
    priority                    = optional(number)
    rights                      = optional(any)
    sublabels                   = optional(any)
    toolTip                     = optional(string)
  }))
  default = null
}

variable "tool_tip" {
  description = "Microsoft Graph toolTip property."
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
