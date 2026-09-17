variable "account_id" {
  description = "Tenant GUID the enrollment profile belongs to."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Date time the enrollment profile was created."
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the enrollment profile."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Display name for the enrollment profile."
  type        = string
  default     = null
}

variable "enrolled_device_count" {
  description = "Total number of Android devices that have enrolled using this enrollment profile."
  type        = number
  default     = null
}

variable "last_modified_date_time" {
  description = "Date time the enrollment profile was last modified."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.androidForWorkEnrollmentProfile"
  nullable    = false
}

variable "qr_code_content" {
  description = "String used to generate a QR code for the token."
  type        = string
  default     = null
}

variable "qr_code_image" {
  description = "String used to generate a QR code for the token."
  type        = any
  default     = null
}

variable "token_expiration_date_time" {
  description = "Date time the most recently created token will expire."
  type        = string
  default     = null
}

variable "token_value" {
  description = "Value of the most recently created token for this enrollment profile."
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
