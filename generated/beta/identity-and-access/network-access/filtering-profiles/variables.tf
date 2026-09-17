variable "conditional_access_policies" {
  description = "A set of associated policies defined to regulate access to resources or systems based on specific conditions. Automatically expanded."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.networkaccess.conditionalAccessPolicy")
    createdDateTime  = optional(string)
    description      = optional(string)
    displayName      = optional(string)
    modifiedDateTime = optional(string)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time when the filteringProfile was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Description."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Profile version."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the profile was last modified."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the entity"
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.filteringProfile"
  nullable    = false
}

variable "policies" {
  description = "The traffic forwarding policies associated with this profile."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.policyLink")
    policy = optional(object({
      odata_type  = optional(string, "#microsoft.graph.networkaccess.policy")
      description = optional(string)
      name        = optional(string)
      policyRules = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.networkaccess.policyRule")
        name       = optional(string)
      })))
      version = optional(string)
    }))
    state   = optional(string)
    version = optional(string)
  }))
  default = null
}

variable "priority" {
  description = "The priority used to order the profile for processing within a list."
  type        = number
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
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
