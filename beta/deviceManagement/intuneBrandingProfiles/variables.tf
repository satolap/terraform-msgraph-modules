variable "assignments" {
  description = "The list of group assignments for the branding profile"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.intuneBrandingProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "companyPortalBlockedActions" {
  description = "Collection of blocked actions on the company portal as per platform and device ownership types."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.companyPortalBlockedAction")
    action     = optional(string)
    ownerType  = optional(string)
    platform   = optional(string)
  }))
  default = null

  validation {
    condition     = (var.companyPortalBlockedActions == null ? true : alltrue([alltrue([for input0 in var.companyPortalBlockedActions : (input0 == null ? true : alltrue([(input0["action"] == null ? true : alltrue([(input0["action"] == null ? true : contains(["unknown", "remove", "reset"], input0["action"]))])), (input0["ownerType"] == null ? true : alltrue([(input0["ownerType"] == null ? true : contains(["unknown", "company", "personal"], input0["ownerType"]))])), (input0["platform"] == null ? true : alltrue([(input0["platform"] == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement"], input0["platform"]))]))]))])]))
    error_message = "companyPortalBlockedActions: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "contactITEmailAddress" {
  description = "E-mail address of the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "contactITName" {
  description = "Name of the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "contactITNotes" {
  description = "Text comments regarding the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "contactITPhoneNumber" {
  description = "Phone number of the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "createdDateTime" {
  description = "Time when the BrandingProfile was created"
  type        = string
  default     = null
}

variable "customCanSeePrivacyMessage" {
  description = "Text comments regarding what the admin has access to on the device"
  type        = string
  default     = null
}

variable "customCantSeePrivacyMessage" {
  description = "Text comments regarding what the admin doesn't have access to on the device"
  type        = string
  default     = null
}

variable "customPrivacyMessage" {
  description = "Text comments regarding what the admin doesn't have access to on the device"
  type        = string
  default     = null
}

variable "disableClientTelemetry" {
  description = "Applies to telemetry sent from all clients to the Intune service. When disabled, all proactive troubleshooting and issue warnings within the client are turned off, and telemetry settings appear inactive or hidden to the device user."
  type        = bool
  default     = null
}

variable "disableDeviceCategorySelection" {
  description = "Boolean that indicates if Device Category Selection will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "displayName" {
  description = "Company/organization name that is displayed to end users"
  type        = string
  default     = null
}

variable "enrollmentAvailability" {
  description = "Options available for enrollment flow customization"
  type        = string
  default     = null

  validation {
    condition     = var.enrollmentAvailability == null ? true : contains(["availableWithPrompts", "availableWithoutPrompts", "unavailable"], var.enrollmentAvailability)
    error_message = "enrollmentAvailability must be one of the documented enum values."
  }
}

variable "isDefaultProfile" {
  description = "Boolean that represents whether the profile is used as default or not"
  type        = bool
  default     = null
}

variable "isFactoryResetDisabled" {
  description = "Boolean that represents whether the adminsistrator has disabled the 'Factory Reset' action on corporate owned devices."
  type        = bool
  default     = null
}

variable "isRemoveDeviceDisabled" {
  description = "Boolean that represents whether the adminsistrator has disabled the 'Remove Device' action on corporate owned devices."
  type        = bool
  default     = null
}

variable "landingPageCustomizedImage" {
  description = "Customized image displayed in Company Portal apps landing page"
  type = object({
    odata_type = optional(string, "#microsoft.graph.mimeContent")
    type       = optional(string)
    value      = optional(string)
  })
  default = null
}

variable "lastModifiedDateTime" {
  description = "Time when the BrandingProfile was last modified"
  type        = string
  default     = null
}

variable "lightBackgroundLogo" {
  description = "Logo image displayed in Company Portal apps which have a light background behind the logo"
  type = object({
    odata_type = optional(string, "#microsoft.graph.mimeContent")
    type       = optional(string)
    value      = optional(string)
  })
  default = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.intuneBrandingProfile"
  nullable    = false
}

variable "onlineSupportSiteName" {
  description = "Display name of the company/organization’s IT helpdesk site"
  type        = string
  default     = null
}

variable "onlineSupportSiteUrl" {
  description = "URL to the company/organization’s IT helpdesk site"
  type        = string
  default     = null
}

variable "privacyUrl" {
  description = "URL to the company/organization’s privacy policy"
  type        = string
  default     = null
}

variable "profileDescription" {
  description = "Description of the profile"
  type        = string
  default     = null
}

variable "profileName" {
  description = "Name of the profile"
  type        = string
  default     = null
}

variable "roleScopeTagIds" {
  description = "List of scope tags assigned to the branding profile"
  type        = list(string)
  default     = null
}

variable "showAzureADEnterpriseApps" {
  description = "Boolean that indicates if AzureAD Enterprise Apps will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "showConfigurationManagerApps" {
  description = "Boolean that indicates if Configuration Manager Apps will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "showDisplayNameNextToLogo" {
  description = "Boolean that represents whether the administrator-supplied display name will be shown next to the logo image or not"
  type        = bool
  default     = null
}

variable "showLogo" {
  description = "Boolean that represents whether the administrator-supplied logo images are shown or not"
  type        = bool
  default     = null
}

variable "showOfficeWebApps" {
  description = "Boolean that indicates if Office WebApps will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "themeColor" {
  description = "Primary theme color used in the Company Portal applications and web portal"
  type = object({
    odata_type = optional(string, "#microsoft.graph.rgbColor")
    b          = optional(number)
    g          = optional(number)
    r          = optional(number)
  })
  default = null
}

variable "themeColorLogo" {
  description = "Logo image displayed in Company Portal apps which have a theme color background behind the logo"
  type = object({
    odata_type = optional(string, "#microsoft.graph.mimeContent")
    type       = optional(string)
    value      = optional(string)
  })
  default = null
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
