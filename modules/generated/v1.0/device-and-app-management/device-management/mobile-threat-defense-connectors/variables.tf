variable "allow_partner_to_collect_ios_application_metadata" {
  description = "When TRUE, indicates the Mobile Threat Defense partner may collect metadata about installed applications from Intune for iOS devices. When FALSE, indicates the Mobile Threat Defense partner may not collect metadata about installed applications from Intune for iOS devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "allow_partner_to_collect_ios_personal_application_metadata" {
  description = "When TRUE, indicates the Mobile Threat Defense partner may collect metadata about personally installed applications from Intune for iOS devices. When FALSE, indicates the Mobile Threat Defense partner may not collect metadata about personally installed applications from Intune for iOS devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "android_device_blocked_on_missing_partner_data" {
  description = "When TRUE, indicates that Intune must receive data from the Mobile Threat Defense partner prior to marking an Android device compliant. When FALSE, indicates that Intune may mark an Android device compliant before receiving data from the Mobile Threat Defense partner."
  type        = bool
  default     = null
}

variable "android_enabled" {
  description = "When TRUE, indicates that data from the Mobile Threat Defense partner will be used during compliance evaluations for Android devices. When FALSE, indicates that data from the Mobile Threat Defense partner will not be used during compliance evaluations for Android devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "android_mobile_application_management_enabled" {
  description = "When TRUE, inidicates that data from the Mobile Threat Defense partner can be used during Mobile Application Management (MAM) evaluations for Android devices. When FALSE, inidicates that data from the Mobile Threat Defense partner should not be used during Mobile Application Management (MAM) evaluations for Android devices. Only one partner per platform may be enabled for Mobile Application Management (MAM) evaluation. Default value is FALSE."
  type        = bool
  default     = null
}

variable "ios_device_blocked_on_missing_partner_data" {
  description = "When TRUE, indicates that Intune must receive data from the Mobile Threat Defense partner prior to marking a device compliant. When FALSE, indicates that Intune may not recieve data from Mobile Threat Defense partner prior to making device compliant. Default value is FALSE."
  type        = bool
  default     = null
}

variable "ios_enabled" {
  description = "When TRUE, indicates that data from the Mobile Threat Defense partner will be used during compliance evaluations for iOS devices. When FALSE, indicates that data from the Mobile Threat Defense partner will not be used during compliance evaluations for iOS devices. Default value is FALSE."
  type        = bool
  default     = null
}

variable "ios_mobile_application_management_enabled" {
  description = "When TRUE, inidicates that data from the Mobile Threat Defense partner can be used during Mobile Application Management (MAM) evaluations for iOS devices. When FALSE, inidicates that data from the Mobile Threat Defense partner should not be used during Mobile Application Management (MAM) evaluations for iOS devices. Only one partner per platform may be enabled for Mobile Application Management (MAM) evaluation. Default value is FALSE."
  type        = bool
  default     = null
}

variable "last_heartbeat_date_time" {
  description = "DateTime of last Heartbeat recieved from the Mobile Threat Defense partner"
  type        = string
  default     = null
}

variable "microsoft_defender_for_endpoint_attach_enabled" {
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

variable "partner_state" {
  description = "Partner state of this tenant."
  type        = string
  default     = null

  validation {
    condition     = var.partner_state == null ? true : contains(["unavailable", "available", "enabled", "unresponsive", "unknownFutureValue"], var.partner_state)
    error_message = "partner_state must be one of the documented enum values."
  }
}

variable "partner_unresponsiveness_threshold_in_days" {
  description = "Indicates the number of days without receiving a heartbeat from a Mobile Threat Defense partner before the partner is marked as unresponsive. Intune will the ignore the data from this Mobile Threat Defense Partner for next compliance calculation."
  type        = number
  default     = null
}

variable "partner_unsupported_os_version_blocked" {
  description = "When TRUE, indicates that Intune will mark devices noncompliant on enabled platforms that do not meet the minimum version requirements of the Mobile Threat Defense partner. When FALSE, indicates that Intune will not mark devices noncompliant on enabled platforms that do not meet the minimum version requirements of the Mobile Threat Defense partner. Default value is FALSE."
  type        = bool
  default     = null
}

variable "windows_device_blocked_on_missing_partner_data" {
  description = "When TRUE, indicates that Intune must receive data from the data sync partner prior to marking a device compliant for Windows. When FALSE, indicates that Intune may mark a device compliant without receiving data from the data sync partner for Windows. Default value is FALSE."
  type        = bool
  default     = null
}

variable "windows_enabled" {
  description = "When TRUE, indicates that data from the Mobile Threat Defense partner will be used during compliance evaluations for Windows. When FALSE, indicates that data from the Mobile Threat Defense partner will not be used during compliance evaluations for Windows. Default value is FALSE."
  type        = bool
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
