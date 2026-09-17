variable "authorization_system" {
  description = "Microsoft Graph authorizationSystem property."
  type = object({
    odata_type              = optional(string, "#microsoft.graph.authorizationSystem")
    authorizationSystemId   = optional(string)
    authorizationSystemName = optional(string)
    authorizationSystemType = optional(string)
    dataCollectionInfo      = optional(any)
  })
  default = null
}

variable "created_date_time" {
  description = "Defines when the PCI distribution was created."
  type        = string
  default     = null
}

variable "high_risk_profile" {
  description = "Microsoft Graph highRiskProfile property."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.riskProfile")
    humanCount    = optional(number)
    nonHumanCount = optional(number)
  })
  default = null
}

variable "low_risk_profile" {
  description = "Microsoft Graph lowRiskProfile property."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.riskProfile")
    humanCount    = optional(number)
    nonHumanCount = optional(number)
  })
  default = null
}

variable "medium_risk_profile" {
  description = "Microsoft Graph mediumRiskProfile property."
  type = object({
    odata_type    = optional(string, "#microsoft.graph.riskProfile")
    humanCount    = optional(number)
    nonHumanCount = optional(number)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.permissionsCreepIndexDistribution"
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
