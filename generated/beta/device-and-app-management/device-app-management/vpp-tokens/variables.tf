variable "apple_device_app_delivery_protocol_type" {
  description = "Enum of the supported types of Apple delivery protocols, representing the available protocols to deliver payloads to Apple devices"
  type        = string
  default     = null

  validation {
    condition     = var.apple_device_app_delivery_protocol_type == null ? true : contains(["default", "mobileDeviceManagement", "declarativeDeviceManagement", "unknownFutureValue"], var.apple_device_app_delivery_protocol_type)
    error_message = "apple_device_app_delivery_protocol_type must be one of the documented enum values."
  }
}

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

variable "claim_token_management_from_external_mdm" {
  description = "Admin consent to allow claiming token management from external MDM."
  type        = bool
  default     = null
}

variable "country_or_region" {
  description = "Whether or not apps for the VPP token will be automatically updated."
  type        = string
  default     = null
}

variable "data_sharing_consent_granted" {
  description = "Consent granted for data sharing with the Apple Volume Purchase Program."
  type        = bool
  default     = null
}

variable "display_name" {
  description = "An admin specified token friendly name."
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

variable "location_name" {
  description = "Token location returned from Apple VPP."
  type        = string
  default     = null
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

variable "role_scope_tag_ids" {
  description = "Role Scope Tags IDs assigned to this entity."
  type        = list(string)
  default     = null
}

variable "state" {
  description = "Possible states associated with an Apple Volume Purchase Program token."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["unknown", "valid", "expired", "invalid", "assignedToExternalMDM", "duplicateLocationId"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "token" {
  description = "The Apple Volume Purchase Program Token string downloaded from the Apple Volume Purchase Program."
  type        = string
  default     = null
}

variable "token_action_results" {
  description = "The collection of statuses of the actions performed on the Apple Volume Purchase Program Token."
  type = list(object({
    odata_type          = optional(string, "#microsoft.graph.vppTokenActionResult")
    actionName          = optional(string)
    actionState         = optional(string)
    lastUpdatedDateTime = optional(string)
    startDateTime       = optional(string)
  }))
  default = null
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
