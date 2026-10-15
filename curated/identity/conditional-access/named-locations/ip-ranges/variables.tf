variable "display_name" {
  description = "Display name of the IP named location."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.display_name)) > 0
    error_message = "display_name must not be empty."
  }
}

variable "ip_ranges" {
  description = "Public IPv4 and IPv6 ranges in canonical CIDR notation, for example 192.0.2.0/24 or 2001:db8::/48. Canonical means the value cidrsubnet(range, 0, 0) returns: host bits zero, IPv6 lower-case and compressed. Order carries no meaning."
  type        = set(string)
  nullable    = false

  validation {
    condition     = length(var.ip_ranges) >= 1 && length(var.ip_ranges) <= 2000
    error_message = "ip_ranges must contain between 1 and 2000 ranges; Microsoft Entra accepts at most 2000 IP ranges per named location."
  }

  validation {
    condition     = alltrue([for r in var.ip_ranges : can(cidrsubnet(r, 0, 0))])
    error_message = "Every ip_ranges entry must be an IPv4 or IPv6 range in CIDR notation, for example 192.0.2.0/24 or 2001:db8::/48."
  }

  validation {
    condition     = alltrue([for r in var.ip_ranges : try(tonumber(split("/", r)[1]) > 8, false)])
    error_message = "Every ip_ranges entry must use a prefix longer than /8; Microsoft Entra accepts only CIDR masks greater than /8."
  }

  validation {
    condition     = alltrue([for r in var.ip_ranges : try(cidrsubnet(r, 0, 0) == r, false)])
    error_message = "Every ip_ranges entry must be canonical, exactly the value cidrsubnet(range, 0, 0) returns: host bits zero, IPv6 lower-case and compressed (for example 192.0.2.0/24, not 192.0.2.10/24)."
  }
}

variable "is_trusted" {
  description = "Whether the location is marked as trusted. Microsoft Entra refuses to delete a trusted location, so apply is_trusted = false before you destroy the module or remove it from the configuration. Untrusting also changes every policy that includes or excludes AllTrusted, which Terraform cannot see; check those policies first (README)."
  type        = bool
  default     = false
  nullable    = false
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
