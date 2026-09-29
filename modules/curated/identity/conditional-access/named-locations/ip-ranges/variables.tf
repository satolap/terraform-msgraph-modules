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
  description = "Microsoft Graph API version. One of \"v1.0\" or \"beta\"."
  type        = string
  default     = "v1.0"
  nullable    = false

  validation {
    condition     = contains(["v1.0", "beta"], var.api_version)
    error_message = "api_version must be one of \"v1.0\" or \"beta\"."
  }
}
