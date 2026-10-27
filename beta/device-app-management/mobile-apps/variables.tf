variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.androidAospReferencedApp", "#microsoft.graph.androidForWorkApp", "#microsoft.graph.androidLobApp", "#microsoft.graph.androidManagedStoreApp", "#microsoft.graph.androidManagedStoreWebApp", "#microsoft.graph.androidStoreApp", "#microsoft.graph.iosLobApp", "#microsoft.graph.iosStoreApp", "#microsoft.graph.iosVppApp", "#microsoft.graph.iosiPadOSWebClip", "#microsoft.graph.macOSDmgApp", "#microsoft.graph.macOSLobApp", "#microsoft.graph.macOSMicrosoftDefenderApp", "#microsoft.graph.macOSMicrosoftEdgeApp", "#microsoft.graph.macOSOfficeSuiteApp", "#microsoft.graph.macOSPkgApp", "#microsoft.graph.macOSWebClip", "#microsoft.graph.macOsVppApp", "#microsoft.graph.managedAndroidLobApp", "#microsoft.graph.managedAndroidStoreApp", "#microsoft.graph.managedIOSLobApp", "#microsoft.graph.managedIOSStoreApp", "#microsoft.graph.microsoftStoreForBusinessApp", "#microsoft.graph.officeSuiteApp", "#microsoft.graph.webApp", "#microsoft.graph.win32CatalogApp", "#microsoft.graph.win32LobApp", "#microsoft.graph.winGetApp", "#microsoft.graph.windowsAppX", "#microsoft.graph.windowsAutoUpdateCatalogApp", "#microsoft.graph.windowsMicrosoftEdgeApp", "#microsoft.graph.windowsMobileMSI", "#microsoft.graph.windowsPhone81AppX", "#microsoft.graph.windowsPhone81AppXBundle", "#microsoft.graph.windowsPhone81StoreApp", "#microsoft.graph.windowsPhoneXAP", "#microsoft.graph.windowsStoreApp", "#microsoft.graph.windowsUniversalAppX", "#microsoft.graph.windowsWebApp"], var.odata_type)
    error_message = "odata_type must name a concrete Graph type."
  }
}

variable "assignments" {
  description = "The list of group assignments for this mobile app."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.mobileAppAssignment")
    intent     = optional(string)
    settings   = optional(any)
    target     = optional(any)
  }))
  default = null

  validation {
    condition     = (var.assignments == null ? true : alltrue([alltrue([for input0 in var.assignments : (input0 == null ? true : alltrue([(input0["intent"] == null ? true : alltrue([(input0["intent"] == null ? true : contains(["available", "required", "uninstall", "availableWithoutEnrollment"], input0["intent"]))]))]))])]))
    error_message = "assignments: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "categories" {
  description = "The list of categories for this app."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.mobileAppCategory")
    displayName = optional(string)
  }))
  default = null
}

variable "description" {
  description = "The description of the app."
  type        = string
  default     = null
}

variable "developer" {
  description = "The developer of the app."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The admin provided or imported title of the app."
  type        = string
  default     = null
}

variable "information_url" {
  description = "The more information Url."
  type        = string
  default     = null
}

variable "is_featured" {
  description = "The value indicating whether the app is marked as featured by the admin."
  type        = bool
  default     = null
}

variable "large_icon" {
  description = "The large icon, to be displayed in the app details and used for upload of the icon."
  type = object({
    odata_type = optional(string, "#microsoft.graph.mimeContent")
    type       = optional(string)
    value      = optional(string)
  })
  default = null
}

variable "notes" {
  description = "Notes for the app."
  type        = string
  default     = null
}

variable "owner" {
  description = "The owner of the app."
  type        = string
  default     = null
}

variable "privacy_information_url" {
  description = "The privacy statement Url."
  type        = string
  default     = null
}

variable "publisher" {
  description = "The publisher of the app."
  type        = string
  default     = null
}

variable "relationships" {
  description = "The set of direct relationships for this app."
  type        = any
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of scope tag ids for this mobile app."
  type        = list(string)
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "dependentAppCount", "id", "isAssigned", "lastModifiedDateTime", "publishingState", "supersededAppCount", "supersedingAppCount", "uploadState"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
