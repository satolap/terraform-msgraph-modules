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
  description = "Microsoft Graph API version. Only \"v1.0\" is supported; Microsoft does not support beta APIs in production."
  type        = string
  default     = "v1.0"
  nullable    = false

  validation {
    condition     = var.api_version == "v1.0"
    error_message = "api_version must be \"v1.0\"; only \"v1.0\" is supported."
  }
}

variable "timeouts" {
  description = "Timeouts for creating, reading, updating and deleting the named location, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete default to \"10m\" and must be at least \"15s\": after each request the provider waits for three consistent reads 5 seconds apart within the same timeout. read defaults to null, which keeps the provider's default read timeout. Retries count against these timeouts."
  type = object({
    create = optional(string, "10m")
    read   = optional(string)
    update = optional(string, "10m")
    delete = optional(string, "10m")
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null || (can(regex("^([0-9]+[hms])+$", t)) && !can(regex("^(0+[hms])+$", t)))
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\": after each request the provider waits for three consistent reads 5 seconds apart within the same timeout."
  }
}
