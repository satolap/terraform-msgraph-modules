variable "assignments" {
  description = "The list of group assignments for the branding profile"
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.intuneBrandingProfileAssignment")
    target     = optional(any)
  }))
  default = null
}

variable "company_portal_blocked_actions" {
  description = "Collection of blocked actions on the company portal as per platform and device ownership types."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.companyPortalBlockedAction")
    action     = optional(string)
    ownerType  = optional(string)
    platform   = optional(string)
  }))
  default = null
}

variable "contact_it_email_address" {
  description = "E-mail address of the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "contact_it_name" {
  description = "Name of the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "contact_it_notes" {
  description = "Text comments regarding the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "contact_it_phone_number" {
  description = "Phone number of the person/organization responsible for IT support"
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "Time when the BrandingProfile was created"
  type        = string
  default     = null
}

variable "custom_can_see_privacy_message" {
  description = "Text comments regarding what the admin has access to on the device"
  type        = string
  default     = null
}

variable "custom_cant_see_privacy_message" {
  description = "Text comments regarding what the admin doesn't have access to on the device"
  type        = string
  default     = null
}

variable "custom_privacy_message" {
  description = "Text comments regarding what the admin doesn't have access to on the device"
  type        = string
  default     = null
}

variable "disable_client_telemetry" {
  description = "Applies to telemetry sent from all clients to the Intune service. When disabled, all proactive troubleshooting and issue warnings within the client are turned off, and telemetry settings appear inactive or hidden to the device user."
  type        = bool
  default     = null
}

variable "disable_device_category_selection" {
  description = "Boolean that indicates if Device Category Selection will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "display_name" {
  description = "Company/organization name that is displayed to end users"
  type        = string
  default     = null
}

variable "enrollment_availability" {
  description = "Options available for enrollment flow customization"
  type        = string
  default     = null

  validation {
    condition     = var.enrollment_availability == null ? true : contains(["availableWithPrompts", "availableWithoutPrompts", "unavailable"], var.enrollment_availability)
    error_message = "enrollment_availability must be one of the documented enum values."
  }
}

variable "is_default_profile" {
  description = "Boolean that represents whether the profile is used as default or not"
  type        = bool
  default     = null
}

variable "is_factory_reset_disabled" {
  description = "Boolean that represents whether the adminsistrator has disabled the 'Factory Reset' action on corporate owned devices."
  type        = bool
  default     = null
}

variable "is_remove_device_disabled" {
  description = "Boolean that represents whether the adminsistrator has disabled the 'Remove Device' action on corporate owned devices."
  type        = bool
  default     = null
}

variable "landing_page_customized_image" {
  description = "Customized image displayed in Company Portal apps landing page"
  type        = any
  default     = null
}

variable "last_modified_date_time" {
  description = "Time when the BrandingProfile was last modified"
  type        = string
  default     = null
}

variable "light_background_logo" {
  description = "Logo image displayed in Company Portal apps which have a light background behind the logo"
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.intuneBrandingProfile"
  nullable    = false
}

variable "online_support_site_name" {
  description = "Display name of the company/organization’s IT helpdesk site"
  type        = string
  default     = null
}

variable "online_support_site_url" {
  description = "URL to the company/organization’s IT helpdesk site"
  type        = string
  default     = null
}

variable "privacy_url" {
  description = "URL to the company/organization’s privacy policy"
  type        = string
  default     = null
}

variable "profile_description" {
  description = "Description of the profile"
  type        = string
  default     = null
}

variable "profile_name" {
  description = "Name of the profile"
  type        = string
  default     = null
}

variable "role_scope_tag_ids" {
  description = "List of scope tags assigned to the branding profile"
  type        = list(string)
  default     = null
}

variable "show_azure_ad_enterprise_apps" {
  description = "Boolean that indicates if AzureAD Enterprise Apps will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "show_configuration_manager_apps" {
  description = "Boolean that indicates if Configuration Manager Apps will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "show_display_name_next_to_logo" {
  description = "Boolean that represents whether the administrator-supplied display name will be shown next to the logo image or not"
  type        = bool
  default     = null
}

variable "show_logo" {
  description = "Boolean that represents whether the administrator-supplied logo images are shown or not"
  type        = bool
  default     = null
}

variable "show_office_web_apps" {
  description = "Boolean that indicates if Office WebApps will be shown in Company Portal"
  type        = bool
  default     = null
}

variable "theme_color" {
  description = "Primary theme color used in the Company Portal applications and web portal"
  type        = any
  default     = null
}

variable "theme_color_logo" {
  description = "Logo image displayed in Company Portal apps which have a theme color background behind the logo"
  type        = any
  default     = null
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
