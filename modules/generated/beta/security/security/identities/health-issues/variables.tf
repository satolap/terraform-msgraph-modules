variable "additional_information" {
  description = "Contains additional information about the issue, such as a list of items to fix."
  type        = list(string)
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the health issue was generated. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "Contains more detailed information about the health issue."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the health issue."
  type        = string
  default     = null
}

variable "domain_names" {
  description = "A list of the fully qualified domain names of the domains or the sensors the health issue is related to."
  type        = list(string)
  default     = null
}

variable "health_issue_type" {
  description = "The type of the health issue. The possible values are: sensor, global, unknownFutureValue. For a list of all health issues and their identifiers, see Microsoft Defender for Identity health issues."
  type        = any
  default     = null

  validation {
    condition     = var.health_issue_type == null ? true : contains(["sensor", "global", "unknownFutureValue"], var.health_issue_type)
    error_message = "health_issue_type must be one of the documented enum values."
  }
}

variable "issue_type_id" {
  description = "The type identifier of the health issue. For a list of all health issues and their identifiers, see Microsoft Defender for Identity health issues."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "The date and time when the health issue was last updated. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.security.healthIssue"
  nullable    = false
}

variable "recommendations" {
  description = "A list of recommended actions that can be taken to resolve the issue effectively and efficiently. These actions might include instructions for further investigation and aren't limited to prewritten responses."
  type        = list(string)
  default     = null
}

variable "recommended_action_commands" {
  description = "A list of commands from the PowerShell module for the product that can be used to resolve the issue, if available. If no commands can be used to solve the issue, this property is empty. The commands, if present, provide a quick and efficient way to address the issue. These commands run in sequence for the single recommended fix."
  type        = list(string)
  default     = null
}

variable "sensor_dns_names" {
  description = "A list of the DNS names of the sensors the health issue is related to."
  type        = list(string)
  default     = null
}

variable "severity" {
  description = "The severity of the health issue. The possible values are: low, medium, high, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["low", "medium", "high", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "status" {
  description = "The status of the health issue. The possible values are: open, closed, suppressed, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["open", "closed", "suppressed", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
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
