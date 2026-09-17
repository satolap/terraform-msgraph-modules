variable "organization_id" {
  description = "The unique identifier of organization"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.organization_id)) > 0
    error_message = "organization_id must not be empty."
  }
}

variable "is_default_theme" {
  description = "Indicates whether the theme is set as the default branding theme for the entire tenant and includes all applications within the tenant. When set to true, this theme is automatically applied to any application that does not have a specific theme assigned. This property is useful for enforcing consistent branding across multiple apps without configuring each one individually. Optional."
  type        = bool
  default     = null
}

variable "localizations" {
  description = "Represents a locale-based branding theme."
  type = list(object({
    odata_type                   = optional(string, "#microsoft.graph.organizationalBrandingThemeLocalization")
    accountResetCredentials      = optional(any)
    backgroundImage              = optional(string)
    bannerLogo                   = optional(string)
    cannotAccessYourAccount      = optional(any)
    contentCustomization         = optional(any)
    customCSS                    = optional(string)
    favicon                      = optional(string)
    forgotMyPassword             = optional(any)
    headerBackgroundColor        = optional(string)
    headerLogo                   = optional(string)
    locale                       = optional(string)
    loginPageLayoutConfiguration = optional(any)
    pageBackgroundColor          = optional(string)
    privacyAndCookies            = optional(any)
    resetItNow                   = optional(any)
    signInPageText               = optional(string)
    squareLogo                   = optional(string)
    squareLogoDark               = optional(string)
    termsOfUse                   = optional(any)
    usernameHintText             = optional(string)
  }))
  default   = null
  sensitive = true
}

variable "name" {
  description = "The name of the branding theme. Up to 120 characters. Required."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.organizationalBrandingTheme"
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
