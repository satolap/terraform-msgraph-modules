variable "account_enabled" {
  description = "true if the account is enabled; otherwise, false. Required. Default is true.  Supports $filter (eq, ne, not, in). Only callers with at least the Cloud Device Administrator role can set this property."
  type        = bool
  default     = null
}

variable "alternative_security_ids" {
  description = "For internal use only. Not nullable. Supports $filter (eq, not, ge, le)."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.alternativeSecurityId")
    identityProvider = optional(string)
    key              = optional(string)
    type             = optional(number)
  }))
  default = null
}

variable "deleted_date_time" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "device_category" {
  description = "User-defined property set by Intune to automatically add devices to groups and simplify managing devices."
  type        = string
  default     = null
}

variable "device_id" {
  description = "Unique identifier set by Azure Device Registration Service at the time of registration. This alternate key can be used to reference the device object. Supports $filter (eq, ne, not, startsWith)."
  type        = string
  default     = null
}

variable "device_metadata" {
  description = "For internal use only. Set to null."
  type        = string
  default     = null
}

variable "device_ownership" {
  description = "Ownership of the device. Intune sets this property. The possible values are: unknown, company, personal."
  type        = string
  default     = null
}

variable "device_version" {
  description = "For internal use only."
  type        = number
  default     = null
}

variable "display_name" {
  description = "The display name for the device. Maximum length is 256 characters. Required. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  default     = null
}

variable "enrollment_profile_name" {
  description = "Enrollment profile applied to the device. For example, Apple Device Enrollment Profile, Device enrollment - Corporate device identifiers, or Windows Autopilot profile name. This property is set by Intune."
  type        = string
  default     = null
}

variable "enrollment_type" {
  description = "Enrollment type of the device. Intune sets this property. The possible values are: unknown, userEnrollment, deviceEnrollmentManager, appleBulkWithUser, appleBulkWithoutUser, windowsAzureADJoin, windowsBulkUserless, windowsAutoEnrollment, windowsBulkAzureDomainJoin, windowsCoManagement, windowsAzureADJoinUsingDeviceAuth,appleUserEnrollment, appleUserEnrollmentWithServiceAccount. NOTE: This property might return other values apart from those listed."
  type        = string
  default     = null
}

variable "is_managed" {
  description = "true if the device is managed by a Mobile Device Management (MDM) app; otherwise, false. This can only be updated by Intune for any device OS type or by an approved MDM app for Windows OS devices. Supports $filter (eq, ne, not)."
  type        = bool
  default     = null
}

variable "is_rooted" {
  description = "true if the device is rooted or jail-broken. This property can only be updated by Intune."
  type        = bool
  default     = null
}

variable "management_type" {
  description = "The management channel of the device. This property is set by Intune. The possible values are: eas, mdm, easMdm, intuneClient, easIntuneClient, configurationManagerClient, configurationManagerClientMdm, configurationManagerClientMdmEas, unknown, jamf, googleCloudDevicePolicyController."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.device"
  nullable    = false
}

variable "operating_system" {
  description = "The type of operating system on the device. Required. Supports $filter (eq, ne, not, ge, le, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "operating_system_version" {
  description = "The version of the operating system on the device. Required. Supports $filter (eq, ne, not, ge, le, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "physical_ids" {
  description = "For internal use only. Not nullable. Supports $filter (eq, not, ge, le, startsWith,/$count eq 0, /$count ne 0)."
  type        = list(string)
  default     = null
}

variable "profile_type" {
  description = "The profile type of the device. Possible values: RegisteredDevice (default), SecureVM, Printer, Shared, IoT."
  type        = string
  default     = null
}

variable "system_labels" {
  description = "List of labels applied to the device by the system. Supports $filter (/$count eq 0, /$count ne 0)."
  type        = list(string)
  default     = null
}

variable "transitive_member_of" {
  description = "Groups and administrative units that the device is a member of. This operation is transitive. Supports $expand."
  type = list(object({
    odata_type      = optional(string, "#microsoft.graph.directoryObject")
    deletedDateTime = optional(string)
  }))
  default = null
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["approximateLastSignInDateTime", "complianceExpirationDateTime", "extensions", "id", "isCompliant", "isManagementRestricted", "manufacturer", "mdmAppId", "memberOf", "model", "onPremisesLastSyncDateTime", "onPremisesSecurityIdentifier", "onPremisesSyncEnabled", "registeredOwners", "registeredUsers", "registrationDateTime", "trustType"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
