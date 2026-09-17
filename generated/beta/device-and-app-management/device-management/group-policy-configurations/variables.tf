variable "assignments" {
  description = "The list of group assignments for the configuration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyConfigurationAssignment")
    lastModifiedDateTime = optional(string)
    target               = optional(any)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time the object was created."
  type        = string
  default     = null
}

variable "definition_values" {
  description = "The list of enabled or disabled group policy definition values for the configuration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyDefinitionValue")
    configurationType    = optional(string)
    createdDateTime      = optional(string)
    definition           = optional(any)
    enabled              = optional(bool)
    lastModifiedDateTime = optional(string)
    presentationValues = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.groupPolicyPresentationValue")
      createdDateTime      = optional(string)
      definitionValue      = optional(any)
      lastModifiedDateTime = optional(string)
      presentation         = optional(any)
    })))
  }))
  default = null
}

variable "description" {
  description = "User provided description for the resource object."
  type        = string
  default     = null
}

variable "display_name" {
  description = "User provided name for the resource object."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyConfiguration"
  nullable    = false
}

variable "policy_configuration_ingestion_type" {
  description = "Group Policy Configuration Ingestion Type"
  type        = string
  default     = null

  validation {
    condition     = var.policy_configuration_ingestion_type == null ? true : contains(["unknown", "custom", "builtIn", "mixed", "unknownFutureValue"], var.policy_configuration_ingestion_type)
    error_message = "policy_configuration_ingestion_type must be one of the documented enum values."
  }
}

variable "role_scope_tag_ids" {
  description = "The list of scope tags for the configuration."
  type        = list(string)
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
