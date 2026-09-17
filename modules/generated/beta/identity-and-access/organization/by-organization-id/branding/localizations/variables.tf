variable "organization_id" {
  description = "The unique identifier of organization"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.organization_id)) > 0
    error_message = "organization_id must not be empty."
  }
}

variable "background_color" {
  description = "Color that appears in place of the background image in low-bandwidth connections. We recommend that you use the primary color of your banner logo or your organization color. Specify this in hexadecimal format, for example, white is #FFFFFF."
  type        = string
  default     = null
}

variable "background_image" {
  description = "Image that appears as the background of the sign-in page. The allowed types are PNG or JPEG not smaller than 300 KB and not larger than 1920 × 1080 pixels. A smaller image reduces bandwidth requirements and make the page load faster."
  type        = string
  default     = null
}

variable "banner_logo" {
  description = "A banner version of your company logo that appears on the sign-in page. The allowed types are PNG or JPEG not larger than 36 × 245 pixels. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "content_customization" {
  description = "Represents the content options to be customized throughout the authentication flow for a tenant. NOTE: Supported by Microsoft Entra ID for customers' tenants only."
  type        = any
  default     = null
}

variable "custom_account_reset_credentials_url" {
  description = "A custom URL for resetting account credentials. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128 characters."
  type        = string
  default     = null
  sensitive   = true
}

variable "custom_cannot_access_your_account_text" {
  description = "A string to replace the default 'Can't access your account?' self-service password reset (SSPR) hyperlink text on the sign-in page. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
}

variable "custom_cannot_access_your_account_url" {
  description = "A custom URL to replace the default URL of the self-service password reset (SSPR) 'Can't access your account?' hyperlink on the sign-in page. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128 characters. DO NOT USE. Use customAccountResetCredentialsUrl instead."
  type        = string
  default     = null
}

variable "custom_css" {
  description = "CSS styling that appears on the sign-in page. The allowed format is .css format only and not larger than 25 KB."
  type        = string
  default     = null
}

variable "custom_forgot_my_password_text" {
  description = "A string to replace the default 'Forgot my password' hyperlink text on the sign-in form. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
  sensitive   = true
}

variable "custom_privacy_and_cookies_text" {
  description = "A string to replace the default 'Privacy and Cookies' hyperlink text in the footer. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
}

variable "custom_privacy_and_cookies_url" {
  description = "A custom URL to replace the default URL of the 'Privacy and Cookies' hyperlink in the footer. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128 characters."
  type        = string
  default     = null
}

variable "custom_reset_it_now_text" {
  description = "A string to replace the default 'reset it now' hyperlink text on the sign-in form. This text must be in Unicode format and not exceed 256 characters. DO NOT USE: Customization of the 'reset it now' hyperlink text is currently not supported."
  type        = string
  default     = null
}

variable "custom_terms_of_use_text" {
  description = "A string to replace the the default 'Terms of Use' hyperlink text in the footer. This text must be in Unicode format and not exceed 256 characters."
  type        = string
  default     = null
}

variable "custom_terms_of_use_url" {
  description = "A custom URL to replace the default URL of the 'Terms of Use' hyperlink in the footer. This URL must be in ASCII format or non-ASCII characters must be URL encoded, and not exceed 128characters."
  type        = string
  default     = null
}

variable "favicon" {
  description = "A custom icon (favicon) to replace a default Microsoft product favicon on a Microsoft Entra tenant."
  type        = string
  default     = null
}

variable "header_background_color" {
  description = "The RGB color to apply to customize the color of the header."
  type        = string
  default     = null
}

variable "header_logo" {
  description = "A company logo that appears in the header of the sign-in page. The allowed types are PNG or JPEG not larger than 36 × 245 pixels. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "login_page_layout_configuration" {
  description = "Represents the layout configuration to be displayed on the login page for a tenant."
  type        = any
  default     = null
}

variable "login_page_text_visibility_settings" {
  description = "Represents the various texts that can be hidden on the login page for a tenant."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.organizationalBrandingLocalization"
  nullable    = false
}

variable "sign_in_page_text" {
  description = "Text that appears at the bottom of the sign-in box. Use this to communicate additional information, such as the phone number to your help desk or a legal statement. This text must be in Unicode format and not exceed 1024 characters."
  type        = string
  default     = null
}

variable "square_logo" {
  description = "A square version of your company logo that appears in Windows 10 out-of-box experiences (OOBE) and when Windows Autopilot is enabled for deployment. Allowed types are PNG or JPEG not larger than 240 x 240 pixels and not more than 10 KB in size. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "square_logo_dark" {
  description = "A square dark version of your company logo that appears in Windows 10 out-of-box experiences (OOBE) and when Windows Autopilot is enabled for deployment. Allowed types are PNG or JPEG not larger than 240 x 240 pixels and not more than 10 KB in size. We recommend using a transparent image with no padding around the logo."
  type        = string
  default     = null
}

variable "username_hint_text" {
  description = "A string that shows as the hint in the username textbox on the sign-in screen. This text must be a Unicode, without links or code, and can't exceed 64 characters."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["backgroundImageRelativeUrl", "bannerLogoRelativeUrl", "cdnList", "customCSSRelativeUrl", "faviconRelativeUrl", "headerLogoRelativeUrl", "id", "squareLogoDarkRelativeUrl", "squareLogoRelativeUrl"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
