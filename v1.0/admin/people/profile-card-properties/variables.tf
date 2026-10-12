variable "annotations" {
  description = "Allows an administrator to set a custom display label for the directory property and localize it for the users in their tenant."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.profileCardAnnotation")
    displayName = optional(string)
    localizations = optional(list(object({
      odata_type  = optional(string, "#microsoft.graph.displayNameLocalization")
      displayName = optional(string)
      languageTag = optional(string)
    })))
  }))
  default = null
}

variable "directory_property_name" {
  description = "Identifies a profileCardProperty resource in Get, Update, or Delete operations. Allows an administrator to surface hidden Microsoft Entra ID properties on the Microsoft 365 profile card within their tenant. When present, the Microsoft Entra ID field referenced in this property is visible to all users in your tenant on the contact pane of the profile card. Allowed values for this field are: UserPrincipalName, Fax, StreetAddress, PostalCode, StateOrProvince, Alias, CustomAttribute1,  CustomAttribute2, CustomAttribute3, CustomAttribute4, CustomAttribute5, CustomAttribute6, CustomAttribute7, CustomAttribute8, CustomAttribute9, CustomAttribute10, CustomAttribute11, CustomAttribute12, CustomAttribute13, CustomAttribute14, CustomAttribute15."
  type        = string
  default     = null
}

variable "is_visible" {
  description = "Indicates whether the given directory property should be shown on a user’s profile card."
  type        = bool
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.profileCardProperty"
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
