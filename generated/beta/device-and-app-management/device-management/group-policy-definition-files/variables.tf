variable "definitions" {
  description = "The group policy definitions associated with the file."
  type = list(object({
    odata_type            = optional(string, "#microsoft.graph.groupPolicyDefinition")
    category              = optional(any)
    categoryPath          = optional(string)
    classType             = optional(string)
    definitionFile        = optional(any)
    displayName           = optional(string)
    explainText           = optional(string)
    groupPolicyCategoryId = optional(string)
    hasRelatedDefinitions = optional(bool)
    lastModifiedDateTime  = optional(string)
    minDeviceCspVersion   = optional(string)
    minUserCspVersion     = optional(string)
    nextVersionDefinition = optional(any)
    policyType            = optional(string)
    presentations = optional(list(object({
      odata_type           = optional(string, "#microsoft.graph.groupPolicyPresentation")
      definition           = optional(any)
      label                = optional(string)
      lastModifiedDateTime = optional(string)
    })))
    previousVersionDefinition = optional(any)
    supportedOn               = optional(string)
    version                   = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The localized description of the policy settings in the ADMX file. The default value is empty."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The localized friendly name of the ADMX file."
  type        = string
  default     = null
}

variable "file_name" {
  description = "The file name of the ADMX file without the path. For example: edge.admx"
  type        = string
  default     = null
}

variable "language_codes" {
  description = "The supported language codes for the ADMX file."
  type        = list(string)
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
  default     = "#microsoft.graph.groupPolicyDefinitionFile"
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

variable "revision" {
  description = "The revision version associated with the file."
  type        = string
  default     = null
}

variable "target_namespace" {
  description = "Specifies the URI used to identify the namespace within the ADMX file."
  type        = string
  default     = null
}

variable "target_prefix" {
  description = "Specifies the logical name that refers to the namespace within the ADMX file."
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
