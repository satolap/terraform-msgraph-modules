variable "allowPartnerToCollectIOSApplicationMetadata" {
  description = "When TRUE, indicates the Mobile Threat Defense partner may collect metadata about installed applications from Intune for iOS devices. When FALSE, indicates the Mobile Threat Defense partner may not collect metadata about installed applications from Intune for iOS devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "allowPartnerToCollectIOSPersonalApplicationMetadata" {
  description = "When TRUE, indicates the Mobile Threat Defense partner may collect metadata about personally installed applications from Intune for iOS devices. When FALSE, indicates the Mobile Threat Defense partner may not collect metadata about personally installed applications from Intune for iOS devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "androidDeviceBlockedOnMissingPartnerData" {
  description = "When TRUE, indicates that Intune must receive data from the Mobile Threat Defense partner prior to marking an Android device compliant. When FALSE, indicates that Intune may mark an Android device compliant before receiving data from the Mobile Threat Defense partner."
  type        = bool
  default     = null
}

variable "androidEnabled" {
  description = "When TRUE, indicates that data from the Mobile Threat Defense partner will be used during compliance evaluations for Android devices. When FALSE, indicates that data from the Mobile Threat Defense partner will not be used during compliance evaluations for Android devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "androidMobileApplicationManagementEnabled" {
  description = "When TRUE, inidicates that data from the Mobile Threat Defense partner can be used during Mobile Application Management (MAM) evaluations for Android devices. When FALSE, inidicates that data from the Mobile Threat Defense partner should not be used during Mobile Application Management (MAM) evaluations for Android devices. Only one partner per platform may be enabled for Mobile Application Management (MAM) evaluation. Default value is FALSE."
  type        = bool
  default     = null
}

variable "iosDeviceBlockedOnMissingPartnerData" {
  description = "When TRUE, indicates that Intune must receive data from the Mobile Threat Defense partner prior to marking a device compliant. When FALSE, indicates that Intune may not recieve data from Mobile Threat Defense partner prior to making device compliant. Default value is FALSE."
  type        = bool
  default     = null
}

variable "iosEnabled" {
  description = "When TRUE, indicates that data from the Mobile Threat Defense partner will be used during compliance evaluations for iOS devices. When FALSE, indicates that data from the Mobile Threat Defense partner will not be used during compliance evaluations for iOS devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "iosMobileApplicationManagementEnabled" {
  description = "When TRUE, inidicates that data from the Mobile Threat Defense partner can be used during Mobile Application Management (MAM) evaluations for iOS devices. When FALSE, inidicates that data from the Mobile Threat Defense partner should not be used during Mobile Application Management (MAM) evaluations for iOS devices. Only one partner per platform may be enabled for Mobile Application Management (MAM) evaluation. Default value is FALSE."
  type        = bool
  default     = null
}

variable "lastHeartbeatDateTime" {
  description = "DateTime of last Heartbeat recieved from the Mobile Threat Defense partner"
  type        = string
  default     = null
}

variable "microsoftDefenderForEndpointAttachEnabled" {
  description = "When TRUE, inidicates that configuration profile management via Microsoft Defender for Endpoint is enabled. When FALSE, inidicates that configuration profile management via Microsoft Defender for Endpoint is disabled. Default value is FALSE."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.mobileThreatDefenseConnector"
  nullable    = false
}

variable "partnerState" {
  description = "Partner state of this tenant."
  type        = string
  default     = null

  validation {
    condition     = var.partnerState == null ? true : contains(["unavailable", "available", "enabled", "unresponsive"], var.partnerState)
    error_message = "partnerState must be one of the documented enum values."
  }
}

variable "partnerUnresponsivenessThresholdInDays" {
  description = "Indicates the number of days without receiving a heartbeat from a Mobile Threat Defense partner before the partner is marked as unresponsive. Intune will the ignore the data from this Mobile Threat Defense Partner for next compliance calculation."
  type        = number
  default     = null
}

variable "partnerUnsupportedOsVersionBlocked" {
  description = "When TRUE, indicates that Intune will mark devices noncompliant on enabled platforms that do not meet the minimum version requirements of the Mobile Threat Defense partner. When FALSE, indicates that Intune will not mark devices noncompliant on enabled platforms that do not meet the minimum version requirements of the Mobile Threat Defense partner. Default value is FALSE."
  type        = bool
  default     = null
}

variable "windowsDeviceBlockedOnMissingPartnerData" {
  description = "When TRUE, indicates that Intune must receive data from the data sync partner prior to marking a device compliant for Windows. When FALSE, indicates that Intune may mark a device compliant without receiving data from the data sync partner for Windows. Default value is FALSE."
  type        = bool
  default     = null
}

variable "windowsEnabled" {
  description = "When TRUE, indicates that data from the Mobile Threat Defense partner will be used during compliance evaluations for Windows. When FALSE, indicates that data from the Mobile Threat Defense partner will not be used during compliance evaluations for Windows. Default value is FALSE."
  type        = bool
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
