variable "access_package_catalog_id" {
  description = "The unique identifier of accessPackageCatalog"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.access_package_catalog_id)) > 0
    error_message = "access_package_catalog_id must not be empty."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension", "#microsoft.graph.accessPackageAssignmentWorkflowExtension", "#microsoft.graph.identityGovernance.customTaskExtension", "#microsoft.graph.onAttributeCollectionStartCustomExtension", "#microsoft.graph.onAttributeCollectionSubmitCustomExtension", "#microsoft.graph.onOtpSendCustomExtension", "#microsoft.graph.onPasswordSubmitCustomExtension", "#microsoft.graph.onTokenIssuanceStartCustomExtension", "#microsoft.graph.onVerifiedIdClaimValidationCustomExtension", "#microsoft.graph.roleManagementCustomCalloutExtension"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "authentication_configuration" {
  description = "Configuration for securing the API call to the logic app. For example, using OAuth client credentials flow."
  type        = any
  default     = null
}

variable "client_configuration" {
  description = "HTTP connection settings that define how long Microsoft Entra ID can wait for a connection to a logic app, how many times you can retry a timed-out connection and the exception scenarios when retries are allowed."
  type = object({
    odata_type            = optional(string, "#microsoft.graph.customExtensionClientConfiguration")
    maximumRetries        = optional(number)
    timeoutInMilliseconds = optional(number)
  })
  default = null
}

variable "description" {
  description = "Description for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the customCalloutExtension object."
  type        = string
  default     = null
}

variable "endpoint_configuration" {
  description = "The type and details for configuring the endpoint to call the logic app's workflow."
  type        = any
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
