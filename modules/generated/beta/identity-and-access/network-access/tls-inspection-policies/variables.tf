variable "description" {
  description = "Description."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Version."
  type        = string
  default     = null
}

variable "name" {
  description = "Policy name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.tlsInspectionPolicy"
  nullable    = false
}

variable "policy_rules" {
  description = "Represents the definition of the policy ruleset that makes up the core definition of a policy."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.policyRule")
    name       = optional(string)
  }))
  default = null
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type = object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.tlsInspectionPolicySettings")
  })
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
