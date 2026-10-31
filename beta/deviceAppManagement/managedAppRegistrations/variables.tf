variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.androidManagedAppRegistration", "#microsoft.graph.iosManagedAppRegistration", "#microsoft.graph.windowsManagedAppRegistration"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "appIdentifier" {
  description = "The app package Identifier"
  type        = any
  default     = null
}

variable "applicationVersion" {
  description = "App version"
  type        = string
  default     = null
}

variable "appliedPolicies" {
  description = "Zero or more policys already applied on the registered app when it last synchronized with managment service."
  type        = any
  default     = null
}

variable "azureADDeviceId" {
  description = "The Azure Active Directory Device identifier of the host device. Value could be empty even when the host device is Azure Active Directory registered."
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "Date and time of creation"
  type        = string
  default     = null
}

variable "deviceManufacturer" {
  description = "The device manufacturer for the current app registration"
  type        = string
  default     = null
}

variable "deviceModel" {
  description = "The device model for the current app registration"
  type        = string
  default     = null
}

variable "deviceName" {
  description = "Host device name"
  type        = string
  default     = null
}

variable "deviceTag" {
  description = "App management SDK generated tag, which helps relate apps hosted on the same device. Not guaranteed to relate apps in all conditions."
  type        = string
  default     = null
}

variable "deviceType" {
  description = "Host device type"
  type        = string
  default     = null
}

variable "flaggedReasons" {
  description = "Zero or more reasons an app registration is flagged. E.g. app running on rooted device"
  type        = list(string)
  default     = null

  validation {
    condition     = (var.flaggedReasons == null ? true : alltrue([alltrue([for input0 in var.flaggedReasons : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["none", "rootedDevice", "androidBootloaderUnlocked", "androidFactoryRomModified"], input0))]))])]))
    error_message = "flaggedReasons: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "graph_version" {
  description = "Version of the entity."
  type        = string
  default     = null
}

variable "intendedPolicies" {
  description = "Zero or more policies admin intended for the app as of now."
  type        = any
  default     = null
}

variable "lastSyncDateTime" {
  description = "Date and time of last the app synced with management service."
  type        = string
  default     = null
}

variable "managedAppLogCollectionRequests" {
  description = "Zero or more log collection requests triggered for the app."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedAppLogCollectionRequest")
    userLogUploadConsent = optional(string)
    version              = optional(string)
  }))
  default = null

  validation {
    condition     = (var.managedAppLogCollectionRequests == null ? true : alltrue([alltrue([for input0 in var.managedAppLogCollectionRequests : (input0 == null ? true : alltrue([(input0["userLogUploadConsent"] == null ? true : alltrue([(input0["userLogUploadConsent"] == null ? true : contains(["unknown", "declined", "accepted"], input0["userLogUploadConsent"]))]))]))])]))
    error_message = "managedAppLogCollectionRequests: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "managedDeviceId" {
  description = "The Managed Device identifier of the host device. Value could be empty even when the host device is managed."
  type        = string
  default     = null
}

variable "managementSdkVersion" {
  description = "App management SDK version"
  type        = string
  default     = null
}

variable "operations" {
  description = "Zero or more long running operations triggered on the app registration."
  type = list(object({
    odata_type           = optional(string, "#microsoft.graph.managedAppOperation")
    displayName          = optional(string)
    lastModifiedDateTime = optional(string)
    state                = optional(string)
    version              = optional(string)
  }))
  default = null
}

variable "platformVersion" {
  description = "Operating System version"
  type        = string
  default     = null
}

variable "userId" {
  description = "The user Id to who this app registration belongs."
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
