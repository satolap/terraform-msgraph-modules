variable "actions" {
  description = "List of possible action items to take based on the alert (if applicable)."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.alertAction")
    actionLink = optional(string)
    actionText = optional(string)
  }))
  default = null
}

variable "alert_type" {
  description = "Microsoft Graph alertType property."
  type        = string
  default     = null

  validation {
    condition     = var.alert_type == null ? true : contains(["unhealthyRemoteNetworks", "unhealthyConnectors", "deviceTokenInconsistency", "crossTenantAnomaly", "suspiciousProcess", "threatIntelligenceTransactions", "unknownFutureValue", "webContentBlocked", "malware", "patientZero", "dlp"], var.alert_type)
    error_message = "alert_type must be one of the documented enum values."
  }
}

variable "categories" {
  description = "Categories associated with the alert."
  type        = any
  default     = null
}

variable "component_name" {
  description = "Component name related to the alert."
  type        = string
  default     = null
}

variable "creation_date_time" {
  description = "The time the alert was created in the system. Required."
  type        = string
  default     = null
}

variable "description" {
  description = "Text description explaining the alert."
  type        = string
  default     = null
}

variable "detection_technology" {
  description = "Alert detection technology."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the alert. Required."
  type        = string
  default     = null
}

variable "extended_properties" {
  description = "Extended properties for the alert."
  type        = any
  default     = null
}

variable "first_activity_date_time" {
  description = "The time of the first activity related to the alert."
  type        = string
  default     = null
}

variable "is_preview" {
  description = "Indicates if the alert is a preview."
  type        = bool
  default     = null
}

variable "last_activity_date_time" {
  description = "The time of the last activity related to the alert."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.networkaccess.alert"
  nullable    = false
}

variable "policy" {
  description = "The filtering policy associated with the alert. This relationship allows you to retrieve or manage the filtering policy that triggered or is related to the alert instance."
  type        = any
  default     = null
}

variable "product_name" {
  description = "The name of the product that raised the alert."
  type        = string
  default     = null
}

variable "related_resources" {
  description = "List of related resources to the alert (if applicable)."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.networkaccess.relatedResource")
  }))
  default = null
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["informational", "low", "medium", "high", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "sub_techniques" {
  description = "Sub-techniques associated with the alert."
  type        = list(string)
  default     = null
}

variable "techniques" {
  description = "Techniques associated with the alert."
  type        = list(string)
  default     = null
}

variable "vendor_name" {
  description = "The name of the vendor that raised the alert."
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
