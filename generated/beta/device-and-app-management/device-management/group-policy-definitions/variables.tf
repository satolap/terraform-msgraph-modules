variable "category" {
  description = "The group policy category associated with the definition."
  type        = any
  default     = null
}

variable "category_path" {
  description = "The localized full category path for the policy."
  type        = string
  default     = null
}

variable "class_type" {
  description = "Group Policy Definition Class Type."
  type        = string
  default     = null

  validation {
    condition     = var.class_type == null ? true : contains(["user", "machine"], var.class_type)
    error_message = "class_type must be one of the documented enum values."
  }
}

variable "definition_file" {
  description = "The group policy file associated with the definition."
  type        = any
  default     = null
}

variable "display_name" {
  description = "The localized policy name."
  type        = string
  default     = null
}

variable "explain_text" {
  description = "The localized explanation or help text associated with the policy. The default value is empty."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Setting definition version"
  type        = string
  default     = null
}

variable "group_policy_category_id" {
  description = "The category id of the parent category"
  type        = string
  default     = null
}

variable "has_related_definitions" {
  description = "Signifies whether or not there are related definitions to this definition"
  type        = bool
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "min_device_csp_version" {
  description = "Minimum required CSP version for device configuration in this definition"
  type        = string
  default     = null
}

variable "min_user_csp_version" {
  description = "Minimum required CSP version for user configuration in this definition"
  type        = string
  default     = null
}

variable "next_version_definition" {
  description = "Definition of the next version of this definition"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupPolicyDefinition"
  nullable    = false
}

variable "policy_type" {
  description = "Type of Group Policy File or Definition."
  type        = string
  default     = null

  validation {
    condition     = var.policy_type == null ? true : contains(["admxBacked", "admxIngested"], var.policy_type)
    error_message = "policy_type must be one of the documented enum values."
  }
}

variable "presentations" {
  description = "The group policy presentations associated with the definition."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyPresentation")
    definition           = optional(any)
    label                = optional(string)
    lastModifiedDateTime = optional(string)
  }))
  default = null
}

variable "previous_version_definition" {
  description = "Definition of the previous version of this definition"
  type        = any
  default     = null
}

variable "supported_on" {
  description = "Localized string used to specify what operating system or application version is affected by the policy."
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
