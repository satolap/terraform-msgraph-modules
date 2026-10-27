variable "windows_defender_application_control_supplemental_policy_id" {
  description = "The unique identifier of windowsDefenderApplicationControlSupplementalPolicy"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.windows_defender_application_control_supplemental_policy_id)) > 0
    error_message = "windows_defender_application_control_supplemental_policy_id must not be empty."
  }
}

variable "deployment_status" {
  description = "Enum values for the various WindowsDefenderApplicationControl supplemental policy deployment statuses."
  type        = string
  default     = null

  validation {
    condition     = var.deployment_status == null ? true : contains(["unknown", "success", "tokenError", "notAuthorizedByToken", "policyNotFound"], var.deployment_status)
    error_message = "deployment_status must be one of the documented enum values."
  }
}

variable "device_id" {
  description = "Device ID."
  type        = string
  default     = null
}

variable "device_name" {
  description = "Device name."
  type        = string
  default     = null
}

variable "last_sync_date_time" {
  description = "Last sync date time."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.windowsDefenderApplicationControlSupplementalPolicyDeploymentStatus"
  nullable    = false
}

variable "os_description" {
  description = "Windows OS Version Description."
  type        = string
  default     = null
}

variable "os_version" {
  description = "Windows OS Version."
  type        = string
  default     = null
}

variable "policy" {
  description = "The navigation link to the WindowsDefenderApplicationControl supplemental policy."
  type        = any
  default     = null
}

variable "policy_version" {
  description = "Human readable version of the WindowsDefenderApplicationControl supplemental policy."
  type        = string
  default     = null
}

variable "user_name" {
  description = "The name of the user of this device."
  type        = string
  default     = null
}

variable "user_principal_name" {
  description = "User Principal Name."
  type        = string
  default     = null
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
