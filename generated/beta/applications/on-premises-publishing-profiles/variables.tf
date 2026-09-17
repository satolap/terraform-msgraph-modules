variable "application_segments" {
  description = "Represents the segment configurations that are allowed for an on-premises non-web application published through Microsoft Entra application proxy."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.ipApplicationSegment")
    action          = optional(string)
    application     = optional(any)
    destinationHost = optional(string)
    destinationType = optional(any)
    port            = optional(number)
    ports           = optional(list(string))
    protocol        = optional(any)
  }))
  default = null
}

variable "hybrid_agent_updater_configuration" {
  description = "Represents a hybridAgentUpdaterConfiguration object."
  type        = any
  default     = null
}

variable "is_default_access_enabled" {
  description = "Specifies whether default access for app proxy is enabled or disabled."
  type        = bool
  default     = null
}

variable "is_enabled" {
  description = "Represents if Microsoft Entra application proxy is enabled for the tenant."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onPremisesPublishingProfile"
  nullable    = false
}

variable "sensors" {
  description = "A lightweight agent installed on domain controllers that helps secure access and enforce MFA to on-premise resources."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.privateAccessSensor")
    externalIp          = optional(string)
    isAuditMode         = optional(bool)
    isBreakglassEnabled = optional(bool)
    machineName         = optional(string)
    status              = optional(string)
    version             = optional(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["agentGroups", "agents", "connectorGroups", "connectors", "id", "publishedResources"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
