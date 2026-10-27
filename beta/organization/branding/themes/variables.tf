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
    odata_type = optional(string, "#microsoft.graph.organizationalBrandingThemeLocalization")
    accountResetCredentials = optional(object({
      odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")
      customText = optional(string)
      customUrl  = optional(string)
      isHidden   = optional(bool)
    }))
    backgroundImage = optional(string)
    bannerLogo      = optional(string)
    cannotAccessYourAccount = optional(object({
      odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")
      customText = optional(string)
      customUrl  = optional(string)
      isHidden   = optional(bool)
    }))
    contentCustomization = optional(object({
      odata_type = optional(string, "#microsoft.graph.contentCustomization")
      attributeCollection = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.keyValue")
        key        = optional(string)
        value      = optional(string)
      })))
      attributeCollectionRelativeUrl = optional(string)
      registrationCampaign = optional(list(object({
        odata_type = optional(string, "#microsoft.graph.keyValue")
        key        = optional(string)
        value      = optional(string)
      })))
      registrationCampaignRelativeUrl = optional(string)
    }))
    customCSS = optional(string)
    favicon   = optional(string)
    forgotMyPassword = optional(object({
      odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")
      customText = optional(string)
      customUrl  = optional(string)
      isHidden   = optional(bool)
    }))
    headerBackgroundColor = optional(string)
    headerLogo            = optional(string)
    locale                = optional(string)
    loginPageLayoutConfiguration = optional(object({
      odata_type         = optional(string, "#microsoft.graph.loginPageLayoutConfiguration")
      isFooterShown      = optional(bool)
      isHeaderShown      = optional(bool)
      layoutTemplateType = optional(string)
    }))
    pageBackgroundColor = optional(string)
    privacyAndCookies = optional(object({
      odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")
      customText = optional(string)
      customUrl  = optional(string)
      isHidden   = optional(bool)
    }))
    resetItNow = optional(object({
      odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")
      customText = optional(string)
      customUrl  = optional(string)
      isHidden   = optional(bool)
    }))
    signInPageText = optional(string)
    squareLogo     = optional(string)
    squareLogoDark = optional(string)
    termsOfUse = optional(object({
      odata_type = optional(string, "#microsoft.graph.loginPageBrandingVisualElement")
      customText = optional(string)
      customUrl  = optional(string)
      isHidden   = optional(bool)
    }))
    usernameHintText = optional(string)
  }))
  default   = null
  sensitive = true

  validation {
    condition     = (var.localizations == null ? true : alltrue([alltrue([for input0 in var.localizations : (input0 == null ? true : alltrue([(input0["loginPageLayoutConfiguration"] == null ? true : alltrue([(input0["loginPageLayoutConfiguration"]["layoutTemplateType"] == null ? true : alltrue([(input0["loginPageLayoutConfiguration"]["layoutTemplateType"] == null ? true : contains(["default", "verticalSplit"], input0["loginPageLayoutConfiguration"]["layoutTemplateType"]))]))]))]))])]))
    error_message = "localizations: nested required attributes must be non-null and enum values must be supported input members."
  }
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
