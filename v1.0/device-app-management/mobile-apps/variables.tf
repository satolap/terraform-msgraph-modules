variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  nullable    = false

  validation {
    condition     = var.odata_type == null ? true : contains(["#microsoft.graph.androidLobApp", "#microsoft.graph.androidStoreApp", "#microsoft.graph.iosLobApp", "#microsoft.graph.iosStoreApp", "#microsoft.graph.iosVppApp", "#microsoft.graph.iosiPadOSWebClip", "#microsoft.graph.macOSDmgApp", "#microsoft.graph.macOSLobApp", "#microsoft.graph.macOSMicrosoftDefenderApp", "#microsoft.graph.macOSMicrosoftEdgeApp", "#microsoft.graph.macOSOfficeSuiteApp", "#microsoft.graph.managedAndroidLobApp", "#microsoft.graph.managedAndroidStoreApp", "#microsoft.graph.managedIOSLobApp", "#microsoft.graph.managedIOSStoreApp", "#microsoft.graph.microsoftStoreForBusinessApp", "#microsoft.graph.webApp", "#microsoft.graph.win32LobApp", "#microsoft.graph.windowsAppX", "#microsoft.graph.windowsMicrosoftEdgeApp", "#microsoft.graph.windowsMobileMSI", "#microsoft.graph.windowsUniversalAppX", "#microsoft.graph.windowsWebApp"], var.odata_type)
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

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["createdDateTime", "id", "lastModifiedDateTime", "publishingState"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
