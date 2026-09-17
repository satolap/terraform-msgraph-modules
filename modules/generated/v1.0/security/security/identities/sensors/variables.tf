variable "created_date_time" {
  description = "The date and time when the sensor was generated. The Timestamp represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "deployment_status" {
  description = "Microsoft Graph deploymentStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.deployment_status == null ? true : contains(["upToDate", "outdated", "updating", "updateFailed", "notConfigured", "unreachable", "disconnected", "startFailure", "syncing", "unknownFutureValue"], var.deployment_status)
    error_message = "deployment_status must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The display name of the sensor."
  type        = string
  default     = null
}

variable "domain_name" {
  description = "The fully qualified domain name of the sensor."
  type        = string
  default     = null
}

variable "graph_version" {
  description = "The version of the sensor."
  type        = string
  default     = null
}

variable "health_issues" {
  description = "Represents potential issues within a customer's Microsoft Defender for Identity configuration that Microsoft Defender for Identity identified related to the sensor."
  type = list(object({
    odata_type                = optional(string, "#microsoft.graph.security.healthIssue")
    additionalInformation     = optional(list(string))
    createdDateTime           = optional(string)
    description               = optional(string)
    displayName               = optional(string)
    domainNames               = optional(list(string))
    healthIssueType           = optional(any)
    issueTypeId               = optional(string)
    lastModifiedDateTime      = optional(string)
    recommendations           = optional(list(string))
    recommendedActionCommands = optional(list(string))
    sensorDNSNames            = optional(list(string))
    severity                  = optional(any)
    status                    = optional(any)
  }))
  default = null
}

variable "health_status" {
  description = "Microsoft Graph healthStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.health_status == null ? true : contains(["healthy", "notHealthyLow", "notHealthyMedium", "notHealthyHigh", "unknownFutureValue"], var.health_status)
    error_message = "health_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.sensor"
  nullable    = false
}

variable "open_health_issues_count" {
  description = "This field displays the count of health issues related to this sensor."
  type        = number
  default     = null
}

variable "sensor_type" {
  description = "Microsoft Graph sensorType property."
  type        = string
  default     = null

  validation {
    condition     = var.sensor_type == null ? true : contains(["adConnectIntegrated", "adcsIntegrated", "adfsIntegrated", "domainControllerIntegrated", "domainControllerStandalone", "unknownFutureValue"], var.sensor_type)
    error_message = "sensor_type must be one of the documented enum values."
  }
}

variable "service_status" {
  description = "Microsoft Graph serviceStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.service_status == null ? true : contains(["stopped", "starting", "running", "disabled", "onboarding", "unknown", "unknownFutureValue"], var.service_status)
    error_message = "service_status must be one of the documented enum values."
  }
}

variable "settings" {
  description = "Microsoft Graph settings property."
  type = object({
    odata_type                 = optional(string, "#microsoft.graph.security.sensorSettings")
    description                = optional(string)
    domainControllerDnsNames   = optional(list(string))
    isDelayedDeploymentEnabled = optional(bool)
    networkAdapters = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.security.networkAdapter")
      isEnabled  = optional(bool)
      name       = optional(string)
    })))
  })
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
