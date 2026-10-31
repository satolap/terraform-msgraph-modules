variable "authenticationConfiguration" {
  description = "Configuration for securing the API call to the logic app. For example, using OAuth client credentials flow."
  type        = any
  default     = null
}

variable "clientConfiguration" {
  description = "HTTP connection settings that define how long Microsoft Entra ID can wait for a connection to a logic app, how many times you can retry a timed-out connection and the exception scenarios when retries are allowed."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionClientConfiguration")
    maximumRetries        = optional(number)
    timeoutInMilliseconds = optional(number)
  })
  default = null
}

variable "customAttributes" {
  description = "The custom attribute names to include in the callout payload."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "Description for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Display name for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "endpointConfiguration" {
  description = "The type and details for configuring the endpoint to call the logic app's workflow."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.roleManagementCustomCalloutExtension"
  nullable    = false
}

variable "resourceType" {
  description = "Microsoft Graph resourceType property."
  type        = string
  default     = null

  validation {
    condition     = var.resourceType == null ? true : contains(["entraRoles", "azureResources", "entraGroups"], var.resourceType)
    error_message = "resourceType must be one of the documented enum values."
  }
}

variable "type" {
  description = "Microsoft Graph type property."
  type        = string
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["preApproval", "postApproval", "grant", "revoke"], var.type)
    error_message = "type must be one of the documented enum values."
  }
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
