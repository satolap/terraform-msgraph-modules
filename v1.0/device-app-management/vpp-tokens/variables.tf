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

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
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
