variable "display_name" {
  description = "Display name of the country named location."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }
}

variable "countries_and_regions" {
  description = "Two-letter upper-case country or region codes, for example [\"CA\", \"IN\"]. Order carries no meaning."
  type        = set(string)
  nullable    = false

  validation {
    condition     = length(var.countries_and_regions) >= 1
    error_message = "countries_and_regions must contain at least one code."
  }

  validation {
    condition     = alltrue([for c in var.countries_and_regions : can(regex("^[A-Z]{2}$", c))])
    error_message = "Every countries_and_regions entry must be a two-letter upper-case code, for example \"CA\"."
  }
}

variable "include_unknown_countries_and_regions" {
  description = "Whether IP addresses that don't map to a country or region are included in the location."
  type        = bool
  default     = false
  nullable    = false
}

variable "country_lookup_method" {
  description = "How the country or region is determined: \"clientIpAddress\" (default) or \"authenticatorAppGps\". GPS lookup prompts users in the Microsoft Authenticator app every hour, also for report-only policies. The update API does not list this property, so a change replaces the location."
  type        = string
  default     = "clientIpAddress"
  nullable    = false

  validation {
    condition     = contains(["clientIpAddress", "authenticatorAppGps"], var.country_lookup_method)
    error_message = "country_lookup_method must be one of \"clientIpAddress\" or \"authenticatorAppGps\"."
  }
}

variable "api_version" {
  description = "Microsoft Graph API version. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"
  nullable    = false

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
