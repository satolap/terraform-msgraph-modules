variable "access_package_resource" {
  description = "Microsoft Graph accessPackageResource property."
  type        = any
  default     = null
}

variable "catalog_id" {
  description = "The unique ID of the access package catalog."
  type        = string
  default     = null
}

variable "execute_immediately" {
  description = "Microsoft Graph executeImmediately property."
  type        = bool
  default     = null
}

variable "expiration_date_time" {
  description = "The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z"
  type        = string
  default     = null
}

variable "is_validation_only" {
  description = "If set, doesn't add the resource."
  type        = bool
  default     = null
}

variable "justification" {
  description = "The requestor's justification for adding or removing the resource."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageResourceRequest"
  nullable    = false
}

variable "request_status" {
  description = "Microsoft Graph requestStatus property."
  type        = string
  default     = null
}

variable "request_type" {
  description = "Use AdminAdd to add a resource, if the caller is an administrator or resource owner, AdminUpdate to update a resource, or AdminRemove to remove a resource."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "requestState", "requestor"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
