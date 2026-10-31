variable "category" {
  description = "The group policy category associated with the definition."
  type        = any
  default     = null
}

variable "categoryPath" {
  description = "The localized full category path for the policy."
  type        = string
  default     = null
}

variable "classType" {
  description = "Group Policy Definition Class Type."
  type        = string
  default     = null

  validation {
    condition     = var.classType == null ? true : contains(["user", "machine"], var.classType)
    error_message = "classType must be one of the documented enum values."
  }
}

variable "definitionFile" {
  description = "The group policy file associated with the definition."
  type        = any
  default     = null
}

variable "displayName" {
  description = "The localized policy name."
  type        = string
  default     = null
}

variable "explainText" {
  description = "The localized explanation or help text associated with the policy. The default value is empty."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "Setting definition version"
  type        = string
  default     = null
}

variable "groupPolicyCategoryId" {
  description = "The category id of the parent category"
  type        = string
  default     = null
}

variable "hasRelatedDefinitions" {
  description = "Signifies whether or not there are related definitions to this definition"
  type        = bool
  default     = null
}

variable "lastModifiedDateTime" {
  description = "The date and time the entity was last modified."
  type        = string
  default     = null
}

variable "minDeviceCspVersion" {
  description = "Minimum required CSP version for device configuration in this definition"
  type        = string
  default     = null
}

variable "minUserCspVersion" {
  description = "Minimum required CSP version for user configuration in this definition"
  type        = string
  default     = null
}

variable "nextVersionDefinition" {
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

variable "policyType" {
  description = "Type of Group Policy File or Definition."
  type        = string
  default     = null

  validation {
    condition     = var.policyType == null ? true : contains(["admxBacked", "admxIngested"], var.policyType)
    error_message = "policyType must be one of the documented enum values."
  }
}

variable "presentations" {
  description = "The group policy presentations associated with the definition."
  type        = any
  default     = null
}

variable "previousVersionDefinition" {
  description = "Definition of the previous version of this definition"
  type        = any
  default     = null
}

variable "supportedOn" {
  description = "Localized string used to specify what operating system or application version is affected by the policy."
  type        = string
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
