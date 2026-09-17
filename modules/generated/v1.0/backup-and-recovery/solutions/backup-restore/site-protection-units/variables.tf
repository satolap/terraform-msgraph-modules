variable "created_by" {
  description = "The identity of the person who created the protection unit."
  type        = any
  default     = null
}

variable "created_date_time" {
  description = "The time of creation of the protection unit. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "error" {
  description = "Contains error details if an error occurred while creating a protection unit."
  type        = any
  default     = null
}

variable "last_modified_by" {
  description = "The identity of person who last modified the protection unit."
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Timestamp of the last modification of this protection unit. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.siteProtectionUnit"
  nullable    = false
}

variable "offboard_requested_date_time" {
  description = "The date and time when protection unit offboard was requested. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "policy_id" {
  description = "The unique identifier of the protection policy based on which protection unit was created."
  type        = string
  default     = null
}

variable "protection_sources" {
  description = "Microsoft Graph protectionSources property."
  type        = string
  default     = null

  validation {
    condition     = var.protection_sources == null ? true : contains(["none", "manual", "dynamicRule", "unknownFutureValue"], var.protection_sources)
    error_message = "protection_sources must be one of the documented enum values."
  }
}

variable "site_id" {
  description = "Unique identifier of the SharePoint site."
  type        = string
  default     = null
}

variable "status" {
  description = "The status of the protection unit. The possible values are: protectRequested, protected, unprotectRequested, unprotected, removeRequested, unknownFutureValue, offboardRequested, offboarded, cancelOffboardRequested. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: offboardRequested, offboarded, cancelOffboardRequested."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["protectRequested", "protected", "unprotectRequested", "unprotected", "removeRequested", "unknownFutureValue", "offboardRequested", "offboarded", "cancelOffboardRequested"], var.status)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "siteName", "siteWebUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
