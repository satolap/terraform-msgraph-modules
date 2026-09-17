variable "action_reason" {
  description = "Reason for invoking this action."
  type        = string
  default     = null
}

variable "app_id" {
  description = "The Application ID of the calling application that submitted (POST) the action. The appId should be extracted from the auth token and not entered manually by the calling application."
  type        = string
  default     = null
}

variable "azure_tenant_id" {
  description = "Azure tenant ID of the entity to determine which tenant the entity belongs to (multi-tenancy support). The azureTenantId should be extracted from the auth token and not entered manually by the calling application."
  type        = string
  default     = null
}

variable "client_context" {
  description = "Unique client context string. Can have a maximum of 256 characters."
  type        = string
  default     = null
}

variable "completed_date_time" {
  description = "Timestamp when the action was completed. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Timestamp when the action is created. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "error_info" {
  description = "Error info when the action fails."
  type        = any
  default     = null
}

variable "last_action_date_time" {
  description = "Timestamp when this action was last updated. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "name" {
  description = "Action name."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.securityAction"
  nullable    = false
}

variable "parameters" {
  description = "Collection of parameters (key-value pairs) necessary to invoke the action, for example, URL or fileHash to block.). Required."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "states" {
  description = "Collection of securityActionState to keep the history of an action."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.securityActionState")
    appId           = optional(string)
    status          = optional(any)
    updatedDateTime = optional(string)
    user            = optional(string)
  }))
  default = null
}

variable "status" {
  description = "Status of the action. The possible values are: NotStarted, Running, Completed, Failed."
  type        = any
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["NotStarted", "Running", "Completed", "Failed"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "user" {
  description = "The user principal name of the signed-in user that submitted  (POST) the action. The user should be extracted from the auth token and not entered manually by the calling application."
  type        = string
  default     = null
}

variable "vendor_information" {
  description = "Complex Type containing details about the Security product/service vendor, provider, and sub-provider (for example, vendor=Microsoft; provider=Windows Defender ATP; sub-provider=AppLocker)."
  type        = any
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
