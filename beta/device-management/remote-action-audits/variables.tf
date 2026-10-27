variable "action" {
  description = "Remote actions Intune supports."
  type        = string
  default     = null

  validation {
    condition     = var.action == null ? true : contains(["unknown", "factoryReset", "removeCompanyData", "resetPasscode", "remoteLock", "enableLostMode", "disableLostMode", "locateDevice", "rebootNow", "recoverPasscode", "cleanWindowsDevice", "logoutSharedAppleDeviceActiveUser", "quickScan", "fullScan", "windowsDefenderUpdateSignatures", "factoryResetKeepEnrollmentData", "updateDeviceAccount", "automaticRedeployment", "shutDown", "rotateBitLockerKeys", "rotateFileVaultKey", "getFileVaultKey", "setDeviceName", "activateDeviceEsim", "deprovision", "disable", "reenable", "moveDeviceToOrganizationalUnit", "initiateMobileDeviceManagementKeyRecovery", "initiateOnDemandProactiveRemediation", "rotateLocalAdminPassword"], var.action)
    error_message = "action must be one of the documented enum values."
  }
}

variable "action_state" {
  description = "Action state."
  type        = string
  default     = null

  validation {
    condition     = var.action_state == null ? true : contains(["none", "pending", "canceled", "active", "done", "failed", "notSupported"], var.action_state)
    error_message = "action_state must be one of the documented enum values."
  }
}

variable "bulk_device_action_id" {
  description = "BulkAction ID"
  type        = string
  default     = null
}

variable "device_action_category" {
  description = "Enum type used for DeviceActionCategory"
  type        = string
  default     = null

  validation {
    condition     = var.device_action_category == null ? true : contains(["single", "bulk"], var.device_action_category)
    error_message = "device_action_category must be one of the documented enum values."
  }
}

variable "device_display_name" {
  description = "Intune device name."
  type        = string
  default     = null
}

variable "device_imei" {
  description = "IMEI of the device."
  type        = string
  default     = null
}

variable "device_owner_user_principal_name" {
  description = "Upn of the device owner."
  type        = string
  default     = null
}

variable "initiated_by_user_principal_name" {
  description = "User who initiated the device action, format is UPN."
  type        = string
  default     = null
}

variable "managed_device_id" {
  description = "Action target."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.remoteActionAudit"
  nullable    = false
}

variable "request_date_time" {
  description = "Time when the action was issued, given in UTC."
  type        = string
  default     = null
}

variable "user_name" {
  description = "[deprecated] Please use InitiatedByUserPrincipalName instead."
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
