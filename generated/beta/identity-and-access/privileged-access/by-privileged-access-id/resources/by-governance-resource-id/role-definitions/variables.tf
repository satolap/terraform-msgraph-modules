variable "privileged_access_id" {
  description = "The unique identifier of privilegedAccess"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.privileged_access_id)) > 0
    error_message = "privileged_access_id must not be empty."
  }
}

variable "governance_resource_id" {
  description = "The unique identifier of governanceResource"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.governance_resource_id)) > 0
    error_message = "governance_resource_id must not be empty."
  }
}

variable "display_name" {
  description = "The display name of the role definition."
  type        = string
  default     = null
}

variable "external_id" {
  description = "The external ID of the role definition."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.governanceRoleDefinition"
  nullable    = false
}

variable "resource_id" {
  description = "Required. The ID of the resource associated with the role definition."
  type        = string
  default     = null
}

variable "role_setting" {
  description = "The associated role setting for the role definition."
  type        = any
  default     = null
}

variable "template_id" {
  description = "The unique identifier for the template."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "resource"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
