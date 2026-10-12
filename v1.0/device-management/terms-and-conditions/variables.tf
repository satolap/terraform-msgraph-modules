variable "acceptance_statement" {
  description = "Administrator-supplied explanation of the terms and conditions, typically describing what it means to accept the terms and conditions set out in the T&C policy. This is shown to the user on prompts to accept the T&C policy."
  type        = string
  default     = null
}

variable "acceptance_statuses" {
  description = "The list of acceptance statuses for this T&C policy."
  type = list(object({
    odata_type         = optional(string, "#microsoft.graph.termsAndConditionsAcceptanceStatus")
    acceptedDateTime   = optional(string)
    acceptedVersion    = optional(number)
    termsAndConditions = optional(any)
    userDisplayName    = optional(string)
    userPrincipalName  = optional(string)
  }))
  default = null
}

variable "assignments" {
  description = "The list of assignments for this T&C policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.termsAndConditionsAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "body_text" {
  description = "Administrator-supplied body text of the terms and conditions, typically the terms themselves. This is shown to the user on prompts to accept the T&C policy."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "DateTime the object was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Administrator-supplied description of the T&C policy."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Administrator-supplied name for the T&C policy."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Integer indicating the current version of the terms. Incremented when an administrator makes a change to the terms and wishes to require users to re-accept the modified T&C policy."
  type        = number
  default     = null
}

variable "last_modified_date_time" {
  description = "DateTime the object was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.termsAndConditions"
  nullable    = false
}

variable "title" {
  description = "Administrator-supplied title of the terms and conditions. This is shown to the user on prompts to accept the T&C policy."
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
