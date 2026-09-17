variable "alert_type" {
  description = "Microsoft Graph alertType property."
  type        = string
  default     = null

  validation {
    condition     = var.alert_type == null ? true : contains(["unknown", "mfaSignInFailure", "managedDeviceSignInFailure", "compliantDeviceSignInFailure", "unknownFutureValue", "conditionalAccessBlockedSignIn", "samlSignInFailure", "internetAppBlockedByPolicy", "privateAppBlockedByConnector", "remoteNetworkTunnelConnectivity", "remoteNetworkBgpConnectivity"], var.alert_type)
    error_message = "alert_type must be one of the documented enum values."
  }
}

variable "category" {
  description = "Microsoft Graph category property."
  type        = string
  default     = null

  validation {
    condition     = var.category == null ? true : contains(["unknown", "authentication", "unknownFutureValue"], var.category)
    error_message = "category must be one of the documented enum values."
  }
}

variable "created_date_time" {
  description = "The time when Microsoft Entra Health monitoring generated the alert. Supports $orderby."
  type        = string
  default     = null
}

variable "documentation" {
  description = "A key-value pair that contains the name of and link to the documentation to aid in investigation of the alert."
  type        = any
  default     = null
}

variable "enrichment" {
  description = "Investigative information on the alert. This information typically includes counts of impacted objects, which include directory objects such as users, groups, and devices, and a pointer to supporting data."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.healthMonitoring.alert"
  nullable    = false
}

variable "scenario" {
  description = "Microsoft Graph scenario property."
  type        = string
  default     = null

  validation {
    condition     = var.scenario == null ? true : contains(["unknown", "mfa", "devices", "unknownFutureValue", "conditionalAccess", "saml", "gsa"], var.scenario)
    error_message = "scenario must be one of the documented enum values."
  }
}

variable "signals" {
  description = "The collection of signals that were used in the generation of the alert. These signals are sourced from serviceActivity APIs and are added to the alert as key-value pairs."
  type        = any
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["active", "resolved", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
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
