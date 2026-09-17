variable "display_name" {
  description = "Name of the Security Copilot workspace."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.securityCopilot.workspace"
  nullable    = false
}

variable "plugins" {
  description = "Represents plugins in Security Copilot."
  type = list(object({
    odata_type    = optional(string, "#microsoft.graph.security.securityCopilot.plugin")
    authorization = optional(any)
    catalogScope  = optional(string)
    category      = optional(string)
    description   = optional(string)
    displayName   = optional(string)
    isEnabled     = optional(bool)
    name          = optional(string)
    previewState  = optional(string)
    settings = optional(list(object({
      odata_type       = optional(string, "#microsoft.graph.security.securityCopilot.pluginSetting")
      acceptableValues = optional(list(string))
      defaultValue     = optional(string)
      description      = optional(string)
      displayType      = optional(string)
      hintText         = optional(string)
      isRequired       = optional(bool)
      label            = optional(string)
      name             = optional(string)
      settingValue     = optional(string)
      value            = optional(string)
    })))
    supportedAuthTypes = optional(string)
  }))
  default = null
}

variable "sessions" {
  description = "Represents sessions in Security Copilot."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.security.securityCopilot.session")
    createdDateTime      = optional(string)
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    prompts = optional(list(object({
      odata_type            = optional(string, "#microsoft.graph.security.securityCopilot.prompt")
      content               = optional(string)
      createdDateTime       = optional(string)
      evaluations           = optional(any)
      inputs                = optional(any)
      lastModifiedDateTime  = optional(string)
      skillInputDescriptors = optional(any)
      skillName             = optional(string)
      type                  = optional(string)
    })))
  }))
  default = null
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
