variable "account_id" {
  description = "Tenant GUID the enrollment profile belongs to."
  type        = string
  default     = null
}

variable "configure_wifi" {
  description = "Boolean that indicates that the Wi-Fi network should be configured during device provisioning. When set to TRUE, device provisioning will use Wi-Fi related properties to automatically connect to Wi-Fi networks. When set to FALSE or undefined, other Wi-Fi related properties will be ignored. Default value is TRUE. Returned by default."
  type        = bool
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

variable "device_name_template" {
  description = "Indicates the device name template used for the enrolled Android devices. The maximum length allowed for this property is 63 characters. The template expression contains normal text and tokens, including the serial number of the device, user name, device type, upn prefix, or a randomly generated number. Supported Tokens for device name templates are: (for device naming template expression): {{SERIAL}}, {{SERIALLAST4DIGITS}}, {{ENROLLMENTDATETIME}}, {{USERNAME}}, {{DEVICETYPE}}, {{UPNPREFIX}}, {{rand:x}}. Supports: $select, $top, $skip. $Search, $orderBy and $filter are not supported."
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

variable "enrollment_mode" {
  description = "The enrollment mode for an enrollment profile."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_mode == null ? true : contains(["corporateOwnedDedicatedDevice", "corporateOwnedFullyManaged", "corporateOwnedWorkProfile", "corporateOwnedAOSPUserlessDevice", "corporateOwnedAOSPUserAssociatedDevice"], var.enrollment_mode)
    error_message = "enrollment_mode must be one of the documented enum values."
  }
}

variable "enrollment_token_type" {
  description = "The enrollment token type for an enrollment profile."
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_token_type == null ? true : contains(["default", "corporateOwnedDedicatedDeviceWithAzureADSharedMode", "deviceStaging"], var.enrollment_token_type)
    error_message = "enrollment_token_type must be one of the documented enum values."
  }
}

variable "enrollment_token_usage_count" {
  description = "Total number of AOSP devices that have enrolled using the current token. Valid values 0 to 20000"
  type        = number
  default     = null
}

variable "is_teams_device_profile" {
  description = "Boolean indicating if this profile is an Android AOSP for Teams device profile."
  type        = bool
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
  default     = "#microsoft.graph.androidDeviceOwnerEnrollmentProfile"
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

variable "role_scope_tag_ids" {
  description = "List of Scope Tags for this Entity instance."
  type        = list(string)
  default     = null
}

variable "token_creation_date_time" {
  description = "Date time the most recently created token was created."
  type        = string
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

variable "wifi_hidden" {
  description = "Boolean that indicates if hidden wifi networks are enabled"
  type        = bool
  default     = null
}

variable "wifi_password" {
  description = "String that contains the wi-fi login password"
  type        = string
  default     = null
  sensitive   = true
}

variable "wifi_security_type" {
  description = "This enum represents Wi-Fi Security Types for Android Device Owner AOSP Scenarios."
  type        = string
  default     = null

  validation {
    condition     = var.wifi_security_type == null ? true : contains(["none", "wpa", "wep"], var.wifi_security_type)
    error_message = "wifi_security_type must be one of the documented enum values."
  }
}

variable "wifi_ssid" {
  description = "String that contains the wi-fi login ssid"
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
