variable "group_id" {
  description = "The unique identifier of group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.group_id)) > 0
    error_message = "group_id must not be empty."
  }
}

variable "site_id" {
  description = "The unique identifier of site"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.site_id)) > 0
    error_message = "site_id must not be empty."
  }
}

variable "created_date_time" {
  description = "The start time of the operation."
  type        = string
  default     = null
}

variable "error" {
  description = "The error returned by the operation."
  type        = any
  default     = null
}

variable "last_action_date_time" {
  description = "The time of the last action of the operation."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.onenoteOperation"
  nullable    = false
}

variable "percent_complete" {
  description = "The operation percent complete if the operation is still in running status."
  type        = string
  default     = null
}

variable "resource_id" {
  description = "The resource id."
  type        = string
  default     = null
}

variable "resource_location" {
  description = "The resource URI for the object. For example, the resource URI for a copied page or section."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
