variable "conditions" {
  description = "Microsoft Graph conditions property."
  type = object({
    odata_type                 = optional(string, "#microsoft.graph.conditionalAccessConditionSet")
    applications               = optional(any)
    authenticationFlows        = optional(any)
    clientAppTypes             = optional(list(string))
    clientApplications         = optional(any)
    devices                    = optional(any)
    insiderRiskLevels          = optional(any)
    locations                  = optional(any)
    platforms                  = optional(any)
    servicePrincipalRiskLevels = optional(list(string))
    signInRiskLevels           = optional(list(string))
    userRiskLevels             = optional(list(string))
    users                      = optional(any)
  })
  default = null
}

variable "deleted_date_time" {
  description = "Microsoft Graph deletedDateTime property."
  type        = string
  default     = null
}

variable "description" {
  description = "Microsoft Graph description property."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Specifies a display name for the conditionalAccessPolicy object."
  type        = string
  default     = null
}

variable "grant_controls" {
  description = "Specifies the grant controls that must be fulfilled to pass the policy."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.conditionalAccessPolicy"
  nullable    = false
}

variable "session_controls" {
  description = "Specifies the session controls that are enforced after sign-in."
  type        = any
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "template_id" {
  description = "Specifies the unique identifier of a Conditional Access template. Inherited from entity."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "modifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
