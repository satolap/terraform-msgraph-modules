variable "apple_id" {
  description = "The apple Id associated with the given Apple Volume Purchase Program Token."
  type        = string
  default     = null
}

variable "automatically_update_apps" {
  description = "Whether or not apps for the VPP token will be automatically updated."
  type        = bool
  default     = null
}

variable "country_or_region" {
  description = "Whether or not apps for the VPP token will be automatically updated."
  type        = string
  default     = null
}

variable "expiration_date_time" {
  description = "The expiration date time of the Apple Volume Purchase Program Token."
  type        = string
  default     = null
}

variable "last_modified_date_time" {
  description = "Last modification date time associated with the Apple Volume Purchase Program Token."
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "The last time when an application sync was done with the Apple volume purchase program service using the the Apple Volume Purchase Program Token."
  type        = string
  default     = null
}

variable "last_sync_status" {
  description = "Possible sync statuses associated with an Apple Volume Purchase Program token."
  type        = string
  default     = null

  validation {
    condition     = var.last_sync_status == null ? true : contains(["none", "inProgress", "completed", "failed"], var.last_sync_status)
    error_message = "last_sync_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.vppToken"
  nullable    = false
}

variable "organization_name" {
  description = "The organization associated with the Apple Volume Purchase Program Token"
  type        = string
  default     = null
}

variable "state" {
  description = "Possible states associated with an Apple Volume Purchase Program token."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "valid", "expired", "invalid", "assignedToExternalMDM"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "token" {
  description = "The Apple Volume Purchase Program Token string downloaded from the Apple Volume Purchase Program."
  type        = string
  default     = null
}

variable "vpp_token_account_type" {
  description = "Possible types of an Apple Volume Purchase Program token."
  type        = string
  default     = null

  validation {
    condition     = var.vpp_token_account_type == null ? true : contains(["business", "education"], var.vpp_token_account_type)
    error_message = "vpp_token_account_type must be one of the documented enum values."
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
