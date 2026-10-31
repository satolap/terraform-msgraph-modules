variable "organization-id" {
  description = "The unique identifier of organization"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.organization-id)) > 0
    error_message = "organization-id must not be empty."
  }
}

variable "backgroundColor" {
  description = "Color that appears in place of the background image in low-bandwidth connections. We recommend that you use the primary color of your banner logo or your organization color. Specify this in hexadecimal format, for example, white is #FFFFFF."
  type        = string
  default     = null
}

variable "backgroundImage" {
  description = "Image that appears as the background of the sign-in page. The allowed types are PNG or JPEG not smaller than 300 KB and not larger than 1920 × 1080 pixels. A smaller image reduces bandwidth requirements and make the page load faster."
  type        = string
  default     = null
}

variable "bannerLogo" {
  description = "A banner version of your company logo that appears on the sign-in page. The allowed types are PNG or JPEG not larger than 36 × 245 pixels. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "contentCustomization" {
  description = "Represents the content options to be customized throughout the authentication flow for a tenant. NOTE: Supported by Microsoft Entra External ID in external tenants only."
  type = object({
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
  })
  default = null
}

variable "customAccountResetCredentialsUrl" {
  description = "A custom URL for resetting account credentials. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128 characters."
  type        = string
  default     = null
  sensitive   = true
}

variable "customCSS" {
  description = "CSS styling that appears on the sign-in page. The allowed format is .css format only and not larger than 25 KB."
  type        = string
  default     = null
}

variable "customCannotAccessYourAccountText" {
  description = "A string to replace the default 'Can't access your account?' self-service password reset (SSPR) hyperlink text on the sign-in page. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
}

variable "customCannotAccessYourAccountUrl" {
  description = "A custom URL to replace the default URL of the self-service password reset (SSPR) 'Can't access your account?' hyperlink on the sign-in page. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128 characters. DO NOT USE. Use customAccountResetCredentialsUrl instead."
  type        = string
  default     = null
}

variable "customForgotMyPasswordText" {
  description = "A string to replace the default 'Forgot my password' hyperlink text on the sign-in form. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
  sensitive   = true
}

variable "customPrivacyAndCookiesText" {
  description = "A string to replace the default 'Privacy and Cookies' hyperlink text in the footer. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
}

variable "customPrivacyAndCookiesUrl" {
  description = "A custom URL to replace the default URL of the 'Privacy and Cookies' hyperlink in the footer. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128 characters."
  type        = string
  default     = null
}

variable "customResetItNowText" {
  description = "A string to replace the default 'reset it now' hyperlink text on the sign-in form. This text must be in Unicode format and not exceed 256 characters. DO NOT USE: Customization of the 'reset it now' hyperlink text is currently not supported."
  type        = string
  default     = null
}

variable "customTermsOfUseText" {
  description = "A string to replace the the default 'Terms of Use' hyperlink text in the footer. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
}

variable "customTermsOfUseUrl" {
  description = "A custom URL to replace the default URL of the 'Terms of Use' hyperlink in the footer. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128characters."
  type        = string
  default     = null
}

variable "favicon" {
  description = "A custom icon (favicon) to replace a default Microsoft product favicon on a Microsoft Entra tenant."
  type        = string
  default     = null
}

variable "headerBackgroundColor" {
  description = "The RGB color to apply to customize the color of the header."
  type        = string
  default     = null
}

variable "headerLogo" {
  description = "A company logo that appears in the header of the sign-in page. The allowed types are PNG or JPEG not larger than 36 × 245 pixels. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "loginPageLayoutConfiguration" {
  description = "Represents the layout configuration to be displayed on the login page for a tenant."
  type = object({
    odata_type         = optional(string, "#microsoft.graph.loginPageLayoutConfiguration")
    isFooterShown      = optional(bool)
    isHeaderShown      = optional(bool)
    layoutTemplateType = optional(string)
  })
  default = null

  validation {
    condition     = (var.loginPageLayoutConfiguration == null ? true : alltrue([(var.loginPageLayoutConfiguration["layoutTemplateType"] == null ? true : alltrue([(var.loginPageLayoutConfiguration["layoutTemplateType"] == null ? true : contains(["default", "verticalSplit"], var.loginPageLayoutConfiguration["layoutTemplateType"]))]))]))
    error_message = "loginPageLayoutConfiguration: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "loginPageTextVisibilitySettings" {
  description = "Represents the various texts that can be hidden on the login page for a tenant."
  type = object({
    odata_type                  = optional(string, "#microsoft.graph.loginPageTextVisibilitySettings")
    hideAccountResetCredentials = optional(bool)
    hideCannotAccessYourAccount = optional(bool)
    hideForgotMyPassword        = optional(bool)
    hidePrivacyAndCookies       = optional(bool)
    hideResetItNow              = optional(bool)
    hideTermsOfUse              = optional(bool)
  })
  default   = null
  sensitive = true
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.organizationalBrandingLocalization"
  nullable    = false
}

variable "signInPageText" {
  description = "Text that appears at the bottom of the sign-in box. Use this to communicate additional information, such as the phone number to your help desk or a legal statement. This text must be in Unicode format and not exceed 1024 characters."
  type        = string
  default     = null
}

variable "squareLogo" {
  description = "A square version of your company logo that appears in Windows 10 out-of-box experiences (OOBE) and when Windows Autopilot is enabled for deployment. Allowed types are PNG or JPEG not larger than 240 x 240 pixels and not more than 10 KB in size. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "squareLogoDark" {
  description = "A square dark version of your company logo that appears in Windows 10 out-of-box experiences (OOBE) and when Windows Autopilot is enabled for deployment. Allowed types are PNG or JPEG not larger than 240 x 240 pixels and not more than 10 KB in size. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "usernameHintText" {
  description = "A string that shows as the hint in the username textbox on the sign-in screen. This text must be a Unicode, without links or code, and can't exceed 64 characters."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["backgroundImageRelativeUrl", "bannerLogoRelativeUrl", "cdnList", "customCSSRelativeUrl", "faviconRelativeUrl", "headerLogoRelativeUrl", "id", "squareLogoDarkRelativeUrl", "squareLogoRelativeUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
