variable "assignments" {
  description = "The list of group assignments for the configuration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyConfigurationAssignment")
    lastModifiedDateTime = optional(string)
    target               = optional(any)
  }))
  default = null
}

variable "createdDateTime" {
  description = "The date and time the object was created."
  type        = string
  default     = null
}

variable "definitionValues" {
  description = "The list of enabled or disabled group policy definition values for the configuration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.groupPolicyDefinitionValue")
    configurationType    = optional(string)
    createdDateTime      = optional(string)
    definition           = optional(any)
    enabled              = optional(bool)
    lastModifiedDateTime = optional(string)
    presentationValues   = optional(any)
  }))
  default = null

  validation {
    condition     = (var.definitionValues == null ? true : alltrue([alltrue([for input0 in var.definitionValues : (input0 == null ? true : alltrue([(input0["configurationType"] == null ? true : alltrue([(input0["configurationType"] == null ? true : contains(["policy", "preference"], input0["configurationType"]))]))]))])]))
    error_message = "definitionValues: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "description" {
  description = "User provided description for the resource object."
  type        = string
  default     = null
}

variable "displayName" {
  description = "User provided name for the resource object."
  type        = string
  default     = null
}

variable "lastModifiedDateTime" {
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

variable "policyConfigurationIngestionType" {
  description = "Group Policy Configuration Ingestion Type"
  type        = string
  default     = null

  validation {
    condition     = var.policyConfigurationIngestionType == null ? true : contains(["unknown", "custom", "builtIn", "mixed"], var.policyConfigurationIngestionType)
    error_message = "policyConfigurationIngestionType must be one of the documented enum values."
  }
}

variable "roleScopeTagIds" {
  description = "The list of scope tags for the configuration."
  type        = list(string)
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
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
