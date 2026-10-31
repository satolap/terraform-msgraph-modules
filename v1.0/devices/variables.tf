variable "accountEnabled" {
  description = "true if the account is enabled; otherwise, false. Required. Default is true.  Supports $filter (eq, ne, not, in). Only callers with at least the Cloud Device Administrator role can set this property."
  type        = bool
  default     = null
}

variable "alternativeSecurityIds" {
  description = "For internal use only. Not nullable. Supports $filter (eq, not, ge, le)."
  type = list(object({
    odata_type       = optional(string, "#microsoft.graph.alternativeSecurityId")
    identityProvider = optional(string)
    key              = optional(string)
    type             = optional(number)
  }))
  default = null
}

variable "deletedDateTime" {
  description = "Date and time when this object was deleted. Always null when the object hasn't been deleted."
  type        = string
  default     = null
}

variable "deviceCategory" {
  description = "User-defined property set by Intune to automatically add devices to groups and simplify managing devices."
  type        = string
  default     = null
}

variable "deviceId" {
  description = "Unique identifier set by Azure Device Registration Service at the time of registration. This alternate key can be used to reference the device object. Supports $filter (eq, ne, not, startsWith)."
  type        = string
  default     = null
}

variable "deviceMetadata" {
  description = "For internal use only. Set to null."
  type        = string
  default     = null
}

variable "deviceOwnership" {
  description = "Ownership of the device. Intune sets this property. The possible values are: unknown, company, personal."
  type        = string
  default     = null
}

variable "deviceVersion" {
  description = "For internal use only."
  type        = number
  default     = null
}

variable "displayName" {
  description = "The display name for the device. Maximum length is 256 characters. Required. Supports $filter (eq, ne, not, ge, le, in, startsWith, and eq on null values), $search, and $orderby."
  type        = string
  default     = null
}

variable "enrollmentProfileName" {
  description = "Enrollment profile applied to the device. For example, Apple Device Enrollment Profile, Device enrollment - Corporate device identifiers, or Windows Autopilot profile name. This property is set by Intune."
  type        = string
  default     = null
}

variable "enrollmentType" {
  description = "Enrollment type of the device. Intune sets this property. The possible values are: unknown, userEnrollment, deviceEnrollmentManager, appleBulkWithUser, appleBulkWithoutUser, windowsAzureADJoin, windowsBulkUserless, windowsAutoEnrollment, windowsBulkAzureDomainJoin, windowsCoManagement, windowsAzureADJoinUsingDeviceAuth,appleUserEnrollment, appleUserEnrollmentWithServiceAccount. NOTE: This property might return other values apart from those listed."
  type        = string
  default     = null
}

variable "isManaged" {
  description = "true if the device is managed by a Mobile Device Management (MDM) app; otherwise, false. This can only be updated by Intune for any device OS type or by an approved MDM app for Windows OS devices. Supports $filter (eq, ne, not)."
  type        = bool
  default     = null
}

variable "isRooted" {
  description = "true if the device is rooted or jail-broken. This property can only be updated by Intune."
  type        = bool
  default     = null
}

variable "managementType" {
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

variable "operatingSystem" {
  description = "The type of operating system on the device. Required. Supports $filter (eq, ne, not, ge, le, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "operatingSystemVersion" {
  description = "The version of the operating system on the device. Required. Supports $filter (eq, ne, not, ge, le, startsWith, and eq on null values)."
  type        = string
  default     = null
}

variable "physicalIds" {
  description = "For internal use only. Not nullable. Supports $filter (eq, not, ge, le, startsWith,/$count eq 0, /$count ne 0)."
  type        = list(string)
  default     = null
}

variable "profileType" {
  description = "The profile type of the device. Possible values: RegisteredDevice (default), SecureVM, Printer, Shared, IoT."
  type        = string
  default     = null
}

variable "systemLabels" {
  description = "List of labels applied to the device by the system. Supports $filter (/$count eq 0, /$count ne 0)."
  type        = list(string)
  default     = null
}

variable "transitiveMemberOf" {
  description = "Groups and administrative units that the device is a member of. This operation is transitive. Supports $expand."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["approximateLastSignInDateTime", "complianceExpirationDateTime", "extensions", "id", "isCompliant", "isManagementRestricted", "manufacturer", "mdmAppId", "memberOf", "model", "onPremisesLastSyncDateTime", "onPremisesSecurityIdentifier", "onPremisesSyncEnabled", "registeredOwners", "registeredUsers", "registrationDateTime", "trustType"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
