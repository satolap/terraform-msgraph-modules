variable "activity_logs" {
  description = "Represents the activity by a partner and includes details of state transitions, who performed them, and when they occurred."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.partner.security.activityLog")
    statusFrom      = optional(string)
    statusTo        = optional(string)
    updatedBy       = optional(string)
    updatedDateTime = optional(string)
  }))
  default = null
}

variable "additional_details" {
  description = "A bag of name-value pairs that contain more details about an alert."
  type        = any
  default     = null
}

variable "affected_resources" {
  description = "Contains details of the resources affected by the security alert."
  type = list(object({
    odata_type   = optional(string, "#microsoft.graph.partner.security.affectedResource")
    resourceId   = optional(string)
    resourceType = optional(string)
  }))
  default = null
}

variable "alert_type" {
  description = "The type of vulnerability that impacts the customer due to this alert. For more information, see Security alerts reference guide."
  type        = string
  default     = null
}

variable "catalog_offer_id" {
  description = "The modern offer category ID of the subscription."
  type        = string
  default     = null
}

variable "confidence_level" {
  description = "Microsoft Graph confidenceLevel property."
  type        = string
  default     = null

  validation {
    condition     = var.confidence_level == null ? true : contains(["low", "medium", "high", "unknownFutureValue"], var.confidence_level)
    error_message = "confidence_level must be one of the documented enum values."
  }
}

variable "customer_tenant_id" {
  description = "The impacted customer tenant associated with the alert."
  type        = string
  default     = null
}

variable "description" {
  description = "The description for each alert."
  type        = string
  default     = null
}

variable "detected_date_time" {
  description = "Time when the alert was detected or created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name of the alert."
  type        = string
  default     = null
}

variable "first_observed_date_time" {
  description = "Time of the first activity associated with the alert. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "is_test" {
  description = "Indicates whether an alert is a test alert."
  type        = bool
  default     = null
}

variable "last_observed_date_time" {
  description = "Time of the latest activity associated with the alert. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.partner.security.partnerSecurityAlert"
  nullable    = false
}

variable "resolved_by" {
  description = "The UPN of the partner user who resolved the alert."
  type        = string
  default     = null
}

variable "resolved_on_date_time" {
  description = "Time when the alert was resolved. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "resolved_reason" {
  description = "The reason provided by the partner for addressing the alert. The possible values are: legitimate, ignore, fraud, unknownFutureValue."
  type        = any
  default     = null

  validation {
    condition     = var.resolved_reason == null ? true : contains(["legitimate", "ignore", "fraud", "unknownFutureValue"], var.resolved_reason)
    error_message = "resolved_reason must be one of the documented enum values."
  }
}

variable "severity" {
  description = "Microsoft Graph severity property."
  type        = string
  default     = null

  validation {
    condition     = var.severity == null ? true : contains(["informational", "high", "medium", "low", "unknownFutureValue"], var.severity)
    error_message = "severity must be one of the documented enum values."
  }
}

variable "status" {
  description = "Microsoft Graph status property."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["active", "resolved", "investigating", "unknownFutureValue"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "subscription_id" {
  description = "The subscription associated with the alert for the customer."
  type        = string
  default     = null
}

variable "value_added_reseller_tenant_id" {
  description = "The value-added reseller tenant associated with the partner tenant and customer tenant."
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
